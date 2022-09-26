import 'dart:convert';

import 'package:eth_nfts_browser/features/home/data/models/non_fungible_token_model.dart';
import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const nftModel = NonFungibleToken(
      owner: '0xd8da6bf26964af9d7eed9e03e53415d37aa96045',
      imageUrl:
          'https://assets.poap.xyz/nec-mergitur-edition-33-2022-logo-1662634861554.png',
      name: 'Nec Mergitur Edition #33',
      description: 'For Nec Mergitur\'s 33rd edition (8th of September 2022).',
      chain: 'xdai',
      creationDate: '2022-09-08 19:58:45');

  test('a NonFungibleToken is a subclass of NonFungibleTokenBehabior', () {
    expect(nftModel, isA<NonFungibleTokenBehavior>());
  });

  group('fromJson', () {
    test('Should return a valid NFT model', () {
      final jsonMap = json.decode(fixture('anNft.json'));
      final model = NonFungibleToken.fromJson(jsonMap);
      expect(model, equals(nftModel));
    });
  });

  group('toJson', () {
    test('Should return a valid json map', () {
      final jsonMap = nftModel.toJson();
      final expectedMap = {
        "name": "Nec Mergitur Edition #33",
        "image_url":
            "https://assets.poap.xyz/nec-mergitur-edition-33-2022-logo-1662634861554.png",
        "description":
            "For Nec Mergitur's 33rd edition (8th of September 2022).",
        "owner": "0xd8da6bf26964af9d7eed9e03e53415d37aa96045",
        "chain": "xdai",
        "creation_date": "2022-09-08 19:58:45"
      };
      expect(jsonMap, expectedMap);
    });
  });
}
