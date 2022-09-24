import 'package:equatable/equatable.dart';

class NonFungibleToken extends Equatable {
  final String owner;
  final String imageUrl;
  final String name;
  final String description;
  final String chain;
  final String creationDate;

  const NonFungibleToken(
      {required this.owner,
      required this.imageUrl,
      required this.name,
      required this.description,
      required this.chain,
      required this.creationDate});

  @override
  List<Object?> get props =>
      [owner, imageUrl, name, description, chain, creationDate];
}
