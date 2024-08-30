import 'package:flutter/material.dart';

import 'user.dart';

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
    imageUrl: 'assets/dummy1.png',
    name: 'Alice Johnson',
    region: 'New York, USA',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy2.png',
    name: 'Bob Smith',
    region: 'Los Angeles, USA',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy3.png',
    name: 'Clara Kim',
    region: 'Seoul, South Korea',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy4.png',
    name: 'David Lee',
    region: 'Toronto, Canada',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Eva Brown',
    region: 'London, UK',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'John Doe',
    region: 'New York, USA',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Jane Smith',
    region: 'Paris, France',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Mike Johnson',
    region: 'Berlin, Germany',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Sophia Lee',
    region: 'Seoul, South Korea',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Eva Brown',
    region: 'London, UK',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Liam Wilson',
    region: 'Sydney, Australia',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Olivia Taylor',
    region: 'Toronto, Canada',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Noah Williams',
    region: 'Tokyo, Japan',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Emma Davis',
    region: 'Rome, Italy',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Lucas Martinez',
    region: 'Madrid, Spain',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Mia Garcia',
    region: 'Mexico City, Mexico',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Ethan Miller',
    region: 'Moscow, Russia',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Ava Moore',
    region: 'Beijing, China',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'James Anderson',
    region: 'Los Angeles, USA',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Isabella Thompson',
    region: 'Dubai, UAE',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'William Martinez',
    region: 'Santiago, Chile',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Sophia Harris',
    region: 'Bangkok, Thailand',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Mason Clark',
    region: 'Buenos Aires, Argentina',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Charlotte Lewis',
    region: 'Cape Town, South Africa',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Michael Robinson',
    region: 'Jakarta, Indonesia',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Amelia Walker',
    region: 'Istanbul, Turkey',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Benjamin Hall',
    region: 'Lagos, Nigeria',
    isFollowed: false,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Ella Young',
    region: 'Mumbai, India',
    isFollowed: true,
  ),
  User(
    imageUrl: 'assets/dummy5.png',
    name: 'Henry King',
    region: 'Cairo, Egypt',
    isFollowed: false,
  ),
];
