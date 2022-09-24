import 'package:dartz/dartz.dart';
import 'package:eth_nfts_browser/core/error/failures.dart';
import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:eth_nfts_browser/features/home/domain/repositories/nfts_repository.dart';

class GetAllNfts {
  final NftsRepositoryBehavior repository;
  GetAllNfts(this.repository);

  Future<Either<Failure, List<NonFungibleToken>>> call(
          {required String address}) async =>
      await repository.getAllNftsOwnedBy(address);
}
