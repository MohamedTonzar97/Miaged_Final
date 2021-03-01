import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * .3,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/icons/icon.png'),
            ),
            Positioned(
              bottom:-10,
              child: Text(
                'MIAGED',
                style: TextStyle(fontFamily: 'Pacifico', fontSize: 25),
              ),
            )
          ],
        ),
      ),
    );
  }
}