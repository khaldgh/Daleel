import 'package:flutter/material.dart';

class SigninWidget extends StatelessWidget {
  const SigninWidget(
      TextEditingController? this.username, this.password, {Key? key})
      : super(key: key);
  final TextEditingController? username, password;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Username',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: username,
        ),
        Text(
          'Password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: password,
        )
      ],
    );
  }
}
