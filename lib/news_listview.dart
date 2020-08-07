import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class News {
  final String title;
  final String date;
  final String pic;

  News({this.title, this.date, this.pic});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['Khabar_Title'],
      date: json['Khabar_Date'],
      pic: json['Pic'],
    );
  }
}

class NewsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<News>>(
      future: _fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<News> data = snapshot.data;
          return _newsListView(data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<News>> _fetchNews() async {
    final newsUrl =
        'http://ninanews.com/NinaNewsService/api/values/GetLastXBreakingNews?rowsToReturn=10&fbclid=IwAR1uIhoKTtSyj6pTYC6t5ONcVXms6g2TUpdtfqamGhIIbJehljZSRp3tprI';
    final response = await http.get(newsUrl);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List jsonRes = jsonResponse['Data'];
      return jsonRes.map((news) => News.fromJson(news)).toList();
    } else {
      throw Exception('Failed to get News');
    }
  }

  ListView _newsListView(data) {
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white38),
              child:
                  _tile(data[index].title, data[index].date, data[index].pic),
            ),
          );
        });
  }

  ListTile _tile(String title, String date, String pic) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 10.0),
      ),
      subtitle: Text(
        date,
        style: TextStyle(fontSize: 8.0),
      ),
      leading: Container(
        height: 38.0,
        width: 38.0,
        child: FloatingActionButton(
          backgroundColor: Colors.white10,
          foregroundColor: Colors.black,
          child: Text(
            pic != null ? pic : 'No',
            style: TextStyle(fontSize: 5.0),
          ),
        ),
      ),
    );
  }
}
