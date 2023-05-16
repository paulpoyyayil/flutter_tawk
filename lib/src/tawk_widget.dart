import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'tawk_visitor.dart';

/// [Tawk] Widget.
class Tawk extends StatefulWidget {
  /// Tawk direct chat link.
  final String directChatLink;

  /// Object used to set the visitor name and email.
  final TawkVisitor? visitor;

  /// Called right after the widget is rendered.
  final Function? onLoad;

  /// Called when a link pressed.
  final Function(String)? onLinkTap;

  /// Render your own loading widget.
  final Widget? placeholder;

  const Tawk({
    Key? key,
    required this.directChatLink,
    this.visitor,
    this.onLoad,
    this.onLinkTap,
    this.placeholder,
  }) : super(key: key);

  @override
  _TawkState createState() => _TawkState();
}

class _TawkState extends State<Tawk> {
  late WebViewController _controller;
  bool _isLoading = true;

  void _setUser(TawkVisitor visitor) {
    final json = jsonEncode(visitor);
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
    _controller.loadRequest(Uri.parse(widget.directChatLink));
    _controller.runJavaScript(javascriptString);
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(NavigationDelegate(
      onPageFinished: (url) {
        if (widget.visitor != null) {
          _setUser(widget.visitor!);
        }

        if (widget.onLoad != null) {
          widget.onLoad!();
        }

        setState(() {
          _isLoading = false;
        });
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        _isLoading
            ? widget.placeholder ??
                const Center(
                  child: CircularProgressIndicator(),
                )
            : Container(),
      ],
    );
  }
}
