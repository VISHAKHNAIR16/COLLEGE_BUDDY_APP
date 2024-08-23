import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WifiAuthScreen extends StatefulWidget {
  const WifiAuthScreen({super.key});

  @override
  WifiAuthScreenState createState() => WifiAuthScreenState();
}

class WifiAuthScreenState extends State<WifiAuthScreen> {
  final _storage = const FlutterSecureStorage();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  InAppWebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    _usernameController.text = await _storage.read(key: 'username') ?? '';
    _passwordController.text = await _storage.read(key: 'password') ?? '';
  }

  Future<void> _saveCredentials() async {
    await _storage.write(key: 'username', value: _usernameController.text);
    await _storage.write(key: 'password', value: _passwordController.text);
  }

  void _autoFillAndLogin() {
    _webViewController?.evaluateJavascript(source: """
        document.getElementById('username').value = '${_usernameController.text}';
        document.getElementById('password').value = '${_passwordController.text}';
        document.getElementById('loginbutton').click();
      """);
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Your Credentials'),
            content: const Text('For Credentials'),
            actions: <Widget>[
              Column(
                children: [
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _saveCredentials();
                      _autoFillAndLogin();
                      Navigator.pop(context);
                    },
                    child: const Text('Login'),
                  ),
                ],
              )
            ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () {
          _webViewController?.evaluateJavascript(source: """
        document.getElementById('username').value = '${_usernameController.text}';
        document.getElementById('password').value = '${_passwordController.text}';
        document.getElementById('loginbutton').click();
      """);
        },
        label: const Text("AutoLogin"),
        icon: const Icon(Icons.star),
        style: const ButtonStyle(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        title: const Text('VConnet'),
        actions: [
          IconButton(
            onPressed: () {
              _showAlertDialog();
            },
            icon: const Icon(Icons.person_add),
          )
        ],
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: WebUri.uri(Uri.parse(
                      'https://hfw.vitap.ac.in:8090/httpclient.html'))),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  javaScriptEnabled: true,
                ),
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
            ),
          ),
        ],
      ),
    );
  }
}
