import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, GoogleAuthProvider;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn;
import 'package:memos/core/presentation/m_google_button.dart';
import 'package:memos/feature/memos/presentation/memos_page.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const Icon(
                    Icons.login,
                    size: 81,
                  ),
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
                  if (!_useEmailSignIn)
                    MGoogleButton(
                      'Continue with Google',
                      onTap: _signInWithGoogle,
                    ),
                  if (_errorMessage != null) _buildLoginMessage(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildEmailSignInFields() {
    return [
      TextFormField(
        controller: _emailController,
        decoration: const InputDecoration(
          hintText: 'Email',
        ),
        validator: (value) => value.isEmpty ? 'Please input your email' : null,
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
      if (_loggingIn) const LinearProgressIndicator(),
      TextButton(
        child: Text('Use Google Sign In'),
        onPressed: () => setState(() {
          _useEmailSignIn = false;
        }),
      )
    ];
  }

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
          .update(
        {
          'email': userCredential.user.email,
          'name': userCredential.user.displayName,
          'memos': FieldValue.arrayUnion([]),
        },
      );

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MemosPage(),
        ),
      );
    } catch (e, s) {
      debugPrint('google signIn failed: $e. $s');
      errMsg = 'Login failed, please try again later.';
    } finally {
      _setLoggingIn(false, errMsg);
    }
  }

  void _setLoggingIn([bool loggingIn = true, String errMsg]) {
    if (mounted) {
      setState(() {
        _loggingIn = loggingIn;
        _errorMessage = errMsg;
      });
    }
  }
}
