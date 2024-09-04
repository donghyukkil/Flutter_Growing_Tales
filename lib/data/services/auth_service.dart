import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      // Google Sign-In 요청하기
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      //todo 클라이언트에 Null 표현하기 -> dialog or snackbar 사용해서.
      if (googleUser == null) {
        return null;
      }

      // 인증 토큰 요청
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);

      return userCredential.user;
    } catch (e) {
      //todo 플러터에서 에러처리 어떻게 하는지 조사하기.
      print('Google Sign-in Error: $e');

      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
