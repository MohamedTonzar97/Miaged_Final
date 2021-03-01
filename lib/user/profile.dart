
import '../Profile/locator.dart';
import '../models/user.dart';
import '../Profile/userController.dart';

import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  static String id = 'ProfileScreen';
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
 User _currentUser = locator.get<UserController>().currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      "Hi ${_currentUser?.adress ?? 'nice to see you here.'}"),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(hintText: "Username"),
                    ),
                    SizedBox(height: 20.0),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Manage Password",
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          TextFormField(
                            decoration: InputDecoration(hintText: "Password"),
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(hintText: "New Password"),
                          ),
                          TextFormField(
                            decoration:
                            InputDecoration(hintText: "Repeat Password"),
                          )
                        ],
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        // TODO: Save somehow
                        Navigator.pop(context);
                      },
                      child: Text("Save Profile"),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}