import 'package:crypto_app/models/CryptoCurrency.dart';
import 'package:crypto_app/providers/marketProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detailPage.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List favourites = marketProvider.markets
            .where((element) => element.isFavourite == true)
            .toList();

        if (favourites.length > 0) {
          return ListView.builder(
            itemCount: favourites.length,
            itemBuilder: (context, index) {
              CryptoCurrency CurrentcryptoCurrency = favourites[index];
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
            },
          );
        } else {
          return Container(
            child: Center(
                child: Text(
              'Favourite list is empty!',
              style: TextStyle(color: Colors.grey, fontSize: 20.0),
            )),
          );
        }
      },
    );
  }
}
