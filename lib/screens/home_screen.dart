import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/note.dart';
import '../widgets/note_form.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Note>> _noteList;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() {
    setState(() {
      _noteList = DatabaseHelper.instance.fetchNotes();
    });
  }

  void _addNote(String content) async {
    final newNote = Note(
      content: content,
      createdAt: DateTime.now().toIso8601String(),
    );
    await DatabaseHelper.instance.insertNote(newNote);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Нотатки')),
      body: Column(
        children: [
          NoteForm(onAddNote: _addNote),
          Expanded(
            child: FutureBuilder<List<Note>>(
              future: _noteList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Нотаток немає'));
                }
                final notes = snapshot.data!;
                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return ListTile(
                      title: Text(note.content),
                      subtitle: Text(note.createdAt),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
