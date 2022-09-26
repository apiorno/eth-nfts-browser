import 'dart:convert';
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_local_data_source.dart';
import 'package:eth_nfts_browser/features/home/data/models/non_fungible_token_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'nfts_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late NftsLocalDataSource dataSource;
  late MockSharedPreferences mockSharedPreferences;
  const address = '0xd8da6bf26964af9d7eed9e03e53415d37aa96045';
  final nfts = [
    NonFungibleToken.fromJson(json.decode(fixture('anNft.json'))),
    NonFungibleToken.fromJson(json.decode(fixture('anotherNft.json')))
  ];
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = NftsLocalDataSource(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getAllNfts', () {
    test(
      'should return nfts from SharedPreferences when there is one ownerd by the ethereum address',
      () async {
        // arrange
        when(mockSharedPreferences.getStringList(address))
            .thenReturn([fixture('anNft.json'), fixture('anotherNft.json')]);
        // act
        final result = await dataSource.getAllNftsOwnedBy(address);
        // assert
        verify(mockSharedPreferences.getStringList(address));
        expect(result, equals(nfts));
      },
    );
    test('should return empty list when there is not a cached value', () async {
      // arrange
      when(mockSharedPreferences.getStringList(address)).thenReturn(null);

      // act

      final nfts = await dataSource.getAllNftsOwnedBy(address);

      // assert
      expect(nfts, isEmpty);
    });
  });

  group('cacheNfts', () {
    test('should call SharedPreferences to cache the data', () {
      // arrange
      final expectedJsonString =
          nfts.map((e) => json.encode(e.toJson())).toList();
      when(mockSharedPreferences.setStringList(address, expectedJsonString))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheNftsOwnership(address, nfts);
      // assert

      verify(mockSharedPreferences.setStringList(
        address,
        expectedJsonString,
      ));
    });
  });
}
