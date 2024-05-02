import 'dart:convert';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:spider_monkey/model/edge.dart';
import '../model/node.dart';

class FlowController {
  static InAppWebViewController? controller;

  updateController(InAppWebViewController _) {
    controller = _;
  }

  addNode(Node n) {
    String f =
        'window.dispatchEvent(new CustomEvent("addNode",{"detail": ${json.encode(n.toJson())}}));';
    print(f);
    controller?.evaluateJavascript(source: f);
  }

  addEdge(Edge n) {
   String f =
        'window.dispatchEvent(new CustomEvent("addEdge",{"detail": ${json.encode(n.toJson())}}));';
    print(f);
    controller?.evaluateJavascript(source: f);
  }

  test() {
    controller?.evaluateJavascript(
        source: "document.getElementById('root').style.display='none'");
  }
}
