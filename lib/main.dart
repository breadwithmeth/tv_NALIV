import 'package:flutter/material.dart';
import 'dart:html';
import 'dart:math';

import 'package:tv/api.dart';
import 'package:tv/sales.dart';
import 'package:tv/tvs.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List _stores = [];

  Future<void> _getStores() async {
    List stores = await getStores() ?? [];
    setState(() {
      _stores = stores;
    });
  }

  void goto() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SalesPage(tv_id: "1");
      },
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStores();
    // goto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: _stores.length, // total number of _stores
        itemBuilder: (context, index) {
          return ElevatedButton(
            child: Center(
              child: Text(
                _stores[index]["name"],
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return tvsPage(store_id: _stores[index]["store_id"]);
                },
              ));
            },
          );
        },
      )),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1920) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
