import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../db/notes_database.dart';
import '../model/note.dart';
import 'note_card_widget.dart';
import 'note_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Note> notes;
  String searchKey = '';

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter keyword to search',
                  style: TextStyle(color: Colors.white, fontSize: 20.sp),
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xff413F42),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: const BorderSide(
                          color: Colors.transparent, width: 1.0),
                    ),
                  ),
                  onChanged: (value) {
                    searchKey = value;
                    setState(() {});
                  },
                ),
                SizedBox(height: 20.h),
                Text(
                  'Search Result',
                  style: TextStyle(fontSize: 20.sp, color: Colors.white),
                ),
                SizedBox(height: 20.h),
                FutureBuilder(
                  future: NotesDatabase.instance.search(searchKey),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print('error');
                    var data = snapshot.data;
                    return snapshot.hasData
                        ? Text(
                            data.toString(),
                            style: const TextStyle(color: Colors.white),
                          )
                        : const Center(
                            child: Text(
                              'No contacts that include this keyword',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, sindex) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              Get.to(NoteDetailPage(noteId: note.id!));
            },
            child: NoteCardWidget(note: note, index: index),
          );
        },
      );
}
