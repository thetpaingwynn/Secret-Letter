import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../stores/message_page_store.dart';

class InputMessagePage extends StatefulWidget {
  final String message;
  InputMessagePage({Key key, this.message}) : super(key: key);

  @override
  _InputMessagePageState createState() => _InputMessagePageState();
}

class _InputMessagePageState extends State<InputMessagePage> {
  final key = new GlobalKey<ScaffoldState>();
  final _store = GetIt.instance.get<MessagePageStore>();

  final _inputTxtCtrl = TextEditingController();

  @override
  void dispose() {
    _inputTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Input Message'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop(_store.message);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: RaisedButton(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.copy, size: 16, color: Colors.green),
                      onPressed: () async {
                        if (await _store.copyMessageToClipboard()) {
                          _showToast('Input message copied');
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: RaisedButton(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.paste, size: 16, color: Colors.green),
                      onPressed: () async {
                        if (await _store.pasteMessageFromClipboard()) {
                          _showToast('Input message pasted');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _inputTextField()),
          ],
        ),
      ),
    );
  }

  Widget _inputTextField() {
    return Observer(builder: (_) {
      _inputTxtCtrl.value = _inputTxtCtrl.value.copyWith(text: this.widget.message ?? '');
      return TextField(
        controller: _inputTxtCtrl,
        onChanged: (value) => _store.message = value,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
          labelText: 'Input Message',
        ),
      );
    });
  }

  void _showToast(String message) {
    key.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
