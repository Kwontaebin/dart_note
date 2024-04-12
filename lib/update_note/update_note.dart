import 'package:flutter/material.dart';
import 'package:note/update_note/update_note_main.dart';
import '../design.dart';

class UpdateNotePage extends StatefulWidget {
  const UpdateNotePage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  late String id = widget.id;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width90 = size.width * 0.9;
    final height100 = size.height * 1.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          '노트 수정하기',
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
                child: UpdateNoteMain(id: id, title: '', text: ''),
              )
            ],
          ),
        ),
      ),
    );
  }
}