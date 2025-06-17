import 'package:bloc_test/core/di/di.dart';
import 'package:bloc_test/core/extension/context_ext.dart';
import 'package:bloc_test/core/extension/num_ext.dart';
import 'package:bloc_test/core/utils/common_datetime_format.dart';
import 'package:bloc_test/feature/todo/data/model/todo_model.dart';
import 'package:bloc_test/feature/todo/domain/entity/todo.dart';
import 'package:bloc_test/feature/todo/presentation/bloc/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

class AddOrUpdateTodoScreen extends StatefulWidget {
  static late BuildContext openContext;
  final TodoModel? todoModel;

  const AddOrUpdateTodoScreen({
    super.key,
    this.todoModel,
  });

  @override
  State<AddOrUpdateTodoScreen> createState() => _AddOrUpdateTodoScreenState();
}

class _AddOrUpdateTodoScreenState extends State<AddOrUpdateTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  TodoCategory category = TodoCategory.food;

  final TextEditingController _descriptionController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  final _formKey = GlobalKey<FormState>();

  void setEndTime(DateTime? dateTime) {
    if (dateTime != null) {
      setState(() {
        _endDate = dateTime.add(const Duration(hours: 1));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.todoModel != null) {
        _titleController.text = widget.todoModel!.title;
        category = widget.todoModel!.category;
        _descriptionController.text = widget.todoModel!.description ?? "";
        _startDate = widget.todoModel!.startDateTime;
        _endDate = widget.todoModel!.endDateTime;
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
    AddOrUpdateTodoScreen.openContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.todoModel == null ? 'Add Todo' : 'Edit Todo',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add or Edit Todo',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  labelText: 'Title',
                ),
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
                validator: (value) {
                  if (value == null) {
                    return 'Please select a category';
                  }
                  return null;
                },
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
              FormField<DateTime>(validator: (value) {
                if (value == null) {
                  return 'Please select a date';
                }
                return null;
              }, builder: (FormFieldState<DateTime> state) {
                return ListTile(
                  title: Text(_startDate?.dateTime ?? "Pick Date"),
                  subtitle: const Text("Start Time"),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final date = await showOmniDateTimePicker(
                        context: context, initialDate: _startDate);
                    if (widget.todoModel?.startDateTime == null) {
                      setEndTime(date);
                    }
                    if (date != null) {
                      setState(() {
                        _startDate = date;
                        state.didChange(date);
                      });
                    }
                  },
                );
              }),
              16.hBox,
              ListTile(
                title: Text(_endDate?.dateTime ?? "Pick Date"),
                subtitle: const Text("End Time"),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  if (_startDate == null) {
                    context.showSnack('Please select start date first');
                    return;
                  }

                  final date = await showOmniDateTimePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: _endDate,
                  );

                  if (date != null) {
                    if (date != _startDate) {
                      setState(() {
                        _endDate = date;
                      });
                    } else {
                      context.showSnack('End date must be after start date');
                    }
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
                  side: const BorderSide(
                    color: Colors.blue,
                    width: 2,
                  ),
                  minimumSize: Size(context.w, 50),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final isar = getIt<Isar>();

                    final expense = TodoModel(
                      id: widget.todoModel?.id ??
                          isar.todoModels.autoIncrement(),
                      kTitle: _titleController.text.trim(),
                      kStartDateTime: _startDate ?? DateTime.now(),
                      kEndDateTime: _endDate ?? DateTime.now(),
                      kDescription: _descriptionController.text.trim(),
                      kCategory: category,
                    );

                    if (widget.todoModel == null) {
                      context.read<TodoCubit>().addTodo(expense);
                    } else {
                      context.read<TodoCubit>().updateTodo(expense);
                    }

                    Navigator.pop(context);
                  } else {
                    context.showSnack("Please fill all the fields");
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
