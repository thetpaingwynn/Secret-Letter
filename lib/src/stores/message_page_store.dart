import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

part 'message_page_store.g.dart';

@injectable
class MessagePageStore = _MessagePageStoreBase with _$MessagePageStore;

abstract class _MessagePageStoreBase with Store {
  @observable
  String message = '';

  Future<bool> copyMessageToClipboard() async {
    if (message.isEmpty) return false;

    await Clipboard.setData(ClipboardData(text: message));
    return true;
  }

  Future<bool> pasteMessageFromClipboard() async {
    var data = await Clipboard.getData('text/plain');
    message = data.text;
    return message.isNotEmpty;
  }
}
