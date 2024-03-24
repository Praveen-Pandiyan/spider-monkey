import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SpiderFlow extends StatefulWidget {
  final String modulePath;
  final Map<String, dynamic> initialVal;
  final Function(Map<String, dynamic>) onChange;
  const SpiderFlow(
      {super.key,
      required this.modulePath,
      required this.initialVal,
      required this.onChange});

  @override
  State<SpiderFlow> createState() => _SpiderFlowState();
}

class _SpiderFlowState extends State<SpiderFlow> {
  late InAppWebViewController _controller;
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(widget.modulePath)),
      onLoadStart: (controller, url) {
        _controller = controller;
        _controller.addJavaScriptHandler(
            handlerName: "onChange", callback: (_) {});
      },
    );
  }
}
