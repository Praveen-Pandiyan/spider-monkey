import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:spider_monkey/model/edge.dart';
import 'package:spider_monkey/model/node.dart';
import './flow_controller.dart';

class SpiderFlow extends StatefulWidget {
  final String modulePath;
  final FlowController controller;
  final List<Node>? initialNode;
  final List<Edge>? initialEdge;
  final Function(Map<String, dynamic>) onChange;

  const SpiderFlow(
      {super.key,
      required this.modulePath,
      required this.controller,
      required this.onChange,
      this.initialNode,
      this.initialEdge});

  @override
  State<SpiderFlow> createState() => _SpiderFlowState();
}

class _SpiderFlowState extends State<SpiderFlow> {
  InAppWebViewController? webController;
  @override
  Widget build(BuildContext context) {
    return InAppWebView(
     
      initialUrlRequest: URLRequest(url: WebUri(widget.modulePath)),
      
      onWebViewCreated: (controller) async {
        setState(() {
          webController = controller;
          widget.controller.updateController(controller);
        });
        controller.addJavaScriptHandler(
            handlerName: 'onSelect',
            callback: (args) {
              // print arguments coming from the JavaScript side!
              print(args);
    
              // return data to the JavaScript side!
              // return {'bar': 'bar_value', 'baz': 'baz_value'};
            });
        if (widget.initialNode != null) {
          for (var element in widget.initialNode!) {
            widget.controller.addNode(element);
          }
        }
        if (widget.initialEdge != null) {
          for (var element in widget.initialEdge!) {
            widget.controller.addEdge(element);
          }
        }
      },
      onLoadStop: (controller, url) async {
        webController = controller;
      },
      onConsoleMessage: (controller, consoleMessage) {
        print("cons: ${consoleMessage}"); // print the console message
      },
    );
  }
}
