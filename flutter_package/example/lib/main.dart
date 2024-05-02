import 'package:flutter/material.dart';
import 'package:spider_monkey/model/node.dart';
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
      home: const MyHomePage(title: 'Flutter Flow'),
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
     
      body: SpiderFlow(
          modulePath: "https://trizda-saqqep.web.app",
          controller: controller,
          initialNode: [Node(
            id: "efreedef",
            data: { 'label': "Node B efre" },
            position: Position(x: 150,y: 150),
            
          )],
          onChange: (_) {}),
      // SpiderFlow(modulePath: "http://192.168.52.197:3000", initialVal: {}, onChange: (_){}),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
        
          controller.addNode(Node(id: "hello",
          data: {'label':"here"},
          draggable: true,
          position: Position(x: 100,y:150)
          ));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
