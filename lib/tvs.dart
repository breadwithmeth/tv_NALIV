import 'package:flutter/material.dart';
import 'package:tv/api.dart';
import 'package:tv/sales.dart';

class tvsPage extends StatefulWidget {
  const tvsPage({super.key, required this.store_id});
  final String store_id;
  @override
  State<tvsPage> createState() => _tvsPageState();
}

class _tvsPageState extends State<tvsPage> {
  List _tvs = [];

  Future<void> _getTVs() async {
    List tvs = await getTVs(widget.store_id) ?? [];
    setState(() {
      _tvs = tvs;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTVs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // number of items in each row
          mainAxisSpacing: 8.0, // spacing between rows
          crossAxisSpacing: 8.0, // spacing between columns
        ),
        padding: EdgeInsets.all(8.0), // padding around the grid
        itemCount: _tvs.length, // total number of _tvs
        itemBuilder: (context, index) {
          return ElevatedButton(
            child: Center(
              child: Text(
                _tvs[index]["tv_id"],
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return SalesPage(
                    tv_id: _tvs[index]["tv_id"],
                  );
                },
              ));
            },
          );
        },
      ),
    );
  }
}
