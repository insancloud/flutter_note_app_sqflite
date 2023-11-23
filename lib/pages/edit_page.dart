// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:note_app/data/datasources/local_datasource.dart';
import 'package:note_app/pages/home_page.dart';

import '../data/models/note.dart';

class EditPage extends StatefulWidget {
  const EditPage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    titleController.text = widget.note.title;
    contentController.text = widget.note.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Note"),
        elevation: 2,
        // backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Tolong masukkan Judul";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: "Konten",
                border: OutlineInputBorder(),
              ),
              maxLines: 8,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Tolong masukkan Konten";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),

      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey .currentState!.validate()) {
            Note note = Note(
              id: widget.note.id,
              title: titleController.text,
              content: contentController.text,
              createdAt: DateTime.now(),
            );
            LocalDatasource().updateNoteById(note);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Note Berhasil Diubah!"),
              )
            );
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return const HomePage();
            }));
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
