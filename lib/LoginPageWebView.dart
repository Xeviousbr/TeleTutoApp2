import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class LoginPageWebView extends StatefulWidget {
  final String user;
  final String password;

  LoginPageWebView({required this.user, required this.password});

  @override
  _LoginPageWebViewState createState() => _LoginPageWebViewState();
}

class _LoginPageWebViewState extends State<LoginPageWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    String loginUrl =
        "http://31.220.21.96:8090/preview/devprojects.com/api/login?email=${widget.user}&password=${widget.password}";

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: WebView(
        initialUrl: loginUrl,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
