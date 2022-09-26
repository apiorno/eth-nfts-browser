import 'dart:convert';

import 'package:eth_nfts_browser/features/home/data/models/non_fungible_token_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NftsLocalDataSourceBehavior {
  /// Gets the cached [NonFungibleToken s] owned by an address gotten remotly last time
  ///
  /// Throws [NoLocalDataException] if no cached data is present
  Future<List<NonFungibleToken>> getAllNftsOwnedBy(String ethereumAddress);
  Future<void> cacheNftsOwnership(String address, List<NonFungibleToken> nfts);
}

class NftsLocalDataSource implements NftsLocalDataSourceBehavior {
  final SharedPreferences sharedPreferences;
  NftsLocalDataSource({required this.sharedPreferences});
  @override
  Future<void> cacheNftsOwnership(
      String address, List<NonFungibleToken> nfts) async {
    final stringNfts = nfts.map((e) => json.encode(e.toJson())).toList();
    sharedPreferences.setStringList(address, stringNfts);
  }

  @override
  Future<List<NonFungibleToken>> getAllNftsOwnedBy(
      String ethereumAddress) async {
    final stringNfts = sharedPreferences.getStringList(ethereumAddress);
    if (stringNfts == null) return [];
    final nfts = stringNfts
        .map((e) => NonFungibleToken.fromJson(json.decode(e)))
        .toList();

    return nfts;
  }
}
