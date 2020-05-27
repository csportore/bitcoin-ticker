import 'package:bitcoin_ticker/network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> rates = {};
  String stringRate = '?';
  CoinData coinData = CoinData();

  @override
  void initState() {
    super.initState();

    //updateUI(json);
  }

  void updateUI(List<dynamic> jsons, String currency) async {
    rates.clear();
    for (var json in jsons) {
      double rate = json['rate'];
      stringRate = rate.toStringAsFixed(2);
      String cryptoCurrency = json['asset_id_base'];
      rates.putIfAbsent(cryptoCurrency, () => stringRate);
    }
    print(currency);
    print('RATES $rates');
    selectedCurrency = currency;
  }

  // For Android
  DropdownButton<String> buildAndroidDropDown() {
    List<DropdownMenuItem<String>> menuItemsList = [];
    currenciesList.forEach((element) {
      DropdownMenuItem<String> dmi = DropdownMenuItem(
        child: Text(element),
        value: element,
      );
      menuItemsList.add(dmi);
    });

    return DropdownButton<String>(
      items: menuItemsList,
      value: selectedCurrency,
      onChanged: (value) async {
        selectedCurrency = value;
        List<dynamic> jsons = await coinData.getCoinData(selectedCurrency);
        setState(() {
          updateUI(jsons, value);
        });
      },
    );
  }

  // For IOS
  CupertinoPicker buildIOSPicker() {
    List<Text> menuItemsList = [];
    currenciesList.forEach((element) {
      menuItemsList.add(Text(element));
    });

    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: menuItemsList,
    );
  }

  Widget buildCurrencyDisplayer(currency) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $currency = ${rates[currency]} $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildCurrencyDisplayer('BTC'),
              buildCurrencyDisplayer('ETH'),
              buildCurrencyDisplayer('LTC'),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child:
                Platform.isAndroid ? buildAndroidDropDown() : buildIOSPicker(),
          ),
        ],
      ),
    );
  }
}
