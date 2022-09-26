import 'package:eth_nfts_browser/core/error/error.dart';
import 'package:eth_nfts_browser/core/platform/network_info.dart';
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_local_data_source.dart';
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_remote_data_source.dart';
import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:eth_nfts_browser/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:eth_nfts_browser/features/home/domain/repositories/nfts_repository.dart';

class NftsRepository implements NftsRepositoryBehavior {
  final NftsRemoteDataSource remoteDataSource;
  final NftsLocalDataSourceBehavior localDataSource;
  final NetworkInfoBehavior networkInfo;

  NftsRepository(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});
  @override
  Future<Either<Failure, List<NonFungibleTokenBehavior>>> getAllNftsOwnedBy(
      String ethereumAddress) async {
    try {
      final localNfts =
          await localDataSource.getAllNftsOwnedBy(ethereumAddress);
      if (localNfts.isNotEmpty) return Right(localNfts);
      if (!await networkInfo.isConnected) return Left(ClientFailure());
      final remoteNfts =
          await remoteDataSource.getAllNftsOwnedBy(ethereumAddress);
      localDataSource.cacheNftsOwnership(ethereumAddress, remoteNfts);
      return Right(remoteNfts);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
