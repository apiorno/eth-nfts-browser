import 'package:dartz/dartz.dart';
import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:eth_nfts_browser/features/home/domain/repositories/nfts_repository.dart';
import 'package:eth_nfts_browser/features/home/domain/usecases/get_all_nfts.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_all_nfts_test.mocks.dart';

@GenerateMocks([NftsRepositoryBehavior])
void main() {
  late GetAllNfts useCase;
  late MockNftsRepositoryBehavior mockNftsRepository;
  List<NonFungibleTokenBehavior> nfts = const [
    NonFungibleTokenBehavior(
        owner: '0xd8da6bf26964af9d7eed9e03e53415d37aa96045',
        imageUrl:
            'https://assets.poap.xyz/nec-mergitur-edition-33-2022-logo-1662634861554.png',
        name: 'Nec Mergitur Edition #33',
        description:
            'For Nec Mergitur\'s 33rd edition (8th of September 2022).',
        chain: 'xdai',
        creationDate: '2022-09-08 19:58:45'),
    NonFungibleTokenBehavior(
        owner: '0xd8da6bf26964af9d7eed9e03e53415d37aa96045',
        imageUrl:
            'https://assets.poap.xyz/adrian-sobol-2022-logo-1660921558255.png',
        name: 'FORK DAO',
        description: 'Charla de una comunidad FORK DAO.',
        chain: 'xdai',
        creationDate: '2022-08-19 22:14:15')
  ];
  setUp(() {
    mockNftsRepository = MockNftsRepositoryBehavior();
    useCase = GetAllNfts(mockNftsRepository);
  });

  test('Should get all nfts owned by ethereum address', () async {
    when(mockNftsRepository
            .getAllNftsOwnedBy('0xd8da6bf26964af9d7eed9e03e53415d37aa96045'))
        .thenAnswer((_) async => Right(nfts));

    final result = await useCase(
        const Params(address: '0xd8da6bf26964af9d7eed9e03e53415d37aa96045'));

    expect(result, right(nfts));
    verify(mockNftsRepository
            .getAllNftsOwnedBy('0xd8da6bf26964af9d7eed9e03e53415d37aa96045'))
        .called(1);
  });
}
