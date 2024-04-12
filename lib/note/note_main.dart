// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:note/design.dart';

class NoteMain extends StatefulWidget {
  const NoteMain({
    super.key,
    this.title = "",
    this.content = "",
  });

  final String title;
  final String content;

  @override
  State<NoteMain> createState() => _NoteMainState();
}

class _NoteMainState extends State<NoteMain> {
  late String title = widget.title;
  late String content = widget.content;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height60 = size.height * 0.6; // main

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                // labelText는 focus가 되어있지 않은 상태일 때 text placeholder역할을 합니다
                // 그리고 TextField가 focus가 되었을떄는 글자가 위로 이동한다.
                // hintText는 focus가 되었는데 text가 비어있을 때 placeholder역할을 합니다
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
          SizedBox(
            width: double.infinity,
            height: height60,
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "내용 입력",
                ),

                onChanged: (text) {
                  setState(() {
                    content = text;
                  });
                },
                // TextField를 중바꿈이 가능하게 하려면 maxLines: null을 넣어준다.
                maxLines: null,
                // keyboardType: TextInputType.multiline,
              ),
            ),
          ),
          ElevatedButton(
            // ! Statefulwidget을 하지 않으면 setState를 사용하지 못한다.
            // onPressed 누르면 데이터 전달하기
            onPressed: () {
              setState(() {
                if (title == "" || content == "") {
                  return snapBar();
                } else {
                  postData();
                }
              });
            },
            child: const Text(
              "작성하기",
              style: NOTE_FONT,
            ),
          ),
        ],
      ),
    );
  }

  void snapBar() {
    final snackBar = SnackBar(
      content: const Text('전부다 작성해주세요'),
      action: SnackBarAction(
        label: '확인',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );

    // ScaffoldMessenger.of(context). = final size = MediaQuery.of(context).size 와 코드가 약간 비슷하다.
    // ScaffoldMessenger.of(context). 현재 컨텍스트(context)에 대한 ScaffoldMessenger를 가져옵니다.
    // 이것은 일반적으로 Scaffold 위젯 내에서 사용됩니다.
    // showSnackBar(snackBar) 메서드는 스낵바를 보여줍니다.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> postData() async {
    var url = Uri.parse("http://localhost:4000/addNote");
    var data = {"title": title, "text": content}; // 이 데이터를 원하는 형식으로 구성하세요.

    var response = await http.post(
      // post하는 url주소
      url,

      // req.body 에 json 형태로 담기위해 사용하는 코드
      // 전달받은 값을 JSON 형식의 문자열로 변환하여 반환
      body: json.encode(data),

      // post를 하는데 가장 중요하다!
      // 요즈음의 대부분의 request에 대한 Content-Type은 application/json 타입인 것이 많습니다.
      // application/json은 RestFul API를 사용하게 되며 request를 날릴 때 대부분 json을 많이 사용하게 됨에 따라 자연스럽게 사용이 많이 늘게 되었습니다.
      // https://jw910911.tistory.com/117
      headers: {"Content-Type": "application/json"},
    );

    if(response.statusCode == 200) print('POST 성공: ${response.body}'); Navigator.pop(context);
    if(response.statusCode != 200) print('POST 실패: ${response.statusCode}');
  }
}
