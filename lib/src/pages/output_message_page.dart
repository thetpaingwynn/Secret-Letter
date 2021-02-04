import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class OutputMessagePage extends StatefulWidget {
  final String message;

  OutputMessagePage({Key key, this.message}) : super(key: key);

  @override
  _OutputMessagePageState createState() => _OutputMessagePageState();
}

class _OutputMessagePageState extends State<OutputMessagePage> {
  final key = new GlobalKey<ScaffoldState>();

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(child: _outputTextField()),
          ],
        ),
      ),
    );
  }

  Widget _outputTextField() {
    return Observer(builder: (_) {
      _inputTxtCtrl.value = _inputTxtCtrl.value.copyWith(text: this.widget.message ?? '');
      return TextField(
        controller: _inputTxtCtrl,
        maxLines: null,
        expands: true,
        readOnly: true,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
          labelText: 'Output Message',
        ),
      );
    });
  }
}
