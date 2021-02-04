import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../stores/home_page_store.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _store = GetIt.instance.get<HomePageStore>();

  final _inputTxtCtrl = TextEditingController();
  final _secretKeyTxtCtrl = TextEditingController();
  final _outputTxtCtrl = TextEditingController();

  @override
  void dispose() {
    _inputTxtCtrl.dispose();
    _secretKeyTxtCtrl.dispose();
    _outputTxtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Secret Letter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: _inputTextField(),
            ),
            SizedBox(height: 8),
            _secretKeyTextField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 64,
                  child: RaisedButton(
                    child: Icon(Icons.lock, color: Colors.green),
                    onPressed: () {
                      _store.encrypt();
                    },
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 64,
                  child: RaisedButton(
                    child: Icon(Icons.lock_open, color: Colors.green),
                    onPressed: () {
                      _store.decrypt();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(width: 8),
            Expanded(
              child: _outputTextField(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _secretKeyTextField() {
    return Observer(builder: (_) {
      _secretKeyTxtCtrl.value = _secretKeyTxtCtrl.value.copyWith(text: _store.secretKey ?? '');
      return TextField(
        controller: _secretKeyTxtCtrl,
        onChanged: (value) => _store.secretKey = value,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
          labelText: 'Key',
        ),
      );
    });
  }

  Widget _outputTextField() {
    return Observer(builder: (_) {
      _outputTxtCtrl.value = _outputTxtCtrl.value.copyWith(text: _store.output ?? '');
      return TextField(
        controller: _outputTxtCtrl,
        onChanged: (value) => _store.output = value,
        maxLines: null,
        expands: true,
        readOnly: true,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
          labelText: 'Output',
        ),
      );
    });
  }

  Widget _inputTextField() {
    return Observer(builder: (_) {
      _inputTxtCtrl.value = _inputTxtCtrl.value.copyWith(text: _store.input ?? '');
      return TextField(
        controller: _inputTxtCtrl,
        onChanged: (value) => _store.input = value,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
          labelText: 'Input',
        ),
      );
    });
  }
}
