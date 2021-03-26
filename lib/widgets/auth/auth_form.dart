import 'dart:io';

import 'package:chat/widgets/auth/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username, File image,
      bool isLogin, BuildContext ctx) submitFn;
  final bool _isLoading;

  AuthForm(this.submitFn, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _email = "";
  String _password = "";
  String _username = "";
  File _userImagePicked;

  void _submit() {
    final isValid = _formKey.currentState.validate();
    // to close keyboard
    FocusScope.of(context).unfocus();
    if (!_isLogin && _userImagePicked == null) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Please pick an Image"),
        backgroundColor: Theme.of(context).accentColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
          _email.trim(), _password.trim(), _username.trim(), _userImagePicked, _isLogin, context);
    }
  }

  void _pickedImage(File selectedImage) {
    _userImagePicked = selectedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isLogin) UserImagePicker(_pickedImage),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  key: ValueKey('email'),
                  validator: (val) {
                    if (val.isEmpty || !val.contains("@"))
                      return "Please enter a valid Email Address";
                    return null;
                  },
                  onSaved: (val) => _email = val,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: ("Email Address")),
                ),
                if (!_isLogin)
                  TextFormField(
                    autocorrect: true,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.words,
                    key: ValueKey('username'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 4)
                        return "Please enter at least 4 characters";
                      return null;
                    },
                    onSaved: (val) => _username = val,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(labelText: ("Username")),
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val) {
                    if (val.isEmpty || val.length < 7)
                      return "Password must be at least 7 characters";
                    return null;
                  },
                  onSaved: (val) => _password = val,
                  decoration: InputDecoration(labelText: ("Password")),
                  obscureText: true,
                ),
                SizedBox(height: 12),
                if (widget._isLoading) CircularProgressIndicator(),
                if (!widget._isLoading)
                  RaisedButton(
                    onPressed: _submit,
                    child: Text(
                      _isLogin ? "Login" : "Sign Up",
                    ),
                  ),
                if (!widget._isLoading)
                  FlatButton(
                      onPressed: () => setState(() => _isLogin = !_isLogin),
                      textColor: Theme.of(context).primaryColor,
                      child: Text(_isLogin
                          ? "Create new account"
                          : "i already have account"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
