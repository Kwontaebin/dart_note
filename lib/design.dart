// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';

const BASIC_FONT = TextStyle(
  decoration: TextDecoration.none,
  fontSize: 25,
  fontWeight: FontWeight.bold,
  height: 10 / 10,
  color: Colors.white,
);

const NOTE_FONT = TextStyle(
  decoration: TextDecoration.none,
  fontSize: 18,
  fontWeight: FontWeight.w500,
  height: 10 / 10,
  color: Colors.black,
);

const DELETE_FONT = TextStyle(
  decoration: TextDecoration.none,
  fontSize: 18,
  fontWeight: FontWeight.w500,
  height: 10 / 10,
  color: Colors.white,
);

// ElevatedButton에 style을 주고 싶을떄는 ElevatedButton.styleFrom를 사용한다.
final deleteButton = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 241, 8, 8),
);

final updateButton = ElevatedButton.styleFrom(
  backgroundColor: const Color.fromARGB(255, 8, 241, 20),
);