import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../db/notes_database.dart';
import '../model/note.dart';
import 'edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    note = await NotesDatabase.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12.sp),
                child: GestureDetector(
                  onTap: () async {
                    if (isLoading) return;
                    await Get.to(AddEditNotePage(note: note));
                    refreshNote();
                  },
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    children: [
                      Text(
                        note.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        DateFormat.yMMMd().format(note.createdTime),
                        style: const TextStyle(color: Colors.white38),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        note.description,
                        style:
                            TextStyle(color: Colors.white70, fontSize: 18.sp),
                      )
                    ],
                  ),
                ),
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(
        LineAwesomeIcons.pen,
        size: 25.sp,
      ),
      onPressed: () async {
        if (isLoading) return;
        await Get.to(AddEditNotePage(note: note));

        refreshNote();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(
          LineAwesomeIcons.cut,
          size: 25.sp,
        ),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);
          Get.back();
        },
      );
}


