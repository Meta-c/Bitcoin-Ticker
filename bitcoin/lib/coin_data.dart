import 'dart:convert';
import 'package:http/http.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  //CoinData({required this.currency});

  //String currency;
//  // late String url =
//       'https://rest.coinapi.io/v1/exchangerate/BTC/$currency?apikey=02BA1CA9-5836-482F-B08A-55F7655DE090';

  Future<dynamic> getCoinData(String currency, String crypto) async {
    Response jsonData = await get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=02BA1CA9-5836-482F-B08A-55F7655DE090'));
    String data = jsonData.body;
    var decodedData = jsonDecode(data);
    return decodedData;
  }
}
