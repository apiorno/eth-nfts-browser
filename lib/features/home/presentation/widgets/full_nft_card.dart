import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:flutter/material.dart';

class FullNftCard extends StatelessWidget {
  final NonFungibleTokenBehavior nft;
  const FullNftCard({required this.nft, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Image.network(
            nft.imageUrl,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(nft.description),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Chain',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(nft.chain),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Address',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(nft.owner),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Creation Date',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(nft.creationDate),
        ],
      ),
    );
  }
}
