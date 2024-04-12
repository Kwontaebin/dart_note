import 'package:flutter/material.dart';
import 'package:note/design.dart';
import 'note_main.dart';

class NotePage extends StatelessWidget {
  const NotePage({
    super.key,
    required BuildContext context,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width90 = size.width * 0.9;
    final height100 = size.height * 1.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        title: const Text(
          '노트 작성하기',
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
                child: const NoteMain(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
