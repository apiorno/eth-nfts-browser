import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:eth_nfts_browser/features/home/presentation/widgets/full_nft_card.dart';
import 'package:flutter/material.dart';

class NftFullViewPage extends StatelessWidget {
  final NonFungibleTokenBehavior nft;
  const NftFullViewPage({required this.nft, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(nft.name),
        ),
        body: FullNftCard(nft: nft));
  }
}
