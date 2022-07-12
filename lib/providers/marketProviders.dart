import 'dart:async';
import 'dart:developer';

import 'package:crypto_app/models/Api.dart';
import 'package:crypto_app/models/CryptoCurrency.dart';
import 'package:crypto_app/models/localStorage.dart';
import 'package:flutter/material.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<dynamic> markets = [];

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List _markets = await API.getMarket(DateTime.now());
    List favourites = await LocalStorage.fetchFav();

    List<dynamic> temp = [];

    for (var market in _markets) {
      CryptoCurrency newCrypto = new CryptoCurrency.fromJson(market);
      if (favourites.contains(newCrypto.id!)) {
        newCrypto.isFavourite = true;
      }
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
    // log('data fetched');
    notifyListeners();

// //every 3 seconds pe data fetch hoga and accurate real time data show hoga
    Timer(Duration(seconds: 3), () {
      fetchData();
      // log('data refresfed'); //this will automatically call fetchdata every 3 seconds and the data is updated
    });
  }

  CryptoCurrency fetchcryptobyId(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFav(CryptoCurrency crypto) async {
    int index = markets.indexOf(crypto);
    markets[index].isFavourite = true;
    await LocalStorage.addFav(crypto.id!);
    notifyListeners();
  }

  void removeFav(CryptoCurrency crypto) async {
    int index = markets.indexOf(crypto);
    markets[index].isFavourite = false;
    await LocalStorage.removeFav(crypto.id!);
    notifyListeners();
  }
}
