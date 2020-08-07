import 'package:flutter/material.dart';
import 'package:test_app/news_listview.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Interview',
      home: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          backgroundColor: Colors.black26,
          title: Container(
            alignment: Alignment.center,
            child: Text(
              'News Interview',
            ),
          ),
        ),
        body: Center(child: NewsListView()),
      ),
    );
  }
}
