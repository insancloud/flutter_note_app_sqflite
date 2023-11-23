// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:note_app/data/datasources/local_datasource.dart';

import 'package:note_app/pages/add_page.dart';
import 'package:note_app/pages/edit_page.dart';
import 'package:note_app/pages/home_page.dart';

import '../data/models/note.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Note"),
        elevation: 2,
        // backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: const Text("Konfirmasi"),
                        content: const Text("Yakin ingin menghapus ini?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(onPressed: ()  async{
                              await LocalDatasource().deleteNoteById(widget.note.id!);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) {
                                return const HomePage();
                              }));
                          }, child: const Text("Delete"))
                        ]);
                  });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            widget.note.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            widget.note.content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditPage(note: widget.note);
          }));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
}
