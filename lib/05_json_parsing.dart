import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// 10-json 파싱
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
      home: const HttpSampleScreen(),
    );
  }
}

class HttpSampleScreen extends StatefulWidget {
  const HttpSampleScreen({super.key});

  @override
  State<HttpSampleScreen> createState() => _HttpSampleScreenState();
}

class _HttpSampleScreenState extends State<HttpSampleScreen> {
  // State
  String title = '';
  String body = 'Loading';

  Future<String> getData() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await http.get(url);
    print(response.body);
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HttpSampleScreen'),
      ),
      body: Center(
        child: FutureBuilder<String>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final jsonString = snapshot.data!;
                final jsonMap = jsonDecode(jsonString) as Map;

                body = jsonMap['body'];
                title = jsonMap['title'];
              }

              return Text('$title : $body');
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        getData();
      }),
    );
  }
}
