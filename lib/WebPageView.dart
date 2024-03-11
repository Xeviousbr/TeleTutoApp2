import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async'; // Adicione esta importação

class WebPageView extends StatefulWidget {
  @override
  _WebPageViewState createState() => _WebPageViewState();
}

class _WebPageViewState extends State<WebPageView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>(); // Corrigido aqui

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web Page View'),
      ),
      body: WebView(
        initialUrl:
            'https://31.220.21.96:8090/preview/devprojects.com/teste-web',
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
        javascriptMode: JavascriptMode.unrestricted,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String result = await (await _controller.future)
              .evaluateJavascript('document.body.innerText');
          print(result); // Aqui você pode manipular o texto extraído da página
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}
