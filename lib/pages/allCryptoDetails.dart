import 'package:crypto_app/models/CryptoCurrency.dart';
import 'package:crypto_app/pages/detailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/marketProviders.dart';

class AllCrypto extends StatefulWidget {
  const AllCrypto({Key? key}) : super(key: key);

  @override
  State<AllCrypto> createState() => _AllCryptoState();
}

class _AllCryptoState extends State<AllCrypto> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return Text('data not found');
        } else {
          // return RefreshIndicator( //by using refrsh indicator data will update only when screen is refreshed!!
          //   onRefresh: () async {
          //     await marketProvider.fetchData();
          //   },
          //   child:

          return ListView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: marketProvider.markets.length,
              itemBuilder: (context, index) {
                CryptoCurrency CurrentcryptoCurrency =
                    marketProvider.markets[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(
                                  id: CurrentcryptoCurrency.id!,
                                )));
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(CurrentcryptoCurrency.image!),
                  ),
                  title: Text(CurrentcryptoCurrency.name! +
                      " #${CurrentcryptoCurrency.marketCapRank}"),
                  subtitle: Text(CurrentcryptoCurrency.symbol!.toUpperCase()),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '₹ ' +
                            CurrentcryptoCurrency.currentPrice!
                                .toStringAsFixed(4),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      Builder(builder: (context) {
                        double priceChange =
                            CurrentcryptoCurrency.priceChange24h!;
                        double PriceChangePercent =
                            CurrentcryptoCurrency.priceChangePercentage24h!;

                        if (priceChange < 0) {
                          return Text(
                            "${PriceChangePercent.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                            style: TextStyle(color: Colors.red),
                          );
                        } else {
                          return Text(
                              '+'
                              "${PriceChangePercent.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                              style: TextStyle(color: Colors.green));
                        }
                      })
                    ],
                  ),
                );
              });
        }
      },
    );
  }
}
