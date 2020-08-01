import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class MapsScreen extends StatelessWidget {
  final String url = 'https://www.bing.com/covid';

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text('Live Map'),
      ),
      url: url,
      withZoom: true,
      withLocalStorage: true,
    );
  }
}
