import 'package:flutter/material.dart';

import 'form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;

  void _submitAuthForm(
    String username,
    String password,
    BuildContext ctx,
    bool isLogin,
  ) {
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      _submitAuthForm,
      _isLoading,
    );
  }
}
