import 'dart:convert';

import 'package:eth_nfts_browser/core/error/error.dart';
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_remote_data_source.dart';
import 'package:eth_nfts_browser/features/home/data/models/non_fungible_token_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'nfts_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late NftsRemoteDataSource dataSource;
  late MockClient mockHttpClient;
  const address = '0xd8da6bf26964af9d7eed9e03e53415d37aa96045';
  final nfts = [
    NonFungibleToken.fromJson(json.decode(fixture('anNft.json'))),
    NonFungibleToken.fromJson(json.decode(fixture('anotherNft.json')))
  ];
  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(
            Uri.parse('https://api.poap.xyz/actions/scan/$address'),
            headers: anyNamed('headers')))
        .thenAnswer(
      (_) async => http.Response(
          '[${fixture('anNft.json')},${fixture('anotherNft.json')}]', 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(
            Uri.parse('https://api.poap.xyz/actions/scan/$address'),
            headers: anyNamed('headers')))
        .thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NftsRemoteDataSource(client: mockHttpClient);
  });

  group('getAllNfts', () {
    test(
      'should preform a GET request on a URL with address being the endpoint and with application/json header',
      () {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        dataSource.getAllNftsOwnedBy(address);
        // assert
        verify(mockHttpClient.get(
          Uri.parse('https://api.poap.xyz/actions/scan/$address'),
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return list of non fungible token when the response code is 200(success)',
      () async {
        //arrange
        setUpMockHttpClientSuccess200();
        // act
        final result = await dataSource.getAllNftsOwnedBy(address);
        // assert
        expect(result, equals(nfts));
      },
    );
    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act & assert
        expect(() => dataSource.getAllNftsOwnedBy(address),
            throwsA(const TypeMatcher<ServerException>()));
      },
    );
  });
}
