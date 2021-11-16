import 'package:flutter/material.dart';

import 'auth_text_form.dart';

class AuthContent extends StatelessWidget {
  final bool enable;
  final ValueChanged<String>? onUserNameChanged;
  final ValueChanged<String>? onPasswordChanged;
  final VoidCallback? onSubmit;

  const AuthContent({
    Key? key,
    this.enable = true,
    this.onPasswordChanged,
    this.onUserNameChanged,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AuthTextForm(
          title: 'User Name',
          hints: 'Please input User Name',
          enable: enable,
          onChanged: onUserNameChanged,
        ),
        const SizedBox(height: 20),
        AuthTextForm(
          title: 'Password',
          hints: 'Please input password',
          enable: enable,
          onChanged: onPasswordChanged,
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 15),
          ),
          onPressed: onSubmit,
        ),
      ],
    );
  }
}
