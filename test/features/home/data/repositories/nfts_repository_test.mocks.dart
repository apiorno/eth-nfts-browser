// Mocks generated by Mockito 5.3.2 from annotations
// in eth_nfts_browser/test/features/home/data/repositories/nfts_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:eth_nfts_browser/core/platform/network_info.dart' as _i6;
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_local_data_source.dart'
    as _i5;
import 'package:eth_nfts_browser/features/home/data/datasources/nfts_remote_data_source.dart'
    as _i2;
import 'package:eth_nfts_browser/features/home/data/models/non_fungible_token_model.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [NftsRemoteDataSourceBehavior].
///
/// See the documentation for Mockito's code generation for more information.
class MockNftsRemoteDataSourceBehavior extends _i1.Mock
    implements _i2.NftsRemoteDataSourceBehavior {
  MockNftsRemoteDataSourceBehavior() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.NonFungibleToken>> getAllNftsOwnedBy(
          String? ethereumAddress) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllNftsOwnedBy,
          [ethereumAddress],
        ),
        returnValue: _i3.Future<List<_i4.NonFungibleToken>>.value(
            <_i4.NonFungibleToken>[]),
      ) as _i3.Future<List<_i4.NonFungibleToken>>);
}

/// A class which mocks [NftsLocalDataSourceBehavior].
///
/// See the documentation for Mockito's code generation for more information.
class MockNftsLocalDataSourceBehavior extends _i1.Mock
    implements _i5.NftsLocalDataSourceBehavior {
  MockNftsLocalDataSourceBehavior() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.NonFungibleToken>> getAllNftsOwnedBy(
          String? ethereumAddress) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllNftsOwnedBy,
          [ethereumAddress],
        ),
        returnValue: _i3.Future<List<_i4.NonFungibleToken>>.value(
            <_i4.NonFungibleToken>[]),
      ) as _i3.Future<List<_i4.NonFungibleToken>>);
  @override
  _i3.Future<void> cacheNftsOwnership(
    String? address,
    List<_i4.NonFungibleToken>? nfts,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #cacheNftsOwnership,
          [
            address,
            nfts,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [NetworkInfoBehavior].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfoBehavior extends _i1.Mock
    implements _i6.NetworkInfoBehavior {
  MockNetworkInfoBehavior() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}
