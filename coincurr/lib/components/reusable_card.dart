import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  final String cryptoName;
  final String cryptoCurrency;
  final String? currencyValue;
  final String currency2;
  final Icon icon;

  const ReusableCard(
      {Key? key,
      required this.cryptoCurrency,
      required this.cryptoName,
      required this.currencyValue,
      required this.currency2,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: Color(0xFF1C1A25),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    color: Color(0xFF2B2934),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    )),
                child: icon,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20,10,0,0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cryptoName,
                        style: const TextStyle(
                          fontFamily: 'Trispace',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        )),
                    Text(
                      cryptoCurrency,
                      style: const TextStyle(
                        fontFamily: 'Trispace',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currencyValue!,
                      style: const TextStyle(
                        fontFamily: 'Trispace',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      currency2,
                      style: const TextStyle(
                        fontFamily: 'Trispace',
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
