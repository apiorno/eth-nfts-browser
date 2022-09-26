import 'package:eth_nfts_browser/features/home/data/models/non_fungible_token_model.dart';

abstract class NftsRemoteDataSource {
  /// Calls the https://api.poap.xyz/actions/scan/<address> endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<NonFungibleToken>> getAllNftsOwnedBy(String ethereumAddress);
}
