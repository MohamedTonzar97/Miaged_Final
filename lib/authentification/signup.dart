import 'file:///C:/Users/new/Desktop/miaged/lib/authentification/LoginU.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/custom_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/modelHud.dart';
import '../services/auth.dart';

class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  static String id = 'SignupScreen';
  String _email, _password;
  final _auth = Auth();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(

      backgroundColor: Color(0xFFFFC12F),
      body: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              CustomLogo(),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                onClick: (value) {},
                icon: Icons.perm_identity,
                hint: 'Enter your name',
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _email = value;
                },
                hint: 'Enter your email',
                icon: Icons.email,
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _password = value;
                },
                hint: 'Enter your password',
                icon: Icons.lock,
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () async {
                      final modelhud =Provider.of<ModelHud>(context, listen: false);
                      modelhud.changeisLoading(true);
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          final authResult = await _auth.signUp(
                              _email.trim(), _password.trim());
                          modelhud.changeisLoading(false);
                          Navigator.pushNamed(context, LoginScreen.id);
                        } on PlatformException catch (e) {
                          modelhud.changeisLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(e.message),
                          ));
                        }
                      }
                    },
                    color: Colors.black,
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Do have an account ? ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
      ),
    );
  }
}