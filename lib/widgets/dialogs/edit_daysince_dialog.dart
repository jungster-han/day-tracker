import 'package:daysince/db/daysince_db.dart';
import 'package:daysince/models/daysince_detail.model.dart';
import 'package:flutter/material.dart';

class EditDaysinceDialog extends StatefulWidget {
  DaysinceDetail detail;
  EditDaysinceDialog({super.key, required this.detail});
  @override
  State<EditDaysinceDialog> createState() => _EditDaysinceDialog();
}

class _EditDaysinceDialog extends State<EditDaysinceDialog> {
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    descriptionController.text = widget.detail.description;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    descriptionController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = widget.detail.startingDate;

    Future updateDaysince() async {
      final daysince = widget.detail.copy(
          id: widget.detail.id,
          description: descriptionController.text,
          startingDate: selectedDate);
      await DaysinceDatabase.instance.updateDaysince(daysince);
    }

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
                      backgroundColor: Colors.blueGrey,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateDaysince();
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
