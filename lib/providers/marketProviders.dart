import 'dart:async';
import 'dart:developer';

import 'package:crypto_app/models/Api.dart';
import 'package:crypto_app/models/CryptoCurrency.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<dynamic> markets = [];

  MarketProvider() {
    fetchData();
  }

  void fetchData() async {
    List _markets = await API.getMarket(DateTime.now());

    List<dynamic> temp = [];

    for (var market in _markets) {
      CryptoCurrency newCrypto = new CryptoCurrency.fromJson(market);
      temp.add(newCrypto);
    }

//     List cryptoList = await API.getMarket(DateTime.now());
// // Now you can iterate on this list.
//     for (var task in cryptoList) {
//       // do something
//        CryptoCurrency newCrypto = new CryptoCurrency.fromJson(market);
//       temp.add(newCrypto);
//     }

    markets = temp;
    isLoading = false;
    log('data fetched');
    notifyListeners();

//every 3 seconds pe data fetch hoga and accurate real time data show hoga
    Timer(Duration(seconds: 3), () {
      fetchData();
    });
  }
}
