import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:questable_quiz_flutter/firebase_ref/references.dart';
import 'package:questable_quiz_flutter/screens/home/home_screen.dart';
import 'package:questable_quiz_flutter/screens/login/login_screen.dart';
import 'package:questable_quiz_flutter/widgets/dialogs/dialog_widget.dart';

class AuthController extends GetxController {
  var AppLogger = Logger();

  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 1));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          accessToken: _authAccount.accessToken,
          idToken: _authAccount.idToken,
        );

        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch (err) {
      AppLogger.e(err);
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {
    userRef.doc(account.email).set({
      'email': account.email,
      'name': account.displayName,
      'profilePic': account.photoUrl,
    });
  }

  Future<void> signOut() async {
    AppLogger.d('signOut');
    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch (err) {
      AppLogger.e(err);
    }
  }

  void navigateToIntroduction() {
    Get.offAllNamed('/introduction');
  }

  void navigateToHomePage() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlertDialogue() {
    Get.dialog(
      Dialogs.questionStartDailogue(onTap: () {
        Get.back();
        NavigatetoLoginPage();
      }),
      barrierDismissible: false,
    );
  }

  void NavigatetoLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
