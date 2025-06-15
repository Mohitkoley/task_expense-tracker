import 'package:bloc_test/core/extension/context_ext.dart';
import 'package:bloc_test/core/extension/num_ext.dart';
import 'package:bloc_test/feature/todo/data/model/expense_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/expense.dart';
import 'package:bloc_test/feature/todo/presentation/bloc/expenses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensesScreen extends StatefulWidget {
  static late BuildContext openContext;
  final ExpenseModel? expensesModel;
  final int? index;

  const AddExpensesScreen({super.key, this.expensesModel, this.index});

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  TextEditingController _amountController = TextEditingController();
  ExpenseCategory category = ExpenseCategory.food;

  TextEditingController _descriptionController = TextEditingController();

  DateTime _date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.expensesModel != null) {
        _amountController.text = widget.expensesModel!.amount.toString();
        category = widget.expensesModel!.category;
        _descriptionController.text = widget.expensesModel!.description ?? "";
        _date = widget.expensesModel!.date;
        print(category);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddExpensesScreen.openContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.expensesModel == null ? 'Add Expense' : 'Edit Expense',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add or Edit Expense',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                labelText: 'Amount',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),

            const SizedBox(height: 16),
            // create a drop down button
            DropdownButtonFormField(
              items: ExpenseCategory.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.toJson()),
                      ))
                  .toList(),
              value: category,
              onChanged: (ExpenseCategory? value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            16.hBox,

            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter Description',
                labelText: 'Description',
              ),
            ),

            16.hBox,

            //date picker List tile
            ListTile(
              title: Text("${_date.toLocal()}".split(' ')[0]),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime.now(),
                );

                if (date != null) {
                  setState(() {
                    _date = date;
                  });
                }
              },
            ),

            16.hBox,

            //save button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side: BorderSide(
                  color: Colors.blue,
                  width: 2,
                ),
                minimumSize: Size(context.w, 50),
              ),
              onPressed: () {
                final expense = ExpenseModel(
                  amount: int.parse(_amountController.text),
                  date: _date,
                  description: _descriptionController.text,
                  category: category,
                );
                context.read<ExpensesBloc>().add(
                      widget.expensesModel == null
                          ? AddExpensesEvent(expense)
                          : UpdateExpensesEvent(
                              widget.index!,
                              expense,
                            ),
                    );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
