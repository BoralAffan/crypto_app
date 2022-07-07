import 'package:crypto_app/models/CryptoCurrency.dart';
import 'package:crypto_app/providers/marketProviders.dart';
import 'package:crypto_app/providers/themeProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeModeProvider themeProvider =
        Provider.of<ThemeModeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Cryptofyy",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Live Details of crypto",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                IconButton(
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                    icon: (themeProvider.themeMode == ThemeMode.light)
                        ? Icon(Icons.dark_mode)
                        : Icon(Icons.light_mode))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(child: Consumer<MarketProvider>(
              builder: (context, marketProvider, child) {
                if (marketProvider.isLoading == true) {
                  return Text('data not found');
                } else {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: marketProvider.markets.length,
                      itemBuilder: (context, index) {
                        CryptoCurrency CurrentcryptoCurrency =
                            marketProvider.markets[index];
                        return ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(CurrentcryptoCurrency.image!),
                          ),
                          title: Text(CurrentcryptoCurrency.name! +
                              " #${CurrentcryptoCurrency.marketCapRank}"),
                          subtitle:
                              Text(CurrentcryptoCurrency.symbol!.toUpperCase()),
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
                                    CurrentcryptoCurrency
                                        .priceChangePercentage24h!;

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
            ))
          ],
        ),
      )),
    );
  }
}
