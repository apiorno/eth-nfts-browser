import 'package:dartz/dartz.dart';
import 'package:eth_nfts_browser/core/error/failures.dart';
import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';

abstract class NftsRepositoryBehavior {
  Future<Either<Failure, List<NonFungibleToken>>> getAllNftsOwnedBy(
      String ethereumAddress);
}
