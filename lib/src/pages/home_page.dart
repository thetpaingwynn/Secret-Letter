import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../stores/home_page_store.dart';
import 'input_message_page.dart';
import 'output_message_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final key = new GlobalKey<ScaffoldState>();
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
      key: key,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Secret Letter'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
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

  Widget _inputTextField() {
    return Observer(builder: (_) {
      _inputTxtCtrl.value = _inputTxtCtrl.value.copyWith(text: _store.input ?? '');
      return Stack(
        children: [
          TextField(
            controller: _inputTxtCtrl,
            onChanged: (value) => _store.input = value,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
              labelText: 'Input Message',
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: SizedBox(
              width: 32,
              height: 32,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Icon(MdiIcons.arrowTopLeftBottomRight, size: 16, color: Colors.green),
                onPressed: () async {
                  final result = await Navigator.of(context).push(
                    MaterialPageRoute<String>(
                      builder: (BuildContext context) => InputMessagePage(message: _store.input),
                      settings: RouteSettings(name: 'home_page/input_message_page'),
                      fullscreenDialog: true,
                    ),
                  );
                  if (result != null) {
                    _store.input = result;
                  }
                },
              ),
            ),
          ),
        ],
      );
    });
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
      return Stack(
        children: [
          TextField(
            controller: _outputTxtCtrl,
            onChanged: (value) => _store.output = value,
            maxLines: null,
            expands: true,
            readOnly: true,
            textAlignVertical: TextAlignVertical.top,
            keyboardType: TextInputType.text,
            onTap: () async {
              if (await _store.copyOutputMessageToClipboard()) {
                _showToast('Output message copied');
              }
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
              labelText: 'Output Message',
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: SizedBox(
              width: 32,
              height: 32,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                child: Icon(MdiIcons.arrowTopLeftBottomRight, size: 16, color: Colors.green),
                onPressed: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<InputMessagePage>(
                      builder: (BuildContext context) => OutputMessagePage(message: _store.output),
                      settings: RouteSettings(name: 'home_page/output_message_page'),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    });
  }

  void _showToast(String message) {
    key.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
