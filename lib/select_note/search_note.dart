import 'package:flutter/material.dart';
import 'package:note/select_note/search_note_main.dart';

import '../design.dart';

class SearchNotePage extends StatefulWidget {
  const SearchNotePage({
    super.key,
    required BuildContext context,
  });

  @override
  State<SearchNotePage> createState() => _SearchNotePageState();
}

class _SearchNotePageState extends State<SearchNotePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width90 = size.width * 0.9;
    final height100 = size.height * 1.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          '노트 검색하기',
          style: BASIC_FONT,
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
          
            children: [
              SizedBox(
                width: width90,
                height: height100,
                child: const SearchNoteMain(title: ''),
              )
            ],
          ),
        ),
      ),
    );
  }
}
