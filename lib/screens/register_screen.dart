import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowoo/cubits/register/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  static String id = 'RegisterScreen';
  final ValueChanged<String> onRegistered;

  const RegisterScreen({
    Key? key,
    required this.onRegistered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterScreen'),
      ),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) => Container(),
      ),
    );
  }
}
