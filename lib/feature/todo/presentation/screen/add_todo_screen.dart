import 'package:bloc_test/core/extension/context_ext.dart';
import 'package:bloc_test/core/extension/num_ext.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpensesScreen extends StatefulWidget {
  static late BuildContext openContext;
  final TodoModel? todoModel;
  final int? index;

  const AddExpensesScreen({super.key, this.todoModel, this.index});

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  final TextEditingController _titleController = TextEditingController();
  TodoCategory category = TodoCategory.food;

  final TextEditingController _descriptionController = TextEditingController();

  DateTime _date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.todoModel != null) {
        _titleController.text = widget.todoModel!.title;
        category = widget.todoModel!.category;
        _descriptionController.text = widget.todoModel!.description ?? "";
        _date = widget.todoModel!.dateTime;
        print(category);
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AddExpensesScreen.openContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.todoModel == null ? 'Add Todo' : 'Edit Todo',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add or Edit Todo',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              keyboardType: TextInputType.number,
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter Title',
                labelText: 'Title',
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
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
            // create a drop down button
            DropdownButtonFormField(
              items: TodoCategory.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.toJson()),
                      ))
                  .toList(),
              value: category,
              onChanged: (TodoCategory? value) {
                setState(() {
                  category = value!;
                });
              },
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
                final expense = TodoModel(
                  title: _titleController.text,
                  dateTime: _date,
                  description: _descriptionController.text,
                  category: category,
                );
                context.read<TodoBloc>().add(
                      widget.todoModel == null
                          ? AddTodoEvent(expense)
                          : UpdateTodoEvent(
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
