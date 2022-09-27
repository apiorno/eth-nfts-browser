part of 'non_fungible_token_bloc.dart';

abstract class NonFungibleTokenEvent extends Equatable {
  const NonFungibleTokenEvent();

  @override
  List<Object> get props => [];
}

class GetAllNonFungibleTokensEvent extends NonFungibleTokenEvent {}
