import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'home_page_store.g.dart';

@injectable
class HomePageStore = _HomePageStoreBase with _$HomePageStore;

abstract class _HomePageStoreBase with Store {
  final cryptor = new PlatformStringCryptor();
  final _salt =
      "+CrRWyZRv7oUKIDx/QNIIJnmCti3f1BD0YgshkSFX3uT7AQduxbkcZUvrCeXHcYWGRYoS1jLL4IdpiXBuemcQwbocE+oH6yvwvwWRIbzzNsMQI4T7VKV9Q6F/vH+OYZVxp2S20ZDWtfv3bQIvZynKef5ezMZyNlAsFZEdmVJAck=";

  @observable
  String input;

  @observable
  String secretKey;

  @observable
  String output;

  void encrypt() async {
    final key = await cryptor.generateKeyFromPassword(secretKey, _salt);
    final encrypted = await cryptor.encrypt(input, key);
    //
    output = encrypted;
  }

  void decrypt() async {
    final key = await cryptor.generateKeyFromPassword(secretKey, _salt);
    final encrypted = await cryptor.decrypt(input, key);
    //
    output = encrypted;
  }
}
