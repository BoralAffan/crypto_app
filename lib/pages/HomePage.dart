import 'package:crypto_app/models/CryptoCurrency.dart';
import 'package:crypto_app/pages/allCryptoDetails.dart';
import 'package:crypto_app/pages/detailPage.dart';
import 'package:crypto_app/pages/favourites.dart';
import 'package:crypto_app/providers/marketProviders.dart';
import 'package:crypto_app/providers/themeProviders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeModeProvider themeProvider =
        Provider.of<ThemeModeProvider>(context, listen: false);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Home'),
      // ),
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
            TabBar(controller: tabController, tabs: [
              Tab(
                child: Text(
                  'Top 20 crypto',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Tab(
                child: Text(
                  'Favourites',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            ]),
            Expanded(
              child: TabBarView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                controller: tabController,
                children: [AllCrypto(), Favourites()],
              ),
            )
          ],
        ),
      )),
    );
  }
}
