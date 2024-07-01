import 'dart:developer';

import 'package:bangli_service_center_bloc/core/api_provider/api_provider.dart';
import 'package:bangli_service_center_bloc/core/return_response/return_response.dart';
import 'package:bangli_service_center_bloc/src/common/path_api.dart';
import 'package:bangli_service_center_bloc/src/data/datasource/local_data/local_data_source.dart';
import 'package:bangli_service_center_bloc/src/data/datasource/remote_data/api_data_source.dart';
import 'package:bangli_service_center_bloc/src/data/model/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/api_response/api_response.dart';
import '../../model/token_model.dart';

class ApiDataSourceImpl implements ApiDataSource {
  final LocalDataSource localDataSource;
  final ApiProvider apiProvider;
  ApiDataSourceImpl(this.localDataSource, this.apiProvider);

  @override
  Future<ReturnResponseModel> getVendorWithComplaintCount() async {
    ReturnResponseModel getToken = await localDataSource.getUserToken();
    if (!getToken.status!) {
      return getToken;
    }

    TokenModel token = getToken.data;
    // String fcmToken = await FirebaseApi.firebaseApi.getFcmToken();
    // log('fcm token to store : $fcmToken');
    // if (fcmToken == '') {
    //   log('Error fcm token tidak ada :: error get fcm token');
    //   return ReturnResponseModel(message: 'Token fcm tidak ditemukan');
    // }

    ApiResponseModel responseStore = await apiProvider.put(
      dotenv.env['STORE_TOKEN_FCM'].toString(),
      isUseToken: true,
      token: token.accessToken,
      body: {
        'fcm_token': "fcmTokenTest",
      },
    );

    if (!responseStore.isSuccess!) {
      return ReturnResponseModel(message: responseStore.errorMessage);
    }

    return ReturnResponseModel(
      message: "Success store fcm token",
      status: true,
    );
  }

  @override
  Future<ReturnResponseModel> login(
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
        TokenModel token = TokenModel.fromJson(apiRes.data);

        ReturnResponseModel storeToken =
            await localDataSource.auth(token.accessToken!, token.refreshToken!);

        if (storeToken.status == false) {
          return ReturnResponseModel.failed("Gagal Store Token");
        }
        return ReturnResponseModel.success("Sukses Login");
      }

      return ReturnResponseModel.failed(apiRes.errorMessage!);
    } catch (e) {
      return ReturnResponseModel.failed("Failed catch : $e");
    }
  }

  @override
  Future<ReturnResponseModel<UserModel>> getUserDetail() async {
    await Future.delayed(const Duration(milliseconds: 800));
    ReturnResponseModel<TokenModel> getToken =
        await localDataSource.getUserToken();
    if (getToken.status == false) {
      return ReturnResponseModel.failed("Token tidak ditemukan");
    }

    ApiResponseModel apiRes = await apiProvider.get(
      PathApi.getUser,
      isUseToken: true,
      token: getToken.data!.accessToken,
    );

    log("aman kah get user ?");

    if (apiRes.isSuccess == false) {
      return ReturnResponseModel.failed(apiRes.errorMessage);
    }

    return ReturnResponseModel.successWDataNFunc(
      message: apiRes.message!,
      json: apiRes.data,
      createObject: (map) => UserModel.fromJson(map),
    );
  }

  @override
  Future<ReturnResponseModel> autoLogin() async {
    try {
      // check token yang ada di database lokal masih bisa dipakai atau tidak
      ReturnResponseModel checkToken = await getUserDetail();
      // jika berhasil retrun sukses
      // jika gagal baru coba menggunakan refresh token
      if (checkToken.status == true) {
        return checkToken;
      }

      ReturnResponseModel<TokenModel> getToken =
          await localDataSource.getUserToken();
      if (getToken.status == false) {
        return getToken;
      }

      // coba update token dengan refreshtoken
      ApiResponseModel res = await apiProvider.post(PathApi.refresh,
          body: {'refresh_token': getToken.data!.refreshToken});

      if (res.isSuccess == false) {
        return ReturnResponseModel.failed(res.errorMessage);
      }

      return ReturnResponseModel.success("Sukses login dan ubah token");
    } catch (e) {
      log("error catch auto login : $e");
      return ReturnResponseModel.failed("Error catch auto login : $e");
    }
  }
}
