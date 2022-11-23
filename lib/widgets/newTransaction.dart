import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  NewTransaction(this.newTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (_amountController.text.isEmpty) {
      return;
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.newTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        TextField(
          decoration: InputDecoration(labelText: 'Title'),
          controller: _titleController,
          onSubmitted: (_) => submitData(),
        ),
        TextField(
          decoration: InputDecoration(labelText: 'Amount'),
          controller: _amountController,
          keyboardType: TextInputType.number,
          onSubmitted: (_) => submitData(),
        ),
        Container(
          height: 70,
          child: Row(
            children: [
              Expanded(
                child: Text(_selectedDate == null
                    ? 'No Date Choosen!'
                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
              ),
              TextButton(
                child: Text(
                  'Choose Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: _presentDatePicker,
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
        ElevatedButton(
            child: Text(
              'Add Transaction',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: submitData,
            style: TextButton.styleFrom(
              foregroundColor: Colors.purple,
            )),
      ]),
    ));
  }
}
