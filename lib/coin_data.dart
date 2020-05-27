import 'package:bitcoin_ticker/network.dart';
import 'package:bitcoin_ticker/constants.dart' as Constants;

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
  Future<List<dynamic>> getCoinData(String currencyCode) async {
    NetworkHelper networkHelper = NetworkHelper(
      apiURL: Constants.coinURL,
      apiKey: Constants.coinApiKey,
    );

    List<dynamic> coinsData = await networkHelper.getData(currencyCode);

    return coinsData;
  }
}
