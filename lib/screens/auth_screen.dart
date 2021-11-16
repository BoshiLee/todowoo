import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowoo/cubits/app_cubit.dart';
import 'package:todowoo/cubits/auth/auth_cubit.dart';
import 'package:todowoo/screens/widgets/auth/auth_cotent.dart';
import 'package:todowoo/utils/bs_navigator.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AuthScreen'),
        actions: [
          TextButton(
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            onPressed: () => BSRouteManager.navigateToRegisterScreen(
              context,
              onRegistered: context.read<AuthCubit>().writeToken,
            ),
          ),
        ],
      ),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.read<AppCubit>().emit(AppAuthenticated());
          }
          if (state is AuthErrorOccurred) {
            BotToast.showSimpleNotification(title: state.errorMessage);
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: AuthContent(
                  enable: state is! AuthLoading,
                  onUserNameChanged: (email) =>
                      context.read<AuthCubit>().model.username = email,
                  onPasswordChanged: (password) =>
                      context.read<AuthCubit>().model.password = password,
                  onSubmit: context.read<AuthCubit>().login,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
