import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_plus/models/user_model.dart';
import 'package:notes_plus/services/auth_services.dart';

class UserRepository {
  final AuthServices _authServices = AuthServices();

  Future<UserModel?> getCurrentUser() async {
    User? user = await _authServices.getCurrentUser();
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      displayName: user.displayName ?? "-",
      email: user.email ?? "-",
      photoUrl: user.photoURL ?? "",
    );
  }

  Future<UserModel?> signInWithGoogle() async {
    User? user = await _authServices.signInWithGoogle();
    if (user == null) {
      return null;
    }
    return UserModel(
      uid: user.uid,
      displayName: user.displayName ?? "-",
      email: user.email ?? "-",
      photoUrl: user.photoURL ?? "",
    );
  }

  Future<bool> signOut() async {
    return await _authServices.signOut();
  }
}
