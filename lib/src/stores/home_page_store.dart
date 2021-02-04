import 'package:flutter/services.dart';
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
  String input = '';

  @observable
  String secretKey = '';

  @observable
  String output = '';

  void encrypt() async {
    if (secretKey.isEmpty || input.isEmpty) return;
    final key = await cryptor.generateKeyFromPassword(secretKey, _salt);
    final encrypted = await cryptor.encrypt(input, key);
    //
    output = encrypted;
  }

  void decrypt() async {
    try {
      if (secretKey.isEmpty || input.isEmpty) return;
      final key = await cryptor.generateKeyFromPassword(secretKey, _salt);
      output = await cryptor.decrypt(input, key);
    } catch (e) {
      output = '';
    }
  }

  Future<bool> copyMessageToClipboard() async {
    if (input.isEmpty) return false;

    await Clipboard.setData(ClipboardData(text: input));
    return true;
  }

  Future<bool> pasteMessageFromClipboard() async {
    var data = await Clipboard.getData('text/plain');
    input = data.text;
    return input.isNotEmpty;
  }

  Future<bool> copyOutputMessageToClipboard() async {
    if (output.isEmpty) return false;

    await Clipboard.setData(ClipboardData(text: output));
    return true;
  }
}
