class CryptoCurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? marketCap;
  int? marketCapRank;
  double? currentPrice;
  // int? fullyDilutedValuation;
  // int? totalVolume;
  double? high24h;
  double? low24h;
  double? priceChange24h;
  double? priceChangePercentage24h;
  // double? marketCapChange24h;
  // double? marketCapChangePercentage24h;
  double? circulatingSupply;
  // int? totalSupply;
  // int? maxSupply;
  double? ath;
  // double? athChangePercentage;
  // String? athDate;
  double? atl;
  // double? atlChangePercentage;
  // String? atlDate;
  // Null? roi;
  // String? lastUpdated;

  CryptoCurrency({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.marketCap,
    this.marketCapRank,
    // this.fullyDilutedValuation,
    // this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    // this.marketCapChange24h,
    // this.marketCapChangePercentage24h,
    this.circulatingSupply,
    // this.totalSupply,
    // this.maxSupply,
    this.ath,
    // this.athChangePercentage,
    // this.athDate,
    this.atl,
    // this.atlChangePercentage,
    // this.atlDate,
    // this.roi,
    // this.lastUpdated
  });

  CryptoCurrency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    name = json['name'];
    image = json['image'];
    currentPrice = double.parse(json['current_price'].toString());
    marketCap = double.parse(json['market_cap'].toString());
    marketCapRank = json['market_cap_rank'];
    // fullyDilutedValuation = json['fully_diluted_valuation'];
    // totalVolume = json['total_volume'];
    high24h = double.parse(json['high_24h'].toString());
    low24h = double.parse(json['low_24h'].toString());
    priceChange24h = double.parse(json['price_change_24h'].toString());
    priceChangePercentage24h =
        double.parse(json['price_change_percentage_24h'].toString());
    // marketCapChange24h = json['market_cap_change_24h'];
    // marketCapChangePercentage24h = json['market_cap_change_percentage_24h'];
    circulatingSupply = double.parse(json['circulating_supply'].toString());
    // totalSupply = json['total_supply'];
    // maxSupply = json['max_supply'];
    ath = double.parse(json['ath'].toString());
    // athChangePercentage = json['ath_change_percentage'];
    // athDate = json['ath_date'];
    atl = double.parse(json['atl'].toString());
    // atlChangePercentage = json['atl_change_percentage'];
    // atlDate = json['atl_date'];
    // roi = json['roi'];
    // lastUpdated = json['last_updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['image'] = this.image;
    data['current_price'] = this.currentPrice;
    data['market_cap'] = this.marketCap;
    data['market_cap_rank'] = this.marketCapRank;
    // data['fully_diluted_valuation'] = this.fullyDilutedValuation;
    // data['total_volume'] = this.totalVolume;
    data['high_24h'] = this.high24h;
    data['low_24h'] = this.low24h;
    data['price_change_24h'] = this.priceChange24h;
    data['price_change_percentage_24h'] = this.priceChangePercentage24h;
    // data['market_cap_change_24h'] = this.marketCapChange24h;
    // data['market_cap_change_percentage_24h'] =
    //     this.marketCapChangePercentage24h;
    data['circulating_supply'] = this.circulatingSupply;
    // data['total_supply'] = this.totalSupply;
    // data['max_supply'] = this.maxSupply;
    data['ath'] = this.ath;
    // data['ath_change_percentage'] = this.athChangePercentage;
    // data['ath_date'] = this.athDate;
    data['atl'] = this.atl;
    // data['atl_change_percentage'] = this.atlChangePercentage;
    // data['atl_date'] = this.atlDate;
    // data['roi'] = this.roi;
    // data['last_updated'] = this.lastUpdated;
    return data;
  }
}
