import 'dart:developer';

import 'package:bangli_service_center_bloc/core/api_provider/api_provider.dart';
import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:bangli_service_center_bloc/src/common/path_api.dart';
import 'package:bangli_service_center_bloc/src/data/datasource/local_data/local_data_source.dart';
import 'package:bangli_service_center_bloc/src/data/datasource/remote_data/api_data_source.dart';
import 'package:bangli_service_center_bloc/src/data/model/user_model.dart';
import 'package:bangli_service_center_bloc/src/utilities/get_current_location.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/api_response/api_response.dart';
import '../../model/token_model.dart';

class ApiDataSourceImpl implements ApiDataSource {
  final LocalDataSource localDataSource;
  final ApiProvider apiProvider;
  ApiDataSourceImpl(this.localDataSource, this.apiProvider);

  @override
  Future<ReturnResponse> getVendorWithComplaintCount() async {
    ReturnResponse getToken = await localDataSource.getUserToken();
    if (!getToken.status) {
      return getToken;
    }

    TokenModel token = getToken.data;
    // String fcmToken = await FirebaseApi.firebaseApi.getFcmToken();
    // log('fcm token to store : $fcmToken');
    // if (fcmToken == '') {
    //   log('Error fcm token tidak ada :: error get fcm token');
    //   return ReturnResponse(message: 'Token fcm tidak ditemukan');
    // }

    ApiResponseModel responseStore = await apiProvider.put(
      dotenv.env['STORE_TOKEN_FCM'].toString(),
      isUseToken: true,
      token: token.accessToken,
      body: {
        'fcm_token': "fcmTokenTest",
      },
    );

    if (!responseStore.isSuccess) {
      return ReturnResponse(message: responseStore.errorMessage);
    }

    return ReturnResponse(
      message: "Success store fcm token",
      status: true,
    );
  }

  @override
  Future<ReturnResponse> login(
      {required String phone, required String password}) async {
    try {
      final apiProviderr = ApiProvider();
      ApiResponseModel apiRes = await apiProviderr.post(
        PathApi.auth,
        body: {
          'phone': phone,
          'password': password,
        },
      );

      if (apiRes.isSuccess == true) {
        TokenModel token = TokenModel.fromJsonAPI(apiRes.data);
        ReturnResponse storeToken =
            await localDataSource.auth(token.accessToken!, token.refreshToken!);
        if (storeToken.status == false) {
          return ReturnResponse.failed("Gagal Store Token");
        }
        return ReturnResponse.success("Sukses Login");
      }

      return ReturnResponse.failed(apiRes.errorMessage!);
    } catch (e) {
      return ReturnResponse.failed("Failed catch login : $e");
    }
  }

  @override
  Future<ReturnResponse<UserModel>> getUserDetail() async {
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      ReturnResponse<TokenModel> getToken =
          await localDataSource.getUserToken();
      if (getToken.status == false) {
        return ReturnResponse.failed("Token tidak ditemukan");
      }

      ApiResponseModel apiRes = await apiProvider.get(
        PathApi.getUser,
        isUseToken: true,
        token: getToken.data!.accessToken,
      );

      if (apiRes.isSuccess == false) {
        return ReturnResponse.failed(apiRes.errorMessage);
      }

      return ReturnResponse.successWDataNFunc(
        message: apiRes.message!,
        json: apiRes.data,
        createObject: (map) => UserModel.fromJson(map),
      );
    } catch (e) {
      log("error catch get user detail : $e");
      return ReturnResponse.failed("Error catch get user detail : $e");
    }
  }

  @override
  Future<ReturnResponse> autoLogin() async {
    try {
      // check token yang ada di database lokal masih bisa dipakai atau tidak
      ReturnResponse checkToken = await getUserDetail();
      log("check token local : $checkToken");
      // jika berhasil retrun sukses
      // jika gagal baru coba menggunakan refresh token
      if (checkToken.status == true) {
        return checkToken;
      }

      ReturnResponse<TokenModel> getToken =
          await localDataSource.getUserToken();
      if (getToken.status == false) {
        return getToken;
      }

      // coba update token dengan refreshtoken
      ApiResponseModel res = await apiProvider.post(
        PathApi.refresh,
        body: {
          'refresh_token': getToken.data!.refreshToken,
        },
      );

      if (res.isSuccess == false) {
        return ReturnResponse.failed(res.errorMessage);
      }

      return ReturnResponse.success("Sukses login dan ubah token");
    } catch (e) {
      log("error catch auto login : $e");
      return ReturnResponse.failed("Error catch auto login : $e");
    }
  }

  @override
  Future<ReturnResponse> createComplaint({required String idVendor}) async {
    try {
      ReturnResponse<TokenModel> token = await localDataSource.getUserToken();
      if (token.status == false) {
        return token;
      }

      ReturnResponse<LatLng> loc = await getCurrentLocation();
      log("location : $loc");
      if (!loc.status) {
        return loc;
      }

      ApiResponseModel res = await apiProvider.post(
        PathApi.createComplaint,
        isUseToken: true,
        token: token.data!.accessToken,
        body: {
          "id_vendor": idVendor,
          "lat": loc.data!.latitude.toString(),
          "long": loc.data!.longitude.toString(),
        },
      );

      if (!res.isSuccess) {
        return ReturnResponse.failed(res.errorMessage!);
      }

      return ReturnResponse.success(res.message ?? "Sukses bang");
    } catch (e) {
      log("error catch create complaint : $e");
      return ReturnResponse.failed("Error catch create complaint : $e");
    }
  }
}
