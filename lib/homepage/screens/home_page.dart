import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pizza/homepage/theme/theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_filed.dart';
import '../constants/app_strings.dart';


class PizzaOrderUI extends StatefulWidget {
  const PizzaOrderUI({Key? key}) : super(key: key);

  @override
  State<PizzaOrderUI> createState() => _PizzaOrderUIState();
}

class _PizzaOrderUIState extends State<PizzaOrderUI> {
  final TextEditingController peopleController = TextEditingController();
  final TextEditingController piecesController = TextEditingController();
  String _result = '';

  void _calculateCosts() {
    final int numberOfPeople = int.tryParse(peopleController.text) ?? 0;
    final int piecesPerPerson = int.tryParse(piecesController.text) ?? 0;

    if (numberOfPeople <= 0 || numberOfPeople > 999999999 || piecesPerPerson <= 0 || piecesPerPerson > 10) {
      setState(() {
        _result = 'Please enter valid numbers. (1-999,999,999 people, 1-10 pieces per person)';
      });
      return;
    }

    final int totalPieces = numberOfPeople * piecesPerPerson;

    final pizzaSizes = [
      {"size": "5 inch", "price": 3.0, "pieces": 4},
      {"size": "7 inch", "price": 5.0, "pieces": 6},
      {"size": "10 inch", "price": 8.0, "pieces": 10},
      {"size": "15 inch", "price": 12.0, "pieces": 15},
      {"size": "24 inch", "price": 18.0, "pieces": 24},
    ];

    double minCost = double.infinity;
    String bestOption = '';

    StringBuffer costs = StringBuffer('Cost for each pizza size:\n');

    for (var pizza in pizzaSizes) {
      int numPizzas = (totalPieces / (pizza["pieces"] as int)).ceil();
      double totalCost = numPizzas * (pizza["price"] as double);
      costs.writeln('${pizza["size"]}: \$${totalCost.toStringAsFixed(2)}');
      if (totalCost < minCost) {
        minCost = totalCost;
        bestOption = pizza["size"] as String;
      }
    }

    setState(() {
      _result = '$costs\nThe best option is $bestOption pizza.';
    });
  }

  @override
  void dispose() {
    peopleController.dispose();
    piecesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(AppStrings.appTitle),
        backgroundColor: appBarColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CustomText(
                AppStrings.numberOfPeople,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                controller: peopleController,
                labelText: AppStrings.numberOfPeopleText,
              ),
              SizedBox(height: context.height()*0.02),
              const CustomText(
                AppStrings.piecesPerPerson,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              CustomTextField(
                controller: piecesController,
                labelText: (AppStrings.piecesPerPersonText),
              ),
              SizedBox(height: context.height()*0.02),
              CustomButton(
                onPressed: _calculateCosts,
                buttonText: AppStrings.calculate,
                buttonColor: buttonColor,
                textColor: buttonTextColor,
                borderRadius: 2.0,
              ),
              SizedBox(height: context.height()*0.02),
              CustomText(_result),
            ],
          ),
        ),
      ),
    );
  }
}

