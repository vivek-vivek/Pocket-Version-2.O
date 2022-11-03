// ignore_for_file: avoid_print
import 'package:budgetory_v1/DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../DB/FunctionsCategory/category_db_f.dart';
import '../../../DB/Transactions/transaction_db_f.dart';
import '../../Category Screen/Widgets/pop_up_btn_category_radio.dart';

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
    Expense.instance.refreshUiTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    Expense.instance.refreshUiTransaction();
    // ?colors class
    final colorId = ColorsID();
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "http://i.pinimg.com/originals/da/60/4b/da604b2d088a9b22688ae257f005f2d9.jpg"),
                fit: BoxFit.cover,
                scale: 1.00),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 200.000, left: 40.00, right: 40.00),
            child: Center(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(14.00),
                  child: ListView(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ^ main container------->
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          const SizedBox(height: 10),

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
                                    width: 3,
                                    color: colorId.grey), //<-- SEE HERE
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            //?-------------------------------------
                            onTap: (() async {
                              final selectedDateDUplicate =
                                  await showDatePicker(
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

                          //^ category , Add btn --------------->
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20.00, left: 20.00),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: DropdownButton(
                                    underline: Container(),
                                    hint: const Text('Select Category'),
                                    value: _categoryValue,
                                    items: (_selectedCategoryType ==
                                                CategoryType.expense
                                            ? CategoryDB()
                                                .expenseCategoryModelList
                                            : CategoryDB()
                                                .incomeCategoryModelList)
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

                                //^add rounded icon button for adding category
                                // ^it pop up a window that contain add new category function
                                TextButton(
                                  onPressed: () {
                                    popUpCaBtnCategoryRadio(
                                        context: context,
                                        selectedTypeCat: selectedCategory);
                                  },
                                  child: const Text(
                                    'Add category',
                                    style: TextStyle(fontSize: 8.00),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          //^notes--------------------->
                          TextFormField(
                            maxLength: 10,
                            controller: notesController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: 'Note',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: colorId.grey), //<-- SEE HERE
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
                            controller: amountController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Amount',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 3,
                                    color: colorId.grey), //<-- SEE HERE
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
                                  backgroundColor: Colors.lightBlueAccent),
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
       ( _categoryValue == null ||_categoryValue!.isEmpty)&&
       ( _selectedDate == null)&&
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
        //? ********************************
        Expense.instance.addTransaction(modelTransaction);
        // ********************************
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
