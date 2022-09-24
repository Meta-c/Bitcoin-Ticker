import 'package:bitcoin/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  double price = 0;
  void getPrice() {
    setState(() async {
      var priceData = await coinData.getCoinData(selectedCurrency);

      price = priceData['rate'];
    });
  }

  DropdownButton<String> androidDropDownButton() {
    return DropdownButton<String>(
        value: selectedCurrency,
        items: [
          for (int i = 0; i < currenciesList.length; i++)
            DropdownMenuItem(
              value: currenciesList[i],
              child: Text(currenciesList[i]),
            )
        ],
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
            getPrice();
          });
        });
  }

  CupertinoPicker iOSPicker() {
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {},
        children: [
          for (int i = 0; i < currenciesList.length; i++)
            Text(
              currenciesList[i],
              style: const TextStyle(color: Colors.white),
            )
        ]);
  }

  Widget getPicker() {
    if (Platform.isAndroid) {
      return androidDropDownButton();
    } else {
      return iOSPicker();
    }
  }

  String selectedCurrency = 'USD';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${price.toStringAsFixed(3)} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker()),
        ],
      ),
    );
  }
}


//  DropdownButton<String>(
//                 value: selectedCurrency,
//                 items: [
//                   for (int i = 0; i < currenciesList.length; i++)
//                     DropdownMenuItem(
//                       value: currenciesList[i],
//                       child: Text(currenciesList[i]),
//                     )
//                 ],
//                 onChanged: (value) {
//                   setState(() {
//                     selectedCurrency = value!;
//                   });
//                 }),