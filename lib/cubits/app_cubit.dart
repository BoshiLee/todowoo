import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todowoo/repository/user_repository.dart';
import 'package:todowoo/utils/shared_preferences_util.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final UserRepository userRepository = UserRepository.shared;
  AppCubit() : super(AppInitial()) {
    startApp();
  }

  Future startApp() async {
    emit(AppUninitialized());
    await _initializeAppSetting();
    renewJWT();
  }

  Future _initializeAppSetting() async {
    await SharedPreferencesUtils.getInstance();
    await Future.delayed(const Duration(seconds: 2));
  }

  unAuthenticate() {
    userRepository.unAuthenticate();
    renewJWT();
  }

  renewJWT() {
    if (userRepository.hasJWT) {
      emit(AppAuthenticated());
    } else {
      emit(AppUnauthenticated());
    }
  }
}
