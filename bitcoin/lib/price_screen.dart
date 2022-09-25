import 'package:bitcoin/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  CoinData coinData = CoinData();
  double bitPrice = 0;
  double ethPrice = 0;
  double ltcPrice = 0;
  void getPrices() async {
    for (int i = 0; i < cryptoList.length; i++) {
      var priceData =
          await coinData.getCoinData(selectedCurrency, cryptoList[i]);
      if (cryptoList[i] == 'BTC')
        bitPrice = priceData['rate'];
      else if (cryptoList[i] == 'ETH')
        ethPrice = priceData['rate'];
      else
        ltcPrice = priceData['rate'];
    }
    setState(() {});
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
            getPrices();
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

  late Widget cardFinal;
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
          cardWidget(
            cryptoCurrency: 'BTC',
            price: bitPrice,
            selectedCurrency: selectedCurrency,
          ),
          cardWidget(
            cryptoCurrency: 'ETH',
            price: ethPrice,
            selectedCurrency: selectedCurrency,
          ),
          cardWidget(
            cryptoCurrency: 'LTC',
            price: ltcPrice,
            selectedCurrency: selectedCurrency,
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

class cardWidget extends StatefulWidget {
  const cardWidget(
      {Key? key,
      required this.price,
      required this.selectedCurrency,
      required this.cryptoCurrency})
      : super(key: key);

  final double price;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  State<cardWidget> createState() => _cardWidgetState();
}

class _cardWidgetState extends State<cardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${widget.cryptoCurrency} = ${widget.price.toStringAsFixed(3)} ${widget.selectedCurrency}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
