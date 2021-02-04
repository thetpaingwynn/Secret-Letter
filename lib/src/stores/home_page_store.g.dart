// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomePageStore on _HomePageStoreBase, Store {
  final _$inputAtom = Atom(name: '_HomePageStoreBase.input');

  @override
  String get input {
    _$inputAtom.reportRead();
    return super.input;
  }

  @override
  set input(String value) {
    _$inputAtom.reportWrite(value, super.input, () {
      super.input = value;
    });
  }

  final _$secretKeyAtom = Atom(name: '_HomePageStoreBase.secretKey');

  @override
  String get secretKey {
    _$secretKeyAtom.reportRead();
    return super.secretKey;
  }

  @override
  set secretKey(String value) {
    _$secretKeyAtom.reportWrite(value, super.secretKey, () {
      super.secretKey = value;
    });
  }

  final _$outputAtom = Atom(name: '_HomePageStoreBase.output');

  @override
  String get output {
    _$outputAtom.reportRead();
    return super.output;
  }

  @override
  set output(String value) {
    _$outputAtom.reportWrite(value, super.output, () {
      super.output = value;
    });
  }

  @override
  String toString() {
    return '''
input: ${input},
secretKey: ${secretKey},
output: ${output}
    ''';
  }
}
