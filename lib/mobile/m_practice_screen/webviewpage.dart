import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class webViewPage extends StatelessWidget {
  final String url;
  const webViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('CODROID      ', style: TextStyle(letterSpacing: 4, fontSize: 22),)),
          // elevation: 0,
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
            Container(color: Colors.blue, height: 50, width:  double.infinity,)
          ],
        ),
      ),
    );
  }
}
