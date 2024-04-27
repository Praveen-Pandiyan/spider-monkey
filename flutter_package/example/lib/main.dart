import 'package:flutter/material.dart';
import 'package:spider_monkey/spider_monkey.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlowController controller = FlowController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SpiderFlow(
          modulePath: "https://trizda-saqqep.web.app",
          controller: controller,
          initialVal: {},
          onChange: (_) {}),
      // SpiderFlow(modulePath: "http://192.168.52.197:3000", initialVal: {}, onChange: (_){}),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //    try {
      //       controller.test();
      //    } catch (e) {
      //      print(e);
      //    }
      //     // controller.addNode("""{
      //     //   "detail": {
      //     //     "id": '${UniqueKey()}',
      //     //     "data": {"label": 'node ${UniqueKey()}'},
      //     //     "position": {"x": 0, "y": 100},
      //     //   }
      //     // }""");
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
