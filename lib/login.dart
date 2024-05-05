// import 'dart:js';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _startDate = '';
  String _endDate = '';
  String _amountInvested = '';
  String _interestRate = '';
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _amountInvestedController = TextEditingController();
  final _interestRateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget content() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Center(
                child: Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Column(children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top:
                            200), // Add 100 pixels of space above the image and text

                    child: Image.asset(
                      "assets/images/3.0x/jewelry.png",
                      width: 100,
                      height: 100,
                    )),
                Transform(
                    transform: Matrix4.translationValues(0, 0, 0),
                    child: Text(
                      "Welcome !",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ))
              ]),
            ))),
        SizedBox(
          height: 30,
        ),
        // inputField(Icons.calendar_today, "abcd@gmail.com"),
        selectDate(context, "Start Date"),
        SizedBox(
          height: 20,
        ),
        // inputField(Icons.calendar_today, "abc!r235"),
        selectDate(context, "End Date"),
        SizedBox(
          height: 20,
        ),
        // inputField(Icons.percent, "abc!r235"),
        selectTextNumField(
            context, "Amount Invested", Icons.money, TextInputType.number),
        SizedBox(
          height: 20,
        ),
        // inputField(Icons.percent, "abc!r235"),
        selectTextNumField(
          context,
          "Interest Rate",
          Icons.percent,
          TextInputType.numberWithOptions(decimal: true),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed("/calculator", arguments: {
              'startDate': _startDate,
              'endDate': _endDate,
              'amountInvested': _amountInvested,
              'interestRate': _interestRate,
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Calculate",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget selectDate(BuildContext context, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          readOnly: true,
          controller: hintText == "Start Date"
              ? _startDateController
              : _endDateController,
          onTap: () {
            _selectDate(context, (value) {
              if (hintText == "Start Date") {
                _startDateController.text = value;
                setState(() {
                  _startDate = value;
                });
              } else {
                _endDateController.text = value;
                setState(() {
                  _endDate = value;
                });
              }
            });
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(Icons.calendar_today),
            hintText: hintText,
          ),
        ),
      ),
    );
  }

  Widget selectTextNumField(BuildContext context, String hintText,
      IconData icon, TextInputType inputType,
      {TextInputFormatter? inputFormatter}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          inputFormatters: inputFormatter != null ? [inputFormatter] : null,
          keyboardType: inputType,
          onChanged: (value) {
            if (hintText == "Interest Rate") {
              _interestRate = value;
            } else if (hintText == "Amount Invested") {
              _amountInvested = value;
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(icon),
            hintText: hintText,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context, Function(String) onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (picked != null) {
      // Format the picked date to your desired format
      String formattedDate = "${picked.year}-${picked.month}-${picked.day}";

      DateFormat format = DateFormat('yyyy-MM-dd');
      DateTime date = format.parse(formattedDate);
      formattedDate = format.format(date);

      // Call the callback function to update the value of the TextField
      onDateSelected(formattedDate);
    }
  }
}

Widget inputField(IconData icon, String hinttext) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 3)),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(icon),
                hintText: hinttext),
          )));
}
