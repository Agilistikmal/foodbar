import 'dart:convert';

import 'package:foodbar/model/food_model.dart';
import 'package:foodbar/model/response_model.dart';
import 'package:http/http.dart' as http;

Future<List<HalalData>> searchHalalFood(String text) async {
  final rawResponse = await http.get(
    Uri.parse("https://foodbar-api.safatanc.com/search/$text"),
  );

  final Map parseResponse = json.decode(rawResponse.body);
  final response = APIResponse.fromJson(parseResponse);

  if (response.code == 200) {
    Iterable l = response.data;
    List<HalalData> halalDataList =
        List<HalalData>.from(l.map((i) => HalalData.fromJson(i)));
    return halalDataList;
  } else {
    throw Exception("Gagal mencari data");
  }
}
