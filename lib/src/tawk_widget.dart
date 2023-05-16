import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// [Tawk] Widget.
class Tawk extends StatefulWidget {
  /// Tawk direct chat link.
  final String directChatLink;

  /// Render your own loading widget.
  final Widget placeholder;

  const Tawk({
    Key? key,
    required this.directChatLink,
    required this.placeholder,
  }) : super(key: key);

  @override
  State createState() => _TawkState();
}

class _TawkState extends State<Tawk> {
  late WebViewController _controller;
  late String url;
  bool _isLoading = true;

  @override
  void initState() {
    url = widget.directChatLink;
    String javascriptString;

    if (Platform.isIOS) {
      javascriptString = '''
        Tawk_API = Tawk_API || {};
        Tawk_API.setAttributes($json);
      ''';
    } else {
      javascriptString = '''
        Tawk_API = Tawk_API || {};
        Tawk_API.onLoad = function() {
          Tawk_API.setAttributes($json);
        };
      ''';
    }
    _controller = WebViewController()
      ..runJavaScript(javascriptString)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (navigation) {
            if (navigation.url != url) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? widget.placeholder
        : WebViewWidget(controller: _controller);
  }
}
