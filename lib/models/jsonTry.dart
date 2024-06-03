import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonTry extends StatefulWidget {
  const JsonTry({super.key});

  @override
  State<JsonTry> createState() => _JsonTryState();
}

class _JsonTryState extends State<JsonTry> {

  late List _items = [];

  Future<void> readJson() async{
    final String preneur = await rootBundle.loadString("assets/qcm.json");
    final data = await json.decode(preneur);
    if(mounted){
      setState(() {
        _items = data["_items"];
        print(_items.length);
      });
    }

  }

  void init(){
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return _items.isNotEmpty?ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        print("ee");
        return Text(_items[index]["title"]);
      },
    ):CircularProgressIndicator();
  }
}
