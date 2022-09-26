part of 'non_fungible_token_bloc.dart';

abstract class NonFungibleTokenState extends Equatable {
  const NonFungibleTokenState();

  @override
  List<Object> get props => [];
}

class InitialNonFungibleTokenState extends NonFungibleTokenState {}

class LoadingNonFungibleTokenState extends NonFungibleTokenState {}

class LoadedNonFungibleTokenState extends NonFungibleTokenState {
  final List<NonFungibleTokenBehavior> nonFungibleTokens;
  const LoadedNonFungibleTokenState(this.nonFungibleTokens);
}

class ErrorNonFungibleTokenState extends NonFungibleTokenState {
  final String message;
  const ErrorNonFungibleTokenState({required this.message});
  @override
  List<Object> get props => [message];
}
