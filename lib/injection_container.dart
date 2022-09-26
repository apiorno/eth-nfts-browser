import 'package:eth_nfts_browser/core/platform/network_info.dart';
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_local_data_source.dart';
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_remote_data_source.dart';
import 'package:eth_nfts_browser/features/home/data/repositories/nfts_repository.dart';
import 'package:eth_nfts_browser/features/home/domain/repositories/nfts_repository.dart';
import 'package:eth_nfts_browser/features/home/domain/usecases/get_all_nfts.dart';
import 'package:eth_nfts_browser/features/home/presentation/bloc/bloc/non_fungible_token_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Non Fungible Tokens
  //Bloc
  sl.registerFactory(
    () => NonFungibleTokenBloc(
      getAllNfts: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllNfts(sl()));

  // Repository
  sl.registerLazySingleton<NftsRepositoryBehavior>(
    () => NftsRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

// Data sources
  sl.registerLazySingleton<NftsRemoteDataSourceBehavior>(
    () => NftsRemoteDataSource(client: sl()),
  );

  sl.registerLazySingleton<NftsLocalDataSourceBehavior>(
    () => NftsLocalDataSource(sharedPreferences: sl()),
  );

  //! Core
  sl.registerLazySingleton<NetworkInfoBehavior>(() => NetworkInfo(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
