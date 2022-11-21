// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:budgetory_v1/DataBase/Models/ModalTransaction/transaction_modal.dart';
import 'package:budgetory_v1/DataBase/Models/ModalCategory/category_model.dart';
import 'package:budgetory_v1/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../DB/category_db_f.dart';
import '../../../DB/transaction_db_f.dart';

class EditScreen extends StatefulWidget {
  int index;
  TransactionModal transactionModal;
  // final date;
  // final category;
  // final note;
  // final amount;
  EditScreen({super.key, required this.index, required this.transactionModal});

  @override
  // ignore: no_logic_in_create_state
  State<EditScreen> createState() => _EditScreenState( );
}

class _EditScreenState extends State<EditScreen> {
  // int index;

  // TransactionModal transactionModal;

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
  // ^---------------------------------
 

//*setting up default radio selection
  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    dateController.text = widget. transactionModal.date.toString();
    notesController.text = widget.transactionModal.notes;
    amountController.text =widget. transactionModal.amount.toString();
    // _selectedDate = transactionModal.;
    // selectedDateDUplicate = ;

    CategoryDB().refreshUI();
    TransactionDB.instance.refreshUiTransaction();
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();
  DateTime? selectedDateDUplicate;
  @override
  Widget build(BuildContext context) {
    CategoryDB.instance.refreshUI();
    TransactionDB.instance.refreshUiTransaction();

    final colorId = ColorsID();

    return Scaffold(
      appBar: AppBar(
          elevation: 0.5,
          backgroundColor: colorId.white,
          iconTheme: IconThemeData(color: colorId.btnColor),
          title: Text(
            "Edit",
            style: TextStyle(color: colorId.btnColor),
          )),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 50.00, right: 30.00, left: 30.00),
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
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: colorId.black), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      //?-------------------------------------
                      onTap: () async {
                        selectedDateDUplicate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 365)),
                          lastDate: DateTime.now(),
                        );
                        if (selectedDateDUplicate == null) {
                          return;
                        } else {
                          setState(
                            () {
                              dateController.text = DateFormat.yMMMd()
                                  .format(selectedDateDUplicate!);
                              _selectedDate = selectedDateDUplicate!;
                            },
                          );
                        }
                      },
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
                          borderSide:
                              BorderSide(width: 1, color: colorId.black),
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

                    const SizedBox(height: 10.00),
                    //^add transaction button---------------->
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            try {
                              transactionAddButtons();
                            } catch (e) {
                              print("\n\n$e");
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 14, 58, 97)),
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
    TransactionDB.instance.refreshUiTransaction();
    if (notesController.text.isEmpty &&
        amountController.text.isEmpty &&
        (_categoryValue == null || _categoryValue!.isEmpty) &&
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
            date: _selectedDate,
            type: _selectedCategoryType!,
            categoryTransaction: _selectedCategoryModel!,
            id: DateTime.now().microsecondsSinceEpoch.toString());
        await TransactionDB.instance.refreshUiTransaction();

        // ^clear controllers

        notesController.clear();
        amountController.clear();
        dateController.clear();
        //  amount db function

        await TransactionDB.instance.update(widget.index, modelTransaction);
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
            TransactionDB.instance.refreshUiTransaction();
          },
        );
      },
    );
  }

  final colorId = ColorsID();
}
