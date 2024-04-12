import 'package:flutter/material.dart';
import 'package:note/design.dart';
import 'package:note/home.dart';
import 'package:note/note/note.dart';
import 'package:note/select_note/search_note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "note",
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => MyPage(context: context),
        '/write_note': (BuildContext context) => NotePage(context: context),
        '/search_note': (BuildContext context) => SearchNotePage(context: context),
      },
    );
  }
}

class MyPage extends StatelessWidget {
  const MyPage({
    super.key,
    required BuildContext context,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height100 = size.height * 1.0; // header

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
        foregroundColor: Colors.red,
        // AppBar속 요소들의 색상
        elevation: 0,
        title: const Text(
          '오늘의 노트',
          style: BASIC_FONT,
        ),
        centerTitle: true,
        // 텍스트 중앙 정렬

        leading: IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.note_add_sharp),
            onPressed: () {
              Navigator.pushNamed(context, '/write_note');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.pushNamed(context, '/search_note');
            },
          ),
        ],
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
                width: double.infinity,
                height: height100,
                child: const HomePage(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
