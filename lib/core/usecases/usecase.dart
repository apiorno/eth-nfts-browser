import 'package:dartz/dartz.dart';
import 'package:eth_nfts_browser/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
