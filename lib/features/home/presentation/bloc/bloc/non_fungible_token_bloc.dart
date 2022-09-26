import 'package:equatable/equatable.dart';
import 'package:eth_nfts_browser/core/error/failures.dart';
import 'package:eth_nfts_browser/features/home/domain/entities/non_fungible_token.dart';
import 'package:eth_nfts_browser/features/home/domain/usecases/get_all_nfts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'non_fungible_token_event.dart';
part 'non_fungible_token_state.dart';

const String serverFailure = 'Server Failure';
const String clientFailure = 'Client Failure';

class NonFungibleTokenBloc
    extends Bloc<NonFungibleTokenEvent, NonFungibleTokenState> {
  final GetAllNfts getAllNfts;
  NonFungibleTokenBloc({required this.getAllNfts})
      : super(InitialNonFungibleTokenState()) {
    on<GetAllNonFungibleTokensEvent>((event, emit) async {
      emit(LoadingNonFungibleTokenState());
      final failureOrNfts =
          await getAllNfts(Params(address: event.ethereumAddress));
      failureOrNfts.fold(
          (failure) => emit(ErrorNonFungibleTokenState(
              message: _messageAccordingToFailure(failure))),
          (nfts) => emit(LoadedNonFungibleTokenState(nfts)));
    });
  }

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
