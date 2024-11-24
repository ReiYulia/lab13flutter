import 'package:flutter/material.dart';

class NoteForm extends StatefulWidget {
  final Function(String) onAddNote;

  NoteForm({required this.onAddNote});

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onAddNote(_noteController.text);
      _noteController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _noteController,
                decoration: InputDecoration(labelText: 'Нотатка'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Введіть текст нотатки';
                  }
                  return null;
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
