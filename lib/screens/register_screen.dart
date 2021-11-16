import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowoo/cubits/register/register_cubit.dart';
import 'package:todowoo/screens/widgets/auth/auth_cotent.dart';

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
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            onRegistered(state.jwt);
            Navigator.pop(context);
          }
          if (state is RegisterErrorOccurred) {
            BotToast.showSimpleNotification(title: state.errorMessage);
          }
        },
        child: BlocBuilder<RegisterCubit, RegisterState>(
          builder: (context, state) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AuthContent(
                enable: state is! RegisterLoading,
                onUserNameChanged: (userName) =>
                    context.read<RegisterCubit>().model.username = userName,
                onPasswordChanged: (password) =>
                    context.read<RegisterCubit>().model.password = password,
                onSubmit: context.read<RegisterCubit>().register,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
