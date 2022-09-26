import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:eth_nfts_browser/core/error/failures.dart';
import 'package:eth_nfts_browser/features/home/data/models/non_fungible_token_model.dart';
import 'package:eth_nfts_browser/features/home/domain/usecases/get_all_nfts.dart';
import 'package:eth_nfts_browser/features/home/presentation/bloc/bloc/non_fungible_token_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'non_fungible_token_bloc_test.mocks.dart';

@GenerateMocks([GetAllNfts])
void main() {
  late MockGetAllNfts mockGetAllNonFungibleTokens;
  blocTest('Initial state should be InitialNonFungibleTokenState',
      setUp: () {
        mockGetAllNonFungibleTokens = MockGetAllNfts();
      },
      build: () =>
          NonFungibleTokenBloc(getAllNfts: mockGetAllNonFungibleTokens),
      expect: () => <NonFungibleTokenState>[],
      verify: (bloc) =>
          expect(bloc.state, isA<InitialNonFungibleTokenState>()));

  group('GetAllNonFungibleToken', () {
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

    blocTest('Should get data from GetAllNfts usecase',
        setUp: () {
          mockGetAllNonFungibleTokens = MockGetAllNfts();
          when(mockGetAllNonFungibleTokens(const Params(address: address)))
              .thenAnswer((_) async => const Right(nfts));
        },
        build: () =>
            NonFungibleTokenBloc(getAllNfts: mockGetAllNonFungibleTokens),
        act: (bloc) => bloc.add(const GetAllNonFungibleTokensEvent(address)),
        verify: (bloc) => verify(
            mockGetAllNonFungibleTokens(const Params(address: address))));
    blocTest(
        'Should emit [LoadingNonFungibleTokenState, LoadedNonFungibleTokenState] when data is gotten successfully',
        setUp: () {
          mockGetAllNonFungibleTokens = MockGetAllNfts();
          when(mockGetAllNonFungibleTokens(const Params(address: address)))
              .thenAnswer((_) async => const Right(nfts));
        },
        build: () =>
            NonFungibleTokenBloc(getAllNfts: mockGetAllNonFungibleTokens),
        act: (bloc) => bloc.add(const GetAllNonFungibleTokensEvent(address)),
        expect: () => <NonFungibleTokenState>[
              LoadingNonFungibleTokenState(),
              const LoadedNonFungibleTokenState(nfts)
            ]);

    blocTest(
        'Should emit [LoadingNonFungibleTokenState, ErrorNonFungibleTokenState] with proper message for server error when getting data fails on server',
        setUp: () {
          mockGetAllNonFungibleTokens = MockGetAllNfts();
          when(mockGetAllNonFungibleTokens(const Params(address: address)))
              .thenAnswer((_) async => Left(ServerFailure()));
        },
        build: () =>
            NonFungibleTokenBloc(getAllNfts: mockGetAllNonFungibleTokens),
        act: (bloc) => bloc.add(const GetAllNonFungibleTokensEvent(address)),
        expect: () => <NonFungibleTokenState>[
              LoadingNonFungibleTokenState(),
              const ErrorNonFungibleTokenState(message: serverFailure)
            ]);

    blocTest(
        'Should emit [LoadingNonFungibleTokenState, ErrorNonFungibleTokenState]  with proper message for client error when getting data fails on client',
        setUp: () {
          mockGetAllNonFungibleTokens = MockGetAllNfts();
          when(mockGetAllNonFungibleTokens(const Params(address: address)))
              .thenAnswer((_) async => Left(ClientFailure()));
        },
        build: () =>
            NonFungibleTokenBloc(getAllNfts: mockGetAllNonFungibleTokens),
        act: (bloc) => bloc.add(const GetAllNonFungibleTokensEvent(address)),
        expect: () => <NonFungibleTokenState>[
              LoadingNonFungibleTokenState(),
              const ErrorNonFungibleTokenState(message: clientFailure)
            ]);
  });
}
