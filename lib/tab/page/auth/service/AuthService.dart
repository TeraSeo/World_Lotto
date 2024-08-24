import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottery_kr/service/helper_function.dart';
import 'package:lottery_kr/tab/page/auth/service/UserService.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  AuthService._privateConstructor();

  static final AuthService _instance = AuthService._privateConstructor();

  static AuthService get instance => _instance;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  UserService userService = UserService.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      return await firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
      GoogleSignIn googleSignIn = GoogleSignIn();
      googleSignIn.signOut();
      return null;
    }
  }

  Future<UserCredential?> signInWithApple() async {
    try {

      String clientID = 'lotto.world.com';
      String redirectURL = 
      'https://dawn-cloudy-hubcap.glitch.me/callbacks/sign_in_with_apple';

      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: Platform.isIOS ? nonce : null,
        webAuthenticationOptions: Platform.isIOS
            ? null
            : WebAuthenticationOptions(
                clientId: clientID,
                redirectUri: Uri.parse(redirectURL),
              ),
      );

      final AuthCredential appleAuthCredential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: Platform.isIOS ? rawNonce : null,
        accessToken: Platform.isIOS ? null : appleCredential.authorizationCode,
      );

      return await firebaseAuth.signInWithCredential(appleAuthCredential);
    } catch (e) {
      return null;
    }
  }

  Future registerUserWithEmailandPassword(String name, String email, String password) async {

    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password
      )).user!;

      UserService databaseService = UserService.instance;

      if (user != null) {
        await databaseService.savingeUserData(name, email, user.uid);
        return true;
      }
      return false;

    } on FirebaseAuthException catch(e) {
      return e.message; 
    }

  }

  Future<bool> loginWithUserNameandPassword(String email, String password) async {
    HelperFunctions helperFunctions = HelperFunctions();
    try {
      User? user = (await firebaseAuth.signInWithEmailAndPassword (
        email: email, password: password
      )).user;

      if (user != null) {
        helperFunctions.saveUserLoggedInStatus(true);
        helperFunctions.saveUserUIdSF(user.uid);
        helperFunctions.saveVerifiedSF(true);
        return true;
      }

      return false;

    } catch(e) {
      return false; 
    }

  }

  String generateNonce([int length = 32]) {
    final charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
