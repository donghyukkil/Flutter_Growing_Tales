import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/services/firestore_service.dart';
import '../data/services/auth_service.dart';
import '../data/repositories/diary_repository.dart';
import '../data/repositories/user_repository.dart';
import '../ui/view_models/users_view_model.dart';
import '../ui/view_models/diary_view_model.dart';

List<SingleChildWidget> appProviders = [
  Provider<FirestoreService>(create: (_) => FirestoreService()),
  Provider<AuthService>(create: (_) => AuthService()),
  ProxyProvider<FirestoreService, DiaryRepository>(
      update: (_, firestoreService, __) => DiaryRepository(firestoreService)),
  ProxyProvider2<AuthService, FirestoreService, UserRepository>(
    update: (_, authService, firestoreService, __) => UserRepository(
        authService: authService, firestoreService: firestoreService),
  ),
  ChangeNotifierProvider<UsersViewModel>(
    create: (context) => UsersViewModel(
      userRepository: context.read<UserRepository>(),
    ),
  ),
  ChangeNotifierProvider<DiaryViewModel>(
    create: (context) => DiaryViewModel(
      diaryRepository: context.read<DiaryRepository>(),
    ),
  )
];
