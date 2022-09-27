import 'package:eth_nfts_browser/features/home/presentation/bloc/bloc/non_fungible_token_bloc.dart';
import 'package:eth_nfts_browser/features/home/presentation/pages/nfts_browse_page.dart';
import 'package:eth_nfts_browser/features/home/presentation/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NftHomePage extends StatelessWidget {
  const NftHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NonFungibleTokenBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ethereum NFT Collection'),
      ),
      body: BlocConsumer<NonFungibleTokenBloc, NonFungibleTokenState>(
        listener: (context, state) {
          if (state is ErrorNonFungibleTokenState) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Error!"),
                    content: Text(state.message),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Ok')),
                    ],
                  );
                });
          } else if (state is LoadedNonFungibleTokenState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NftsBrowsePage(nfts: state.nonFungibleTokens)));
          }
        },
        buildWhen: (previous, current) =>
            current is LoadingNonFungibleTokenState ||
            current is InitialNonFungibleTokenState,
        builder: (context, state) {
          if (state is LoadingNonFungibleTokenState) {
            return const LoadingWidget();
          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                        'Enter a vallid Ethereum address to see owned NFTs'),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: bloc.addressController(),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Input an ethereum address',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        onPressed: () =>
                            bloc.add(GetAllNonFungibleTokensEvent()),
                        child: const Text('Search NFTs'))
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
