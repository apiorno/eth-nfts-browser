import 'package:eth_nfts_browser/features/home/presentation/bloc/bloc/non_fungible_token_bloc.dart';
import 'package:eth_nfts_browser/features/home/presentation/pages/nfts_home_page.dart';
import 'package:eth_nfts_browser/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ethereum NFT Collection',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: BlocProvider(
          create: (_) => sl<NonFungibleTokenBloc>(),
          child: const NftHomePage(),
        ));
  }
}
