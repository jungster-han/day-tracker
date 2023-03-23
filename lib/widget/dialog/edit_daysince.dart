import 'package:daysince/db/daysince.db.dart';
import 'package:daysince/models/daysince.model.dart';
import 'package:flutter/material.dart';

class EditDaysinceDialog extends StatefulWidget {
  Daysince detail;
  final Function refreshNotes;
  EditDaysinceDialog(
      {super.key, required this.detail, required this.refreshNotes});
  @override
  State<EditDaysinceDialog> createState() => _EditDaysinceDialog();
}

class _EditDaysinceDialog extends State<EditDaysinceDialog> {
  final descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.detail.description;
    selectedDate = widget.detail.startDate;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    descriptionController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  Future updateDaysince(selectedDate) async {
    final daysince = widget.detail.copy(
        id: widget.detail.id,
        description: descriptionController.text,
        startDate: selectedDate);
    await DaysinceDatabase.instance.update(daysince);
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
                        updateDaysince(selectedDate);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Update'))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
