import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class PathApi {
  const PathApi._();
  // -------------- BASE PATH API -----------------
  static const _baseApi = 'api/v1';
  // ----------------- PATH API -------------------
  static final auth = _baseApi + _getApi("AUTH");
  static final refresh = _baseApi + _getApi("REFRESH");
  static final createUser = _baseApi + _getApi("CREATE_USER");
  static final getUser = _baseApi + _getApi("GET_USER");
  static final createComplaint = _baseApi + _getApi("CREATE_COMPLAINT");
  static final checkUserExist = _baseApi + _getApi("CHECK_USER_EXIST");
  static final updatePassword = _baseApi + _getApi("UPDATE_PASSWORD");
  static final updatePasswordForgot =
      _baseApi + _getApi("UPDATE_PASSWORD_FORGOT");
  static final updateProfile = _baseApi + _getApi("UPDATE_PROFILE");

  // ***  COMPLAINT ****
  static final getVendorWithComplainCount =
      _baseApi + _getApi("GET_VENDOR_WITH_COMPLAINT_COUNT");
  static final getAllVendor = _baseApi + _getApi("GET_ALL_VENDOR");

  // !!! URL API !!! ///
  static final urlApi = _getUrlAPIDevOrProd("URL_API");
}

String _getUrlAPIDevOrProd(String nameApi) {
  String dev = _getApi("DEV");
  if (dev == 'benar') {
    return '${dotenv.env["${nameApi}_DEV"]}';
  } else {
    return dotenv.env[nameApi].toString();
  }
}

String _getApi(String nameApi) {
  return dotenv.env[nameApi].toString();
}
