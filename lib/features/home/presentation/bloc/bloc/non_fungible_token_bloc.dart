import 'package:equatable/equatable.dart';
import 'package:eth_nfts_browser/core/error/failures.dart';
import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:eth_nfts_browser/features/home/domain/usecases/get_all_nfts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'non_fungible_token_event.dart';
part 'non_fungible_token_state.dart';

const String serverFailure = 'Server Failure';
const String clientFailure = 'Client Failure';

class NonFungibleTokenBloc
    extends Bloc<NonFungibleTokenEvent, NonFungibleTokenState> {
  final GetAllNfts getAllNfts;
  final TextEditingController _addressController =
      TextEditingController(text: '0xd8da6bf26964af9d7eed9e03e53415d37aa96046');
  final regexp = RegExp('^0x[a-fA-F0-9]{40}\$');
  NonFungibleTokenBloc({required this.getAllNfts})
      : super(InitialNonFungibleTokenState()) {
    on<GetAllNonFungibleTokensEvent>((event, emit) async {
      if (!regexp.hasMatch(_addressController.text)) {
        emit(const ErrorNonFungibleTokenState(
            message: 'Invalid Ethereum address'));
        return;
      }
      emit(LoadingNonFungibleTokenState());
      final failureOrNfts =
          await getAllNfts(Params(address: _addressController.text));
      failureOrNfts.fold(
          (failure) => emit(ErrorNonFungibleTokenState(
              message: _messageAccordingToFailure(failure))), (nfts) {
        emit(LoadedNonFungibleTokenState(nfts));
        _addressController.clear();
      });
      emit(InitialNonFungibleTokenState());
    });
  }
  TextEditingController addressController() => _addressController;
  String _messageAccordingToFailure(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailure;
      case ClientFailure:
        return clientFailure;
      default:
        return 'Unexpected Error';
    }
  }
}
