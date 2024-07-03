import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_challenge/core/configs.dart';
import 'package:tractian_challenge/core/http_service.dart';
import 'package:tractian_challenge/data/repository/asset_repository.dart';
import 'package:tractian_challenge/screens/home_screen/home_bloc.dart';
import 'package:tractian_challenge/screens/tree_screen/tree_bloc.dart';

enum Environment { production, staging, local, unknown }

final _getIt = GetIt.instance;
Future<void> setup(Config config) async {
  await _configsInitialize(config);
  _repositoryInitialize();
  _blocInitialize();
}

void _repositoryInitialize() {
  _getIt.registerSingleton<AssetRepository>(AssetRepository(_getIt()));
}

void _blocInitialize() {
  _getIt.registerFactory<HomeBloc>(() => HomeBloc(_getIt()));
  _getIt.registerFactory<TreeBloc>(() => TreeBloc(_getIt()));
}

Future<void> _configsInitialize(Config config) async {
  Dio dio = Dio();
  _getIt.registerSingleton<HttpService>(DioService(dio, config));
}
