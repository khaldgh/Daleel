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
