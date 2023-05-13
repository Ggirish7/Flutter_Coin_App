import 'package:coincurr/components/reusable_card.dart';
import 'package:coincurr/functions/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coincurr/functions/networking.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:coincurr/constants.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  // late FocusNode focusNode;
  late TextEditingController textFieldController;
  late FixedExtentScrollController scrollController;
  int selectedCupertinoIndex = 9;
  String selectedItem = "INR";

  Widget iOSCupertinoPicker() {
    List<Center> pickerCurrency = [];
    for (String currency in currenciesList) {
      var newCurrency = Center(
        child: Text(currency),
      );
      pickerCurrency.add(newCurrency);
    }
    return Container(
      height: 300.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 30.0),
      color: const Color(0xFF1C1A25),
      child: CupertinoPicker(
          scrollController: scrollController,
          backgroundColor: const Color(0xFF1C1A25),
          itemExtent: 64,
          onSelectedItemChanged: (selectedIndex) {
            setState(() {
              selectedItem = currenciesList[selectedIndex];
              selectedCupertinoIndex = selectedIndex;
              getData(selectedItem);
            });
          },
          children: pickerCurrency),
    );
  }

  CupertinoButton getIOSPicker() {
    return CupertinoButton(
      borderRadius: const BorderRadius.all(
        Radius.circular(15.0),
      ),
      color: Colors.white,
      onPressed: () {
        scrollController.dispose();
        scrollController =
            FixedExtentScrollController(initialItem: selectedCupertinoIndex);
        showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: [iOSCupertinoPicker()],
            cancelButton: CupertinoActionSheetAction(
              child: const Text(
                "Cancel",
                style: kTextStyle,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        );
      },
      child: const Text(
        "Change Currency",
        style: TextStyle(
          fontFamily: 'Trispace',
          fontSize: 16.0,
          fontWeight: FontWeight.w900,
          color: Color(0xFF651DFF),
        ),
      ),
    );
  }

  DropdownButtonFormField androidDropdownMenu() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(
          currency,
          style: kTextStyle,
        ),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButtonFormField(
        alignment: Alignment.center,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFF07060B),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Color(0xFF07060B),
            ),
          ),
          filled: true,
          hintText: 'Change Currency',
          hintStyle: kTextStyle,
        ),
        dropdownColor: const Color(0xFF1C1A25),
        menuMaxHeight: 500.0,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedItem = value;
          });
        });
  }

  // API Call //
  //Creating MAP and storing the values of the respective cryptos and different currencies
  Map<String, String> coinValues = {};
  bool isWaiting = false;
  void getData(String currency2) async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(currency2);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData(selectedItem);
    scrollController =
        FixedExtentScrollController(initialItem: selectedCupertinoIndex);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "COINCURR",
          style: TextStyle(
            fontFamily: 'Trispace',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        ReusableCard(
          cryptoName: 'BitCoin',
          cryptoCurrency: 'BTC',
          currencyValue: isWaiting ? '?' : coinValues['BTC'],
          currency2: selectedItem,
          icon: const Icon(
            CryptoFontIcons.BTC,
            color: Color(0xFFF5B300),
            size: 40,
          ),
        ),
        ReusableCard(
          cryptoName: 'Ethereum',
          cryptoCurrency: 'ETH',
          currencyValue: isWaiting ? '?' : coinValues['ETH'],
          currency2: selectedItem,
          icon: const Icon(
            CryptoFontIcons.ETH,
            size: 40,
            color: Colors.white,
          ),
        ),
        ReusableCard(
          cryptoName: 'Litecoin',
          cryptoCurrency: 'LTC',
          currencyValue: isWaiting ? '?' : coinValues['LTC'],
          currency2: selectedItem,
          icon: const Icon(
            CryptoFontIcons.LTC,
            size: 40,
            color: Color(0xFF345D9D),
          ),
        ),
        ReusableCard(
          cryptoName: 'Dogecoin',
          cryptoCurrency: 'DOGE',
          currencyValue: isWaiting ? '?' : coinValues['DOGE'],
          currency2: selectedItem,
          icon: const Icon(
            CryptoFontIcons.DOGE,
            size: 40,
            color: Color(0xFFD3AF4E),
          ),
        ),
        ReusableCard(
          cryptoName: 'Tether',
          cryptoCurrency: 'USDT',
          currencyValue: isWaiting ? '?' : coinValues['USDT'],
          currency2: selectedItem,
          icon: const Icon(
            CryptoFontIcons.USDT,
            size: 40,
            color: Color(0xFF1A9A74),
          ),
        ),

        //ANDROID Picker
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
          child: SizedBox(width: 200, height: 55, child: androidDropdownMenu()),
        ),

        //IOS Picker
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: getIOSPicker(),
        // )
      ]),
    );
  }
}
