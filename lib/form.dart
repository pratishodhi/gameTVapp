import 'package:flutter/material.dart';
import 'package:gametv/maintestpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;

  final void Function(
    String password,
    String username,
    BuildContext ctx,
    bool isLogin,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    checkIfAlreadyLogin();
  }

  final _formKey = GlobalKey<FormState>();
  var _userName = '';
  var _userPassword = '';
  bool isLogin = false;

  void _trySubmit() {
    bool success = false;
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      widget.submitFn(
        _userName.trim(),
        _userPassword.trim(),
        context,
        isLogin,
      );
    }

    if (_userPassword == 'password123' && _userName == '9876543210' ||
        _userName == '9898989898') {
      success = true;
      print(_userName);
      print(_userPassword);
      print(success);
      logindata.setBool('login', false);
      logindata.setString('username', _userName);
    }

    if (success) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MaintestPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  key: ValueKey('username'),
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.length < 4 ||
                        value.length > 11) {
                      return 'Username should be 3 - 11 characters long';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userName = value!;
                  },
                  decoration: InputDecoration(
                      hintText: 'Username',
                      hintStyle:
                          TextStyle(color: Colors.yellow, fontSize: 15))),
              TextFormField(
                style: TextStyle(color: Colors.white),
                key: ValueKey('password'),
                validator: (value) {
                  if (value!.isEmpty || value.length < 6) {
                    return 'Password must be atleast 6 characters long';
                  }
                  if (value != 'password123') {
                    return 'Incorrect Password bro';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userPassword = value!;
                },
                decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Colors.yellow, fontSize: 15)),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                onPressed: _trySubmit,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void checkIfAlreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login')) ?? true;
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MaintestPage()));
    }
  }
}
