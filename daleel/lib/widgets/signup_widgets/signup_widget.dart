import 'package:flutter/material.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget( TextEditingController? this.email, this.username, this.password, {Key? key }) : super(key: key);
  final TextEditingController? email, username, password;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Text(
              'البريد الالكتروني',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
          controller: email,
        ),
        Text(
              'اسم المستخدم',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            TextFormField(
          controller: username,
        ),
        Text(
          'كلمة المرور',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        TextFormField(
          controller: password,
        )
      ],
    );
        
  }
}