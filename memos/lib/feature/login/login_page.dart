import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, GoogleAuthProvider, UserCredential;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn;

/// Login screen.
class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

/// State for [LoginPage].
class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  final _loginForm = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loggingIn = false;
  String _errorMessage;
  bool _useEmailSignIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 560,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 100,
                horizontal: 48,
              ),
              child: Form(
                key: _loginForm,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 32),
                    const Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 32),
                    if (_useEmailSignIn) ..._buildEmailSignInFields(),
                    if (!_useEmailSignIn) ..._buildGoogleSignInFields(),
                    if (_errorMessage != null) _buildLoginMessage(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  List<Widget> _buildGoogleSignInFields() => [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
          ),
          onPressed: _signInWithGoogle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40 / 1.618),
                child: const Text('Continue with Google'),
              ),
            ],
          ),
        ),
        TextButton(
          child: Text('Sign in with email'),
          onPressed: () => setState(() {
            _useEmailSignIn = true;
          }),
        ),
        if (_loggingIn)
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(top: 12),
            child: const CircularProgressIndicator(),
          ),
      ];

  List<Widget> _buildEmailSignInFields() => [
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            hintText: 'Email',
          ),
          validator: (value) =>
              value.isEmpty ? 'Please input your email' : null,
        ),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
          validator: (value) =>
              value.isEmpty ? 'Please input your password' : null,
          obscureText: true,
        ),
        const SizedBox(height: 16),
        _buildEmailSignInButton(),
        if (_loggingIn) const LinearProgressIndicator(),
        TextButton(
          child: Text('Use Google Sign In'),
          onPressed: () => setState(() {
            _useEmailSignIn = false;
          }),
        ),
      ];

  Widget _buildEmailSignInButton() => ElevatedButton(
        onPressed: _signInWithEmail,
        child: Container(
          height: 40,
          alignment: Alignment.center,
          child: const Text('Sign in / Sign up'),
        ),
      );

  Widget _buildLoginMessage() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 18),
        child: Text(
          _errorMessage,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        ),
      );

  void _signInWithGoogle() async {
    _setLoggingIn();
    String errMsg;

    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final userCredential = await _auth.signInWithCredential(credential);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user.uid)
          .set(
        {
          'email': userCredential.user.email,
          'name': userCredential.user.displayName,
          'memos': FieldValue.arrayUnion([]),
        },
      );
    } catch (e, s) {
      debugPrint('google signIn failed: $e. $s');
      errMsg = 'Login failed, please try again later.';
    } finally {
      _setLoggingIn(false, errMsg);
    }
  }

  void _signInWithEmail() async {
    if (_loginForm.currentState?.validate() != true) return;

    FocusScope.of(context).unfocus();
    String errMsg;
    try {
      _setLoggingIn();
      final result =
          await _doEmailSignIn(_emailController.text, _passwordController.text);
      debugPrint('Login result: $result');
    } on PlatformException catch (e) {
      errMsg = e.message;
    } catch (e, s) {
      debugPrint('login failed: $e. $s');
      errMsg = 'Login failed, please try again later.';
    } finally {
      _setLoggingIn(false, errMsg);
    }
  }

  Future<UserCredential> _doEmailSignIn(String email, String password,
          {bool signUp = false}) =>
      (signUp
              ? _auth.createUserWithEmailAndPassword(
                  email: email, password: password)
              : _auth.signInWithEmailAndPassword(
                  email: email, password: password))
          .catchError((e) {
        if (e is PlatformException && e.code == 'ERROR_USER_NOT_FOUND') {
          return _doEmailSignIn(email, password, signUp: true);
        } else {
          throw e;
        }
      });

  void _setLoggingIn([bool loggingIn = true, String errMsg]) {
    if (mounted) {
      setState(() {
        _loggingIn = loggingIn;
        _errorMessage = errMsg;
      });
    }
  }
}
