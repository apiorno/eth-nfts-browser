import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:eth_nfts_browser/features/home/presentation/widgets/nft_card.dart';
import 'package:flutter/material.dart';

class NftsBrowsePage extends StatelessWidget {
  final List<NonFungibleTokenBehavior> nfts;
  const NftsBrowsePage({required this.nfts, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Browse your Nfts'),
        ),
        body: GridView.count(
          primary: true,
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          children: List.generate(
              nfts.length,
              (index) => NftCard(
                    nft: nfts[index],
                  )),
        ));
  }
}
