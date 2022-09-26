import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';

class NonFungibleToken extends NonFungibleTokenBehavior {
  const NonFungibleToken(
      {required super.owner,
      required super.imageUrl,
      required super.name,
      required super.description,
      required super.chain,
      required super.creationDate});

  factory NonFungibleToken.fromJson(Map<String, dynamic> json) {
    return NonFungibleToken(
        owner: json['owner'],
        imageUrl: json['event']['image_url'],
        name: json['event']['name'],
        description: json['event']['description'],
        chain: json['chain'],
        creationDate: json['created']);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "image_url": imageUrl,
      "description": description,
      "owner": owner,
      "chain": chain,
      "creation_date": creationDate
    };
  }
}
