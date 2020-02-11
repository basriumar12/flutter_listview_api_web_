import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
// get listview data
void main() => runApp(new MaterialApp(
      title: "List Fetch Api",
      home: new Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List dataJson;

  Future<String> ambilData() async {
    http.Response hasil = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "aplication/json"});

    this.setState(() {
      dataJson = json.decode(hasil.body);
    });
  }

  @override
  void initState() {
    this.ambilData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("List Data Fetch Api"),
      ),
      body: new ListView.builder(
        itemCount: dataJson == null ? 0 : dataJson.length,
        itemBuilder: (context, i) {
          return new Container(
              padding: new EdgeInsets.all(10.0),
              child: new Card(
                  child: new Container(
                padding: new EdgeInsets.all(12.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      width: MediaQuery.of(context).size.width,
                      child: new Row(
                        children: <Widget>[
                          new Image.network(
                            "https://pbs.twimg.com/profile_images/805651234698842112/uPSrYOHT_400x400.jpg",
                            width: 60.0,
                          ),

                          Container(
                            width: 150.0,
                            child: new Text(
                              dataJson[i]['title'],
                              style:
                                  TextStyle(fontSize: 15.0, color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    new Text(
                      dataJson[i]['body'],
                      style: TextStyle(fontSize: 14.0),
                    )
                  ],
                ),
              )));
        },
      ),
    );
  }
}
