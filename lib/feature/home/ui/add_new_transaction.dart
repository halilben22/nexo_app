import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexo_app/auth/auth_service.dart';
import 'package:nexo_app/components/home/category_card.dart';
import 'package:nexo_app/components/home/date_card.dart';
import 'package:nexo_app/components/home/note_card.dart';
import 'package:nexo_app/components/home/save_button.dart';
import 'package:nexo_app/core/theme/app_colors.dart';
import 'package:nexo_app/core/theme/app_text_styles.dart';
import 'package:nexo_app/feature/transaction/bloc/bloc/transaction_bloc.dart';
import 'package:nexo_app/models/categories.dart';
import 'package:nexo_app/models/transaction_model.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime dateNow = DateTime.now();
  bool isLoading = false;
  int? selectedIndex;
  String note = "";
  final TextEditingController _textEditingController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isExpense = true;

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
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listenWhen: (previous, current) => current is TransactionActionState,
        buildWhen: (previous, current) => current is! TransactionActionState,
        listener: (context, state) {
          if (state is TransactionSuccessShowSnackbarActionState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is TransactionErrorShowSnackbarActionState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          final isLoading = state is TransactionSavingState;
          return Column(
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
                          controller: _textEditingController,

                          style: AppTextStyles.heading1xl,
                          showCursor: false,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9.,]'),
                            ),
                          ],

                          cursorColor: AppColors.textPrimary,
                          decoration: InputDecoration(
                            suffixText: " PLN",
                            fillColor: AppColors.background,
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "0",
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              "Category",
                              style: AppTextStyles.heading2,
                            ),
                          ),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(isExpense ? "Expense" : "Income"),
                              const SizedBox(width: 8),
                              Switch(
                                activeThumbColor: AppColors.primaryButton,
                                value: isExpense,
                                onChanged: (value) {
                                  setState(() {
                                    isExpense = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
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

                          return CategoryCard(
                            categories: category,
                            isSelected: selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          );
                        },
                      ),

                      DateCard(date: dateNow, onPressed: pickDate),
                      SizedBox(height: 12),
                      NoteCard(
                        onChange: (p0) {
                          note = p0;
                        },
                      ),

                      SizedBox(height: 12),
                      SaveButton(
                        onPressed: () {
                          TransactionModel transactionModel = TransactionModel(
                            amount: double.parse(_textEditingController.text),
                            accountid: _authService.currentUser!.uid,
                            id: "",
                            title: note,
                            category: categories[selectedIndex!].name,
                            date: dateNow,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            isExpense: isExpense,
                          );

                          context.read<TransactionBloc>().add(
                            TransactionSaveEvent(
                              transactionModel: transactionModel,
                            ),
                          );
                        },
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
