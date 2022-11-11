// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:budgetory_v1/DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../DB/category_db_f.dart';
import '../../DB/transaction_db_f.dart';
import '../category_screen/widgets/pop_up_btn_category_radio.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? _categoryValue;

  // ?text editing controller --> notes,amount
  final notesController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();
  //?**********************************************?

  // ^Global keys--------->
  final formKey = GlobalKey<FormState>();
  // ^*********************^

//*setting up default radio selection
  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    CategoryDB().refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    // ?colors class
    final colorId = ColorsID();
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 100.00, right: 30.00, left: 30.00),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ^ main container------->
                Column(
                  children: [
                    //^ radio button----------->
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ^ income radio------------>
                        Radio(
                          value: CategoryType.income,
                          groupValue: _selectedCategoryType,
                          onChanged: (value) {
                            setState(() {
                              _selectedCategoryType = value;
                              print(_selectedCategoryType);
                              _categoryValue = null;
                            });
                          },
                        ),
                        const Text("Income"),
                        // ^Expenses radio btn start---->
                        Radio(
                          value: CategoryType.expense,
                          groupValue: _selectedCategoryType,
                          onChanged: (value) {
                            setState(
                              () {
                                _selectedCategoryType = value;
                                print(_selectedCategoryType);
                                _categoryValue = null;
                              },
                            );
                          },
                        ),
                        const Text("Expense"),
                      ],
                    ),
                    const SizedBox(height: 30.00),

                    //^calender----------------->

                    TextFormField(
                      controller: dateController,
                      decoration: InputDecoration(
                        hintText: 'Date',
                        // _selectedDate == null
                        //     ? 'Select Date'
                        //     : DateFormat.yMMMMd().format(_selectedDate!)
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: colorId.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      //?-------------------------------------
                      onTap: (() async {
                        final selectedDateDUplicate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365 * 1000)),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDateDUplicate == null) {
                          return;
                        } else {
                          setState(
                            () {
                              dateController.text = DateFormat.yMMMd()
                                  .format(selectedDateDUplicate);
                              _selectedDate = selectedDateDUplicate;
                            },
                          );
                        }
                      }),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'choose date';
                        } else {
                          return null;
                        }
                      },
                      // ?---------------------------------------
                    ),
                    const SizedBox(height: 30.00),
                    //^ category , Add btn --------------->
                    Container(
                      width: 500.00,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        border: Border.all(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.00),
                            child: SizedBox(
                              child: DropdownButton(
                                underline: Container(),
                                hint: const Text('Select Category'),
                                value: _categoryValue,
                                items: (_selectedCategoryType ==
                                            CategoryType.expense
                                        ? CategoryDB().expenseCategoryModelList
                                        : CategoryDB().incomeCategoryModelList)
                                    .value
                                    .map((e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name),
                                    onTap: () {
                                      _selectedCategoryModel = e;
                                      print("🪦${e.name}");
                                    },
                                  );
                                }).toList(),
                                onChanged: (selectedValue) {
                                  setState(
                                    () {
                                      _categoryValue = selectedValue;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),

                          //^add rounded icon button for adding category
                          // ^it pop up a window that contain add new category function
                          IconButton(
                            onPressed: () {
                              popUpCaBtnCategoryRadio(
                                  context: context,
                                  selectedTypeCat: selectedCategory);
                            },
                            icon: const Icon(Icons.add_circle_outline),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.00),
                    //^notes--------------------->
                    TextFormField(
                      maxLength: 10,
                      controller: notesController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: 'Note',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: colorId.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter a Note';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.00),

                    //^Amount--------------------->
                    TextFormField(
                      maxLength: 10,
                      controller: amountController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: colorId.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Amount ';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 40.00),
                    //^add transaction button---------------->
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            transactionAddButtons();
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: colorId.purple),
                        child: const Text("Add Transactions"),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

// !x x x x x  x x x x x x x x  x x x x x x x x x x x x x x x x x x x x x x x x x x x x  x x x x  x xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  //? add-trs  button functions
  Future<void> transactionAddButtons() async {
    if (notesController.text.isEmpty &&
        amountController.text.isEmpty &&
        (_categoryValue == null || _categoryValue!.isEmpty) &&
        (_selectedDate == null) &&
        (_selectedCategoryModel == null)) {
      const snackBar = SnackBar(content: Text('enter complete data!!!!'));
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    } else {
      if (formKey.currentState!.validate()) {
        print("🍬");
        final parsedAmount = double.tryParse(amountController.text.trim());

        final modelTransaction = TransactionModal(
            notes: notesController.text,
            amount: parsedAmount!,
            date: _selectedDate!,
            type: _selectedCategoryType!,
            categoryTransaction: _selectedCategoryModel!);
        // amount DB
        // final pieAmount = TransactionDbAmount(
        //   total: TransactionDB.instance.totalTransaction()[0],
        //   income: TransactionDB.instance.totalTransaction()[1],
        //   expence: TransactionDB.instance.totalTransaction()[2],
        // );

        // ^clear controllers
        notesController.clear();
        amountController.clear();
        dateController.clear();
        //  amount db function

        await TransactionDB.instance.addTransaction(modelTransaction);
        // await TransactionDB.instance.amountTransaction(pieAmount);
        final snackBar = SnackBar(
          content: Text(
            'Successfully transaction added',
            style: TextStyle(color: colorId.black),
          ),
          backgroundColor: (colorId.lightGreen),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  dropD() {
    DropdownButton(
      // underline: Container(),
      hint: const Text('Select Category'),
      value: _categoryValue,
      items: (_selectedCategoryType == CategoryType.expense
              ? CategoryDB().expenseCategoryModelList
              : CategoryDB().incomeCategoryModelList)
          .value
          .map((e) {
        return DropdownMenuItem(
          value: e.id,
          child: Text(e.name),
          onTap: () {
            _selectedCategoryModel = e;
            print("🪦${e.name}");
          },
        );
      }).toList(),
      onChanged: (selectedValue) {
        setState(
          () {
            _categoryValue = selectedValue;
          },
        );
      },
    );
  }

  final colorId = ColorsID();
}
