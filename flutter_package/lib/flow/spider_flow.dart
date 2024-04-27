import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import './flow_controller.dart';

class SpiderFlow extends StatefulWidget {
  final String modulePath;
  final FlowController controller;
  final Map<String, dynamic> initialVal;
  final Function(Map<String, dynamic>) onChange;

  const SpiderFlow(
      {super.key,
      required this.modulePath,
      required this.controller,
      required this.initialVal,
      required this.onChange});

  @override
  State<SpiderFlow> createState() => _SpiderFlowState();
}

class _SpiderFlowState extends State<SpiderFlow> {
  InAppWebViewController? webController;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.7,
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.modulePath)),
            onWebViewCreated: (controller) async {
              setState(() {
                webController = controller;
                widget.controller.updateController(controller);
              });
              if (Theme.of(context).platform != TargetPlatform.android ||
                  await WebViewFeature.isFeatureSupported(
                      WebViewFeature.WEB_MESSAGE_LISTENER)) {
                await controller.addWebMessageListener(WebMessageListener(
                  jsObjectName: "addNode",
                  allowedOriginRules: Set.from(["http"]),
                  onPostMessage:
                      (message, sourceOrigin, isMainFrame, replyProxy) {
                    replyProxy.postMessage(WebMessage(data: """{
                detail: { id: '1', data: { label: 'Node 1' },position: { x: 150, y: 0 },}
              }
          """));
                  },
                ));
              }
            },
            onLoadStop: (controller, url) async {
              webController = controller;
            },
            onConsoleMessage: (controller, consoleMessage) {
              print("cons: ${consoleMessage}"); // print the console message
            },
          ),
        ),
        TextButton.icon(
          icon: const Icon(Icons.add),
          label: const Text("Add"),
          onPressed: () {
            webController!.evaluateJavascript(source: """
    window.dispatchEvent(new CustomEvent("addNode",{
            "detail": {
              "id": '${UniqueKey()}',
              "data": {"label": 'node ${UniqueKey()}'},
              "position": {"x": 0, "y": 100},
            }
          }));
  """);
          },
        ),
      ],
    );
  }
}
