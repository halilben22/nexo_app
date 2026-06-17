import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nexo_app/components/home/category_card.dart';
import 'package:nexo_app/components/home/date_card.dart';
import 'package:nexo_app/core/theme/app_colors.dart';

import 'package:nexo_app/core/theme/app_text_styles.dart';
import 'package:nexo_app/models/categories.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime dateNow = DateTime.now();
  Future<void> pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(dateNow.year),
      lastDate: DateTime(2099),
    );

    if (picked != null) {
      setState(() {
        dateNow = picked;
      });
    }
  }

  final List<Categories> categories = [
    Categories(name: "Food", icon: Icons.restaurant),
    Categories(name: "Transport", icon: Icons.local_gas_station),
    Categories(name: "Sport", icon: Icons.sports_soccer),
    Categories(name: "Shopping", icon: Icons.shopping_bag),
    Categories(name: "Travel", icon: Icons.flight),
    Categories(name: "Health", icon: Icons.favorite),
    Categories(name: "Gifts", icon: Icons.card_giftcard),
    Categories(name: "Other", icon: Icons.category),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Add New"),
        backgroundColor: Colors.transparent,
        leading: Icon(Icons.arrow_back),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(Icons.notifications_none),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(Icons.circle),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
              width: double.infinity,

              child: Column(
                children: [
                  Text("AMOUNT", style: AppTextStyles.caption),
                  IntrinsicWidth(
                    child: TextField(
                      showCursor: false,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      cursorColor: AppColors.textPrimary,
                      decoration: InputDecoration(
                        fillColor: AppColors.background,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "0.00 PLN",
                        hintStyle: AppTextStyles.heading1xl,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: EdgeInsets.only(left: 12, right: 12),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Text("Category", style: AppTextStyles.heading2),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),

                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];

                      return CategoryCard(categories: category);
                    },
                  ),

                  Container(
                    child: DateCard(date: dateNow, onPressed: pickDate),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
