import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class API {
  static Future<List> getMarket(DateTime date) async {
    try {
      Uri requesturl = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=INR&order=market_cap_desc&per_page=20&page=1&sparkline=false");

      var response = await http.get(requesturl);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> markets = decodedResponse as List<dynamic>;
      return markets;
    } catch (ex) {
      return [];
    }
  }
}
