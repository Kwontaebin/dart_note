// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../design.dart';

class UpdateNoteMain extends StatefulWidget {
  const UpdateNoteMain({
    super.key,
    required this.id,
    required this.title,
    required this.text,
  });

  final String id;
  final String title;
  final String text;

  @override
  State<UpdateNoteMain> createState() => _UpdateNoteMainState();
}

class _UpdateNoteMainState extends State<UpdateNoteMain> {
  late String id = widget.id;
  late String title = widget.title;
  late String text = widget.text;

  Future fetch() async {
    var res = await http.get(Uri.parse("http://localhost:4000/getNote/$id"));
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height60 = size.height * 0.6; // main

    return SizedBox(
      child: FutureBuilder(
        future: fetch(),
        builder: (context, snap) {
          if (!snap.hasData) return const CircularProgressIndicator();

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                child: (Padding(
                  padding: const EdgeInsets.only(top: 20),
                  // 기존이 있던 무언가의 값을 수정하고 싶다면 TextFormField를 사용한다
                  // TextFormField와 TextField의 속성의 차이점은 없는것 같다.
                  // 자세한 TextFormField 참고!
                  // https://grow-grow.tistory.com/31
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    initialValue: snap.data[0]["title"].toString(),
                    onChanged: (text) {
                      setState(() {
                        title = snap.data[0]["title"].toString();
                        title = text;
                      });
                    },
                  ),
                )),
              ),
              SizedBox(
                width: double.infinity,
                height: height60,
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      initialValue: snap.data[0]["text"].toString(),
                      maxLines: null,
                      onChanged: (value) {
                        setState(() {
                          text = snap.data[0]["title"].toString();
                          text = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                      style: deleteButton,
                      // ! Statefulwidget을 하지 않으면 setState를 사용하지 못한다.
                      // onPressed 누르면 데이터 전달하기
                      onPressed: () {
                        setState(() {
                          deleteData();
                        });
                      },
                      child: const Text(
                        "삭제하기",
                        style: DELETE_FONT,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: updateButton,
                    // ! Statefulwidget을 하지 않으면 setState를 사용하지 못한다.
                    // onPressed 누르면 데이터 전달하기
                    onPressed: () {
                      setState(() {
                        if (title == "") title = snap.data[0]["title"].toString();
                        if (text == "") text = snap.data[0]["text"].toString();

                        updateData();
                      });
                    },
                    child: const Text(
                      "수정하기",
                      style: NOTE_FONT,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> updateData() async {
    var url = Uri.parse("http://localhost:4000/updateNote");
    var data = {"id": id, "title": title, "text": text};

    var response = await http.put(
      url,
      body: json.encode(data),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) print('UPDATE 성공: ${response.body}');Navigator.pop(context);
    if (response.statusCode != 200) print('UPDATE 실패: ${response.statusCode}');
  }

  Future<void> deleteData() async {
    var url = Uri.parse("http://localhost:4000/deleteNote/$id");

    var response = await http.delete(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) print('DELETE 성공: ${response.body}');Navigator.pop(context);
    if (response.statusCode != 200) print('DELETE 실패: ${response.statusCode}');
  }
}