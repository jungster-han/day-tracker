import 'package:daysince/db/daysince.db.dart';
import 'package:daysince/models/daysince.model.dart';
import 'package:flutter/material.dart';

class AddNewDaysinceDialog extends StatefulWidget {
  final Function refreshNotes;

  const AddNewDaysinceDialog({super.key, required this.refreshNotes});

  @override
  State<AddNewDaysinceDialog> createState() => _AddNewDaysinceDialog();
}

class _AddNewDaysinceDialog extends State<AddNewDaysinceDialog> {
  DateTime selectedDate = DateTime.now();

  final descriptionController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    descriptionController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void addNewDaysince(String description, DateTime startDate) async {
    await DaysinceDatabase.instance
        .create(Daysince(description: description, startDate: startDate));
    widget.refreshNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: descriptionController,
              validator: ((value) {
                if (value == null || value.isEmpty) {
                  return 'Please add a description';
                }
                return null;
              }),
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Days since ...'),
              maxLength: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                    '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}'),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 45.0),
                    ),
                    child: const Text('Select a Date'),
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2200));

                      if (newDate == null) return;
                      setState(() => selectedDate = newDate);
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 45.0),
                      backgroundColor: Colors.blueGrey,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 45.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addNewDaysince(
                            descriptionController.text, selectedDate);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
