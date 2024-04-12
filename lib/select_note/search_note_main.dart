import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../update_note/update_note.dart';

class SearchNoteMain extends StatefulWidget {
  const SearchNoteMain({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<SearchNoteMain> createState() => _SearchNoteMainState();
}

class _SearchNoteMainState extends State<SearchNoteMain> {
  late String title = widget.title;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height60 = size.height * 0.6; // main

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "제목을 입력해주세요",
                hintText: '제목 입력',
              ),
              onChanged: (text) {
                setState(() {
                  title = text;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: double.infinity,
              height: height60,
              child: FutureBuilder(
                future: fetch(),
                builder: (context, snap) {
                  // CircularProgressIndicator: 데이터가 들어오지 않으면 원이 빙글빙글 돌면서 값이 들어오기를 기다린다.
                  if (!snap.hasData) return const Center(child: Text("검색 결과가 없습니다."));
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
            ),
          ),
        ],
      ),
    );
  }

  Future fetch() async {
    var res = await http.get(Uri.parse("http://localhost:4000/getLikeNote/$title"));
    return json.decode(res.body);
  }
}
