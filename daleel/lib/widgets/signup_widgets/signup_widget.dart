import 'package:flutter/material.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget( TextEditingController? this.email, this.username, this.password, {Key? key }) : super(key: key);
  final TextEditingController? email, username, password;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text(
              'email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
          controller: email,
        ),
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