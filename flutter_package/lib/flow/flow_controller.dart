import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FlowController {
  static InAppWebViewController? controller;
  
  updateController(InAppWebViewController _) {
    controller = _;
  }

  addNode(n) {
    controller?.evaluateJavascript(source: """
    window.dispatchEvent(new CustomEvent("addNode",$n));
  """);
  }
  test(){
    controller?.evaluateJavascript(source: "document.getElementById('root').style.display='none'");
  }
}
