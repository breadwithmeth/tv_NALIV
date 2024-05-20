import 'dart:html';

import 'package:flutter/material.dart';
import 'package:tv/api.dart';
import 'package:tv/main.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key, required this.tv_id});
  final String tv_id;
  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List _sales = [];

  Future<void> _getSales() async {
    List tvs = await getSales(widget.tv_id) ?? [];
    setState(() {
      _sales = tvs;
    });
  }

  void goFullScreen() {
    document.documentElement?.requestFullscreen();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goFullScreen();
    _getSales();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("здесь будет логотип"),
        ),
        body: LayoutBuilder(builder: (ctx, constraints) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // number of items in each row

                childAspectRatio:
                    (constraints.maxWidth / 2) / (constraints.maxHeight / 8)),
            // padding around the grid
            itemCount: _sales.length, // total number of _tvs
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Column(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: Image.network(
                            _sales[index]["b_logo"],
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    )),
                    Flexible(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              TextField(controller: TextEditingController(text:_sales[index]["title"] ), maxLines: 1, style: TextStyle(fontSize: ScaleSize.textScaleFactor(context) * 20, overflow: TextOverflow.clip),),
                              // Flexible(
                              //   child: Text(
                              //     _sales[index]["title"],
                              //     style: TextStyle(
                              //         fontSize:
                              //             ScaleSize.textScaleFactor(context) *
                              //                 20),
                              //   ),
                              // ),
                              Row(
                                children: [
                              _sales[index]["ppm"] == ""
                                        ? Container()
                                        : Container(
                                        padding: EdgeInsets.all(5),
                                        child: Row(
                                            children: [
                                              Icon(Icons.water_drop_rounded),
                                              Text(_sales[index]["ppm"] ?? "", style: TextStyle(fontSize:  ScaleSize.textScaleFactor(context) *
                                              10),)
                                            ],
                                          ),)
                                  
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              );
            },
          );
        }));
  }
}
