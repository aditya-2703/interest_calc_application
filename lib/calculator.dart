import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:interest_calc_application/login.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final startDate = args['startDate'] ?? '';
    final endDate = args['endDate'] ?? '';
    final amount = args['amountInvested'] ?? '';
    final interestRate = args['interestRate'] ?? '';

    return Scaffold(
      body: content(startDate, endDate, amount, interestRate),
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

  String calculateInterest(String days, String interest, String amount) {
    int daysInt = int.parse(days);
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

  Widget content(
      String startDate, String endDate, String amount, String interestRate) {
    // total days
    String totalDays = calculateDaysBetweenString(startDate, endDate);

    // total amount
    String totalamount = calculateInterest(totalDays, interestRate, amount);

    // interest
    String extraamount = getExtraAmount(totalamount, amount);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Container(
            height: 100,
            width: double.infinity,
            child: Image.asset(
              "assets/images/3.0x/jewelry.png",
              width: 100,
              height: 100,
            ),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(0, 10, 0),
          child: Text(
            "Calculator",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        inputField(Icons.money, "Invested Amount : " + amount),
        SizedBox(
          height: 20,
        ),
        inputField(Icons.timer, totalDays + " Day's"),
        SizedBox(
          height: 20,
        ),
        inputField(Icons.payment, extraamount),
        SizedBox(
          height: 20,
        ),
        inputField(Icons.percent, interestRate),
        SizedBox(
          height: 30,
        ),
        Text("Monthly Repayment : ", style: TextStyle(fontSize: 18)),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70),
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "\₹  " + totalamount,
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
