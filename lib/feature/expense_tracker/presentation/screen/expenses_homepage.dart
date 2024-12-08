//crate a UI for the expenses homepage with following requirements:
//1. show a list of expenses
//2. show a button to add a new expense
//3. show a button to filter expenses by date
//4. show a button to filter expenses by category
//5. show a button to delete an expense
//6. show a button to update an expense
//7. on Tapping expenses List got to add expense page
import 'package:flutter/material.dart';

class ExpensesHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Homepage'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with the actual number of expenses
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      'Expense $index'), // Replace with actual expense data
                  onTap: () {
                    // Navigate to add expense page
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Update expense
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Delete expense
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add new expense
                },
                child: Text('Add Expense'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Filter expenses by date
                },
                child: Text('Filter by Date'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Filter expenses by category
                },
                child: Text('Filter by Category'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
