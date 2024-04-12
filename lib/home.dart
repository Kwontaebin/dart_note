import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'update_note/update_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future fetch() async {
    var res = await http.get(Uri.parse("http://localhost:4000/getAllNoteList"));
    return json.decode(res.body);
  }

  // 내가 작성한 노목록을 보여준다.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FutureBuilder는 비동기 함수에서 리턴하는 Future<변수> 받아 먼저 Build하고 비동기 함수 계산이 완료되면 실제 리턴 값을 보여준다.
      // 주로 JSON 파일과 같이 데이터 통신에 주로 쓰인다.
      body: FutureBuilder(
        future: fetch(), // 비동기 함수(JSON 수신 등)
        builder: (context, snap) {
          // CircularProgressIndicator: 데이터가 들어오지 않으면 원이 빙글빙글 돌면서 값이 들어오기를 기다린다.
          if (!snap.hasData) return const CircularProgressIndicator();
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (context, int index) => ListTile(
              leading: Text(snap.data[index]['id'].toString()),
              title: Text(snap.data[index]['title'].toString()),
              subtitle: Text(snap.data[index]['text'].toString()),
              trailing: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right),
                onPressed: () {
                  print(snap.data[index]["id"].toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateNotePage(id: snap.data[index]["id"].toString()),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
