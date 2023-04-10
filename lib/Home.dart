import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double EMI = 0;

  final formatCurrency = new NumberFormat.compactSimpleCurrency();

  TextStyle titlestyle = const TextStyle(
    fontSize: 25,
    color: Color(0xff484848),
    fontWeight: FontWeight.w500,
  );

  TextStyle bgstyle = const TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    color: Color(0xffe5e6e8),
    letterSpacing: 2,
  );

  double loanamountsliderval = 100000;
  double interestRatesliderval = 10;
  double loanTenuresliderval = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.apps_sharp,
          color: Colors.black,
        ),
        backgroundColor: const Color(0xffa2e698),
        centerTitle: true,
        title: Text(
          "EMI Calculator",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: const Color(0xffa2e698),
            height: double.infinity,
          ),
          Column(
            children: [
              SizedBox(
                height: 27,
              ),
              Text(
                "Your Loan EMI is",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "₹ ${EMI}",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: "/ Month",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.748,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    myWidget("Loan Amount", loanamountsliderval, 0, 1000000, 0),
                    myWidget("Interest Rate", interestRatesliderval, 1, 20, 1),
                    myWidget("Loan Tenure", loanTenuresliderval, 1, 36, 2),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        primary: Colors.green,
                        backgroundColor: Color(0xffdaf5d6),
                        side: BorderSide(
                          color: Color(0xffa2e698),
                        ),
                      ),
                      child: const Text(
                        "Calculate",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        double rate = interestRatesliderval / 12 / 100;

                        double emi = loanamountsliderval *
                            rate *
                            (pow(1 + rate, loanTenuresliderval) /
                                (pow(1 + rate, loanTenuresliderval) - 1));

                        setState(() {
                          EMI = emi.toInt().toDouble();
                        });
                        print("$EMI");
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget myWidget(
      String heading, double sliderval, double _min, double _max, int i) {
    return Column(
      children: [
        Text("$heading", style: titlestyle),
        Stack(
          alignment: Alignment.center,
          children: [
            (i == 1)
                ? Text(
                    "${sliderval.toInt()} %",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                : (i == 2)
                    ? Text(
                        "${sliderval.toInt()} Months",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : (i == 0)
                        ? Text(
                            "${sliderval.round()} ₹",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : Text(
                            "${sliderval.toInt()}",
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          )
          ],
        ),
        Slider(
          value: sliderval,
          min: _min,
          max: _max,
          onChanged: (val) {
            setState(() {
              if (i == 0) {
                loanamountsliderval = val;
                sliderval = val;
              } else if (i == 1) {
                interestRatesliderval = val;
                sliderval = val;
              } else if (i == 2) {
                loanTenuresliderval = val;
                sliderval = val;
              }
            });
          },
          thumbColor: Color(0xffa2e698),
          activeColor: Color(0xffb4ebad),
          inactiveColor: Color(0xffdaf5d6),
        ),
      ],
    );
  }
}
