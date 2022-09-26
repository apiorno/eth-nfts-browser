import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:eth_nfts_browser/core/error/failures.dart';
import 'package:eth_nfts_browser/core/usecases/usecase.dart';
import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:eth_nfts_browser/features/home/domain/repositories/nfts_repository.dart';

class GetAllNfts implements UseCase<List<NonFungibleTokenBehavior>, Params> {
  final NftsRepositoryBehavior repository;
  GetAllNfts(this.repository);

  Future<Either<Failure, List<NonFungibleTokenBehavior>>> call(
          Params params) async =>
      await repository.getAllNftsOwnedBy(params.address);
}

class Params extends Equatable {
  final String address;
  const Params({required this.address});
  @override
  List<Object?> get props => [address];
}
