import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:eth_nfts_browser/features/home/presentation/pages/nft_full_view_page.dart';
import 'package:flutter/material.dart';

class NftCard extends StatelessWidget {
  final NonFungibleTokenBehavior nft;
  const NftCard({required this.nft, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(
            nft.imageUrl,
            height: 150,
            width: 150,
          ),
          Text(nft.name),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NftFullViewPage(nft: nft)));
              },
              child: const Text('View'))
        ],
      ),
    );
  }
}
