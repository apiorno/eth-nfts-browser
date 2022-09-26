import 'package:dartz/dartz.dart';
import 'package:eth_nfts_browser/core/error/error.dart';
import 'package:eth_nfts_browser/core/error/failures.dart';
import 'package:eth_nfts_browser/core/platform/network_info.dart';
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_local_data_source.dart';
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_remote_data_source.dart';
import 'package:eth_nfts_browser/features/home/data/models/non_fungible_token_model.dart';
import 'package:eth_nfts_browser/features/home/data/repositories/nfts_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'nfts_repository_test.mocks.dart';

@GenerateMocks([
  NftsRemoteDataSourceBehavior,
  NftsLocalDataSourceBehavior,
  NetworkInfoBehavior
])
void main() {
  late MockNftsRemoteDataSourceBehavior mockRemoteDataSource;
  late MockNftsLocalDataSourceBehavior mockLocalDataSource;
  late NetworkInfoBehavior mockNetworkInfo;
  late NftsRepository repository;

  const address = '0xd8da6bf26964af9d7eed9e03e53415d37aa96045';
  const nfts = [
    NonFungibleToken(
        owner: '0xd8da6bf26964af9d7eed9e03e53415d37aa96045',
        imageUrl:
            'https://assets.poap.xyz/nec-mergitur-edition-33-2022-logo-1662634861554.png',
        name: 'Nec Mergitur Edition #33',
        description:
            'For Nec Mergitur\'s 33rd edition (8th of September 2022).',
        chain: 'xdai',
        creationDate: '2022-09-08 19:58:45'),
    NonFungibleToken(
        owner: '0xd8da6bf26964af9d7eed9e03e53415d37aa96045',
        imageUrl:
            'https://assets.poap.xyz/adrian-sobol-2022-logo-1660921558255.png',
        name: 'FORK DAO',
        description: 'Charla de una comunidad FORK DAO.',
        chain: 'xdai',
        creationDate: '2022-08-19 22:14:15')
  ];

  setUp(() {
    mockRemoteDataSource = MockNftsRemoteDataSourceBehavior();
    mockLocalDataSource = MockNftsLocalDataSourceBehavior();
    mockNetworkInfo = MockNetworkInfoBehavior();
    repository = NftsRepository(
        remoteDataSource: mockRemoteDataSource,
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo);
  });
  group('getAllNfts', () {
    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
          'Should return remote data and cache it when cached data is not present and the call to remote datasource is successful',
          () async {
        when(mockRemoteDataSource.getAllNftsOwnedBy(address))
            .thenAnswer((_) async => nfts);
        when(mockLocalDataSource.getAllNftsOwnedBy(address))
            .thenAnswer((_) async => []);

        final result = await repository.getAllNftsOwnedBy(address);

        verify(mockRemoteDataSource.getAllNftsOwnedBy(address));
        verify(mockLocalDataSource.getAllNftsOwnedBy(address));
        verify(mockLocalDataSource.cacheNftsOwnership(address, nfts));
        verify(mockNetworkInfo.isConnected);
        expect(result, equals(const Right(nfts)));
      });

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.getAllNftsOwnedBy(address))
              .thenThrow(ServerException());
          when(mockLocalDataSource.getAllNftsOwnedBy(address))
              .thenAnswer((_) async => []);
          // act
          final result = await repository.getAllNftsOwnedBy(address);
          // assert
          verify(mockRemoteDataSource.getAllNftsOwnedBy(address));
          verify(mockLocalDataSource.getAllNftsOwnedBy(address));
          verify(mockNetworkInfo.isConnected);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });
    group('Device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(mockLocalDataSource.getAllNftsOwnedBy(address))
              .thenAnswer((_) async => nfts);
          // act
          final result = await repository.getAllNftsOwnedBy(address);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getAllNftsOwnedBy(address));
          expect(result, equals(const Right(nfts)));
        },
      );

      test(
        'should return client failure when the cached data is not present',
        () async {
          // arrange
          when(mockLocalDataSource.getAllNftsOwnedBy(address))
              .thenAnswer((_) async => []);
          // act
          final result = await repository.getAllNftsOwnedBy(address);
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getAllNftsOwnedBy(address));
          verify(mockNetworkInfo.isConnected);
          expect(result, equals(Left(ClientFailure())));
        },
      );
    });
  });
}
