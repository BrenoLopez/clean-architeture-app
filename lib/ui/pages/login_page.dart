import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: <Widget>[
        Container(
          child: Image(
            image: const AssetImage('./lib/ui/assets/logo.png'),
          ),
        ),
        Text('Login'.toUpperCase()),
      ],
    ));
  }
}
