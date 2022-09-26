import 'dart:convert';

import 'package:eth_nfts_browser/core/error/error.dart';
import 'package:eth_nfts_browser/features/home/data/models/non_fungible_token_model.dart';
import 'package:http/http.dart' as http;

abstract class NftsRemoteDataSourceBehavior {
  /// Calls the https://api.poap.xyz/actions/scan/<address> endpoint
  ///
  /// Throws a [ServerException] for all error codes
  Future<List<NonFungibleToken>> getAllNftsOwnedBy(String ethereumAddress);
}

class NftsRemoteDataSource implements NftsRemoteDataSourceBehavior {
  final http.Client client;

  NftsRemoteDataSource({required this.client});
  @override
  Future<List<NonFungibleToken>> getAllNftsOwnedBy(
      String ethereumAddress) async {
    final response = await client.get(
      Uri.parse('https://api.poap.xyz/actions/scan/$ethereumAddress'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) throw ServerException();
    return (json.decode(response.body) as List)
        .map((json) => NonFungibleToken.fromJson(json))
        .toList();
  }
}
