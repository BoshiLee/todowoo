import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todowoo/cubits/register/register_cubit.dart';
import 'package:todowoo/screens/register_screen.dart';

extension BSNavigator on Navigator {
  static Future<T?> navigateToNextPage<T extends Object?>(
    BuildContext context,
    Widget page,
    String pageId, {
    bool fullscreenDialog = false,
  }) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(
        builder: (context) => page,
        settings: RouteSettings(name: pageId),
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }

  static void popToRoot(BuildContext context) {
    Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
  }

  static void popToPrevious(BuildContext context, String pageId) {
    Navigator.popUntil(context, ModalRoute.withName(pageId));
  }
}

extension BSRouteManager on Navigator {
  static Future<T?> navigateToRegisterScreen<T extends Object?>(
    BuildContext context, {
    required ValueChanged<String> onRegistered,
  }) =>
      BSNavigator.navigateToNextPage(
        context,
        BlocProvider(
          create: (context) => RegisterCubit(),
          child: RegisterScreen(
            onRegistered: onRegistered,
          ),
        ),
        RegisterScreen.id,
      );
}
