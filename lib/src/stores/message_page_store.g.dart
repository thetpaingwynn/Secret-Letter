// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_page_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MessagePageStore on _MessagePageStoreBase, Store {
  final _$messageAtom = Atom(name: '_MessagePageStoreBase.message');

  @override
  String get message {
    _$messageAtom.reportRead();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.reportWrite(value, super.message, () {
      super.message = value;
    });
  }

  @override
  String toString() {
    return '''
message: ${message}
    ''';
  }
}
