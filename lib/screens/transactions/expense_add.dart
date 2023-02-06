import 'package:flutter/material.dart';
import 'package:money_management/db/category/category_db.dart';
import 'package:money_management/db/transaction/transaction_db.dart';
import 'package:money_management/models/transaction_model/transaction_model.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:intl/intl.dart';
import '../../models/category_model/category_model.dart';
import '../basescreen/decoration.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  DateTime selectedDate = DateTime.now();
  final CategoryType _selectedCategoryType = CategoryType.expense;
  CategoryModel? _selectedCategoryModel;
  String? categoryid;
  final descriptionediting = TextEditingController();
  final amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Container(
                    alignment: Alignment.center,
                    child: textBig(
                        text: "Expenses", size: 20, weight: FontWeight.w600),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: textBig(
                          text: "How much?", size: 20, weight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: TextButton.icon(
                        onPressed: () async {
                          final selectedDatetemp = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.utc(2020, 12, 12),
                            lastDate: DateTime.utc(2026, 12, 12),
                          );
                          if (selectedDatetemp == null) {
                            return;
                          } else {
                            setState(() {
                              selectedDate = selectedDatetemp;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                        ),
                        label: Text(
                          DateFormat.MMMd().format(selectedDate),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                //--------------------------------------amount--------------------------------
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: amountcontroller,
                    style: const TextStyle(fontSize: 60, color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        focusColor: Colors.white,
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.money_outlined,
                          color: Colors.white,
                          size: 60,
                        )),
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(25))),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(23),
                      child: TextFormField(
                          controller: descriptionediting,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            labelText: 'Description',
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            value: categoryid,
                            hint: textBigB(
                                text: 'Select Category',
                                size: 15,
                                weight: FontWeight.bold),
                            items: CategoryDB.instance.expenseCategoryList.value
                                .map((e) {
                              return DropdownMenuItem(
                                  alignment: Alignment.centerRight,
                                  value: e.id,
                                  onTap: () {
                                    _selectedCategoryModel = e;
                                  },
                                  child: ListTile(
                                    title: Text(
                                      e.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    leading: Card(
                                      color: null,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child:
                                              Image.asset(e.image.toString())),
                                    ),
                                  ));
                            }).toList(),
                            onChanged: (selectedvalue) {
                              setState(() {
                                categoryid = selectedvalue;
                              });
                            },
                            isExpanded:
                                true, //make true to take width of parent widget
                            underline: Container(), //empty line
                            dropdownColor: Colors.white,
                            iconEnabledColor: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: botton(
                          onPressed: () {
                            addTransaction();

                            final snackBar = SnackBar(
                              elevation: 0,
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              content: AwesomeSnackbarContent(
                                  title: "Congratulation",
                                  message: 'Your Expense Transction added',
                                  contentType: ContentType.success),
                            );

                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(snackBar);
                          },
                          titel: "Continue"),
                    )
                  ],
                ),
              ),
            )
          ]),
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final description = descriptionediting.text;
    final parsedAmount = int.tryParse(amountcontroller.value.text);
    if (parsedAmount == null) {
      return;
    }

    final model = TransactionModel(
        category: _selectedCategoryModel!,
        type: _selectedCategoryType,
        amount: parsedAmount,
        description: description,
        calender: selectedDate);

    TransactionDb.instance.addTransaction(model);

    transactionlist.value;
    Navigator.of(context).pop();
    TransactionDb.instance.refreshUI();
    CategoryDB.instance.refreshUI();
  }
}
