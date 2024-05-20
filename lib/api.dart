import 'package:http/http.dart' as http;
import 'dart:convert';

// var URL_API = 'localhost:8080';
var URL_API = 'tv.naliv.kz';

Future<List?> getStores() async {
  var url = Uri.https(URL_API, 'api/getStores.php');
  var response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
  );

  // List<dynamic> list = json.decode(response.body);
  List? data = json.decode(utf8.decode(response.bodyBytes));
  print(data);
  return data;
}

Future<List?> getTVs(String store_id) async {
  var url = Uri.https(URL_API, 'api/getTVs.php');
  var response = await http.post(
    url,
    body: json.encode({"store_id": store_id}),
    headers: {"Content-Type": "application/json"},
  );

  // List<dynamic> list = json.decode(response.body);
  List? data = json.decode(utf8.decode(response.bodyBytes));
  print(data);
  return data;
}

Future<List?> getSales(String tv_id) async {
  var url = Uri.https(URL_API, 'api/getSales.php');
  var response = await http.post(
    url,
    body: json.encode({"tv_id": tv_id}),
    headers: {"Content-Type": "application/json"},
  );

  // List<dynamic> list = json.decode(response.body);
  List? data = json.decode(utf8.decode(response.bodyBytes));
  print(data);
  return data;
}
