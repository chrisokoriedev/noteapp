import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

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
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.1),
                child: InkWell(
                  enableFeedback: true,
                  borderRadius: BorderRadius.circular(20.r),
                  radius: 120,
                  onTap: () => Get.back(),
                  child: Icon(
                    LineAwesomeIcons.arrow_left,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                    borderSide:
                        const BorderSide(color: Colors.transparent, width: 1.0),
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
              FutureBuilder<List<NoteSearch>>(
                future: NotesDatabase.instance.search(searchKey),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    print('error');
                  } else if (snapshot.isNull == false) {
                    const Center(
                      child: Text(
                        'Search not Found',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  List<NoteSearch> data = List.from(snapshot.data);
                  return snapshot.hasData
                      ? Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final time = DateFormat.yMMMd()
                                  .format(data[index].createdTime);

                              return GestureDetector(
                                onTap: () {
                                  Get.to(
                                    NoteDetailPage(noteId: data[index].id),
                                  );
                                },
                                child: Container(
                                  height: 80.h,
                                  padding: EdgeInsets.all(10.sp),
                                  margin: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xff68A7AD),
                                            Color(0xff99C4C8)
                                          ]),
                                      color: Colors.white.withOpacity(0.8),
                                      borderRadius:
                                          BorderRadius.circular(15.r)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        time,
                                        style: GoogleFonts.akshar(
                                            fontSize: 13.sp,
                                            color: Colors.black54),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 250.w,
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  data[index].title,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  style: GoogleFonts.gabriela(
                                                      color: Colors.black,
                                                      fontSize: 18.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 300.w,
                                            child: Wrap(
                                              children: [
                                                Text(
                                                  data[index].description,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.fade,
                                                  style: GoogleFonts.gabriela(
                                                      color: Colors.white70,
                                                      fontSize: 18.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
    );
  }

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: const EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
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
// if (snapshot.hasError) print('error');
// var data = snapshot.data;
// return snapshot.hasData
// ? Text(
// data,
// style: const TextStyle(color: Colors.white),
// )
// : const Center(
// child: Text(
// 'No contacts that include this keyword',
// style: TextStyle(color: Colors.white),
// ),
// );
