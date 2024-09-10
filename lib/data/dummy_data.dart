import 'package:flutter/material.dart';

import '../../data/models/user.dart';

const List<Map<String, String>> dummyDiary = [
  {'image': 'assets/dummy1.png', 'title': 'Contents 1'},
  {'image': 'assets/dummy2.png', 'title': 'Contents 2'},
  {'image': 'assets/dummy3.png', 'title': 'Contents 3'},
  {'image': 'assets/dummy4.png', 'title': 'Contents 4'},
  {'image': 'assets/dummy5.png', 'title': 'Contents 5'},
];

const List<Map<String, dynamic>> dummyTags = [
  {'tag': '동화', 'color': Color(0xFFA8E6CF)}, // 파스텔 그린
  {'tag': '모험', 'color': Color(0xFFD1C4E9)}, // 파스텔 퍼플
  {'tag': '우정', 'color': Color(0xFFFFCCBC)}, // 파스텔 오렌지
  {'tag': '가족', 'color': Color(0xFFFFF9C4)}, // 파스텔 옐로우
  {'tag': '학습', 'color': Color(0xFFB3E5FC)}, // 파스텔 블루
  {'tag': '상상력', 'color': Color(0xFFFFABAB)}, // 파스텔 핑크
  {'tag': '자연', 'color': Color(0xFFFFF176)}, // 파스텔 레몬
  {'tag': '역사', 'color': Color(0xFFC5E1A5)}, // 파스텔 라이트 그린
  {'tag': '과학', 'color': Color(0xFFCFD8DC)}, // 파스텔 그레이
  {'tag': '꿈', 'color': Color(0xFFF8BBD0)}, // 파스텔 로즈
  {'tag': '예술', 'color': Color(0xFFAED581)}, // 파스텔 라이트 그린
];

List<User> dummyUsers = [
  User(
    id: '1',
    imageUrl: 'assets/dummy1.png',
    name: 'Alice Johnson',
    region: 'New York, USA',
  ),
];
