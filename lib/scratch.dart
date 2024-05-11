// import 'dart:ffi';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import 'package:intl/intl.dart';

class Scratch extends StatefulWidget {
  const Scratch({super.key});

  @override
  State<Scratch> createState() => _ScratchState();
}

class _ScratchState extends State<Scratch> {
  String _startDate = '';
  String _endDate = '';
  String _amountInvested = '';
  String _interestRate = '';
  String _totalAmount =
      '1000.00'; // Add a state variable to store the total amount
  String _extraAmount = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: content(),
    );
  }

  Widget FinalRupeeEle() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   'Your Total Amount !',
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: MediaQuery.of(context).size.width * 0.05,
          //   ),
          // ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '\u{20B9} $_totalAmount', // Display the total amount
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '/-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.1,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Your Amount  $_amountInvested + Extra Amount  $_extraAmount',
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.width * 0.03,
            ),
          ),
        ],
      ),
    );
  }

  void _openRangeDatePicker(
      BuildContext context, String date, Function(String) onDateSelected) {
    BottomPicker.date(
      pickerTitle: Text(
        'Select Your Date',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      dateOrder: DatePickerDateOrder.dmy,
      initialDateTime: DateTime.parse(date),
      maxDateTime: DateTime(2030),
      minDateTime: DateTime(1980),
      pickerTextStyle: TextStyle(
        color: const Color.fromARGB(255, 0, 0, 0),
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      onChange: (index) {
        date = index.toString();
        // print(index);
      },
      onSubmit: (index) {
        date = index.toString();
        // print(index);
        onDateSelected(date);
      },
      bottomPickerTheme: BottomPickerTheme.heavyRain,
    ).show(context);
  }

  TextButton _buildStartDateButton() {
    final double widthPercentage = 0.6;
    final double heightPercentage = 0.1;
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth - 17.0) * widthPercentage;
    final buttonHeight = 48.0 * heightPercentage;

    DateTime startDate;
    try {
      startDate = DateFormat('yyyy-MM-dd').parse(_startDate);
    } catch (e) {
      startDate = DateTime.now();
      _startDate = DateFormat('yyyy-MM-dd').format(startDate);
    }

    String startDateText = _isSameDate(startDate, DateTime.now())
        ? 'Select Start Date'
        : DateFormat('yyyy-MM-dd').format(startDate);

    return TextButton(
      onPressed: () {
        _openRangeDatePicker(context, _startDate, (selectedDate) {
          setState(() {
            _startDate = selectedDate;
          });
        });
        print("Start date: $_startDate");
      },
      child: Text(
        startDateText,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        fixedSize: Size(buttonWidth, buttonHeight),
      ),
    );
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  TextButton _buildEndDateButton(BuildContext context) {
    final double widthPercentage = 0.6;
    final double heightPercentage = 0.1;
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = (screenWidth - 17.0) * widthPercentage;
    final buttonHeight = 48.0 * heightPercentage;

    DateTime endDate;
    try {
      endDate = DateFormat('yyyy-MM-dd').parse(_endDate);
    } catch (e) {
      endDate = DateTime.now();
      _endDate = DateFormat('yyyy-MM-dd').format(endDate);
    }

    String endDateText = _isSameDate(endDate, DateTime.now())
        ? 'Select End Date'
        : DateFormat('yyyy-MM-dd').format(endDate);

    return TextButton(
      onPressed: () {
        _openRangeDatePicker(context, _endDate, (selectedDate) {
          setState(() {
            _endDate = selectedDate;
          });
        });
        print("End date: $_endDate");
      },
      child: Text(
        endDateText,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        fixedSize: Size(buttonWidth, buttonHeight),
      ),
    );
  }

  Widget dateRangeInput() {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth =
        screenWidth * 0.8; // adjust width to 80% of screen width
    double containerHeight =
        containerWidth * 0.6; // adjust height to 50% of container width

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 5.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              label: Text(
                'Date Range',
                style: TextStyle(
                    fontWeight: FontWeight.bold), // make labelText bold
              ),
              prefixIcon: Icon(Icons.timer),
              border: InputBorder.none, // remove border from TextField
            ),
          ),
          // SizedBox(
          //     height:
          //         2.0), // add some spacing between the TextField and the buttons
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStartDateButton(),
                // SizedBox(height: 1),
                _buildEndDateButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget amountInput() {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.8;
    double containerHeight = containerWidth * 0.2;

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 5.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(19.0)),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            _amountInvested = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Amount ₹ ${_amountInvested}',
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(Icons.monetization_on),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget interestInput() {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.8;
    double containerHeight = containerWidth * 0.2;

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 5.0, color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(19.0)),
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            _interestRate = value;
          });
        },
        decoration: InputDecoration(
          hintText: 'Interest ${_interestRate} %',
          hintStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(Icons.percent),
          border: InputBorder.none,
        ),
      ),
    );
  }

  String calculateDaysBetweenString(
      String startDateString, String endDateString) {
    // Handle potential exceptions during parsing
    try {
      final startDate = DateTime.parse(startDateString);
      final endDate = DateTime.parse(endDateString);
      final daysBetween =
          calculateDaysBetween(startDate, endDate); // Reuse existing function
      return daysBetween.toString(); // Convert days to string
    } on FormatException {
      return "Invalid date format. Please use YYYY-MM-DD.";
    }
  }

  String getExtraAmount(String totalAmount, String originalAmount) {
    double totalAmountFloat = double.parse(totalAmount);
    double originalAmountFloat = double.parse(originalAmount);

    double extraAmount = totalAmountFloat - originalAmountFloat;

    return extraAmount.toStringAsFixed(
        2); // return extra amount as string with 2 decimal places
  }

  String calculateInterest(
      String days, String interest, String amount, int Remaining365days) {
    int daysInt = int.parse(days) + Remaining365days;
    double interestFloat = double.parse(interest) / 100;
    double amountFloat = double.parse(amount);

    double interestAmount = 0;
    while (daysInt >= 0) {
      if (daysInt < 366) {
        interestAmount = ((amountFloat * daysInt) / 30) * interestFloat;
        amountFloat += interestAmount;
        break;
      } else {
        interestAmount = ((amountFloat * 366) / 30) * interestFloat;
        daysInt -= 366;
        amountFloat += interestAmount;
      }
    }

    return amountFloat.toStringAsFixed(
        2); // return total amount as string with 2 decimal places
  }

// Existing function (assuming it's defined elsewhere)
  int calculateDaysBetween(DateTime startDate, DateTime endDate) {
    // Handle potential null values (optional)
    if (startDate == null || endDate == null) {
      return 0;
    }
    final difference = endDate.difference(startDate);
    return difference.inDays;
  }

  bool isLeapYear(int year) {
    if (year % 4 != 0) {
      return false;
    } else if (year % 100 != 0) {
      return true;
    } else if (year % 400 != 0) {
      return false;
    } else {
      return true;
    }
  }

  int count365Years(String startDateStr, String endDateStr) {
    DateTime startDate = DateTime.parse(startDateStr);
    DateTime endDate = DateTime.parse(endDateStr);
    int count = 0;

    for (DateTime date = startDate;
        date.year <= endDate.year;
        date = date.add(Duration(days: 365))) {
      if (!isLeapYear(date.year)) {
        count++;
      }
    }

    return count;
  }

  Widget Calcbutton() {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.5;
    double containerHeight = containerWidth * 0.30;
    double labelFontSize = containerWidth * 0.12;
    double contentPaddingLeftRight = containerWidth * 0.23;

    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(19.0)),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Center(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                minimumSize: Size(double.infinity, 50),
                padding:
                    EdgeInsets.symmetric(horizontal: contentPaddingLeftRight),
              ),
              onPressed: () {
                // Add your button press logic here
                String totalDays =
                    calculateDaysBetweenString(_startDate, _endDate);
                int Remaining365days = count365Years(_startDate, _endDate);
                String totalamount = calculateInterest(totalDays, _interestRate,
                    _amountInvested, Remaining365days);
                // interest
                String extraamount =
                    getExtraAmount(totalamount, _amountInvested);
                setState(() {
                  _totalAmount = totalamount;
                  _extraAmount = extraamount;
                });
                // print(totalamount);
              },
              child: Text(
                'Calculate',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: labelFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget content() {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          // id: 'full-screen-black-block',
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  // id: 'black-block-1',
                  color: Colors.black,
                  child: FinalRupeeEle(),
                ),
              ),
              Expanded(
                flex: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        MediaQuery.of(context).size.width * 0.12),
                    topRight: Radius.circular(
                        MediaQuery.of(context).size.width * 0.12),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 50), // add a little space
                        dateRangeInput(),
                        SizedBox(height: 20), // add a little space
                        amountInput(),
                        SizedBox(height: 20), // add a little space
                        interestInput(),
                        SizedBox(height: 20), // add a little space
                        // Spacer(), // fill the available space
                        Calcbutton(),
                        SizedBox(height: 20), // add a little space
                        SizedBox(
                            height: 20,
                            width: double.infinity), // add a little space
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
