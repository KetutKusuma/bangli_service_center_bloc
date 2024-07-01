import 'package:bangli_service_center_bloc/core/api_provider/api_provider.dart';
import 'package:bangli_service_center_bloc/src/data/datasource/local_data/local_data_source.dart';
import 'package:bangli_service_center_bloc/src/data/datasource/remote_data/api_data_source.dart';
import 'package:bangli_service_center_bloc/src/data/datasource/remote_data/api_data_source_impl.dart';
import 'package:bangli_service_center_bloc/src/data/repositories/remote_data_source_impl.dart';
import 'package:bangli_service_center_bloc/src/domain/repositories/remote_data_source.dart';
import 'package:bangli_service_center_bloc/src/domain/usecases/auto_login_case.dart';
import 'package:bangli_service_center_bloc/src/domain/usecases/login_case.dart';
import 'package:bangli_service_center_bloc/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ======= bloc ========

  sl.registerFactory<AuthBloc>(
      () => AuthBloc(logInCase: sl(), autoLoginCase: sl()));

  // ======= use case =======
  sl.registerLazySingleton<AutoLoginCase>(() => AutoLoginCase(sl()));
  sl.registerLazySingleton<LogInCase>(() => LogInCase(sl()));

  // ======= repository ======

  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(sl()));

  // ====== data source =====
  sl.registerLazySingleton<ApiDataSource>(() => ApiDataSourceImpl(
        sl(),
        sl(),
      ));
  // ** local *******
  sl.registerLazySingleton(() => LocalDataSource());
  // ** remote *******
  sl.registerLazySingleton(() => ApiProvider());
}
