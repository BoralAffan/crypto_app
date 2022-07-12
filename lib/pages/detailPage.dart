import 'package:crypto_app/models/CryptoCurrency.dart';
import 'package:crypto_app/providers/marketProviders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id;

  const DetailPage({super.key, required this.id});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

Widget text_details(
    String title, String detail, CrossAxisAlignment CustonCrossAlign) {
  return Column(
    crossAxisAlignment: CustonCrossAlign,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      Text(detail, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400))
    ],
  );
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(left: 20, right: 10),
        child:
            Consumer<MarketProvider>(builder: (context, marketProvider, child) {
          CryptoCurrency currentCrypto =
              marketProvider.fetchcryptobyId(widget.id);
          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: ListView(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    currentCrypto.name! +
                        "  (" +
                        currentCrypto.symbol!.toUpperCase() +
                        ")",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: Column(
                    children: [
                      (currentCrypto.isFavourite == false)
                          ? GestureDetector(
                              onTap: () {
                                marketProvider.addFav(currentCrypto);
                              },
                              child: Icon(
                                Icons.favorite_border_sharp,
                                size: 40,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                marketProvider.removeFav(currentCrypto);
                              },
                              child: Icon(
                                CupertinoIcons.heart_fill,
                                color: Colors.red,
                                size: 40,
                              ),
                            )
                    ],
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(currentCrypto.image!),
                  ),
                  // tileColor: Color(0xffC0C0C0),
                  subtitle: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current Buy price'),
                      Text(
                        "₹" + currentCrypto.currentPrice!.toStringAsFixed(4),
                        style:
                            TextStyle(fontSize: 20, color: Colors.blueAccent),
                      ),
                    ],
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                SizedBox(
                  height: 17,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Change (24h)',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Builder(builder: (context) {
                      double priceChange = currentCrypto.priceChange24h!;
                      double PriceChangePercent =
                          currentCrypto.priceChangePercentage24h!;

                      if (priceChange < 0) {
                        return Text(
                          "${PriceChangePercent.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        );
                      } else {
                        return Text(
                            '+'
                            "${PriceChangePercent.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                            style:
                                TextStyle(color: Colors.green, fontSize: 18));
                      }
                    })
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text_details(
                      "Market Cap Rank",
                      "#" + currentCrypto.marketCapRank!.toString(),
                      CrossAxisAlignment.start,
                    ),
                    text_details(
                        "Market Cap ",
                        '₹ ' + currentCrypto.marketCap!.toString(),
                        CrossAxisAlignment.end),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text_details(
                      "Low 24",
                      '₹ ' + currentCrypto.low24h!.toStringAsFixed(4),
                      CrossAxisAlignment.start,
                    ),
                    text_details(
                        "High 24 ",
                        '₹ ' + currentCrypto.high24h!.toStringAsFixed(4),
                        CrossAxisAlignment.end),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text_details(
                      "Circulating Supply",
                      '₹ ' +
                          currentCrypto.circulatingSupply!.toStringAsFixed(4),
                      CrossAxisAlignment.start,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text_details(
                      "All time high",
                      '₹ ' + currentCrypto.ath!.toStringAsFixed(4),
                      CrossAxisAlignment.start,
                    ),
                    text_details(
                        "All time low",
                        '₹ ' + currentCrypto.atl!.toStringAsFixed(4),
                        CrossAxisAlignment.end),
                  ],
                ),
              ],
            ),
          );
        }),
      )),
    );
  }
}
