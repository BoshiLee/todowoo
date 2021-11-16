import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todowoo/model/register_model.dart';
import 'package:todowoo/networking/app_exception.dart';
import 'package:todowoo/repository/user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository _repository = UserRepository.shared;
  RegisterModel model = RegisterModel();

  AuthCubit() : super(AuthInitial());

  Future login() async {
    try {
      emit(AuthLoading());
      final String? jwt = await _repository.authenticate(model: model);
      if (jwt != null) {
        writeToken(jwt);
        emit(AuthSuccess());
      }
    } on AppException catch (exception) {
      _handleGenericError(exception);
    } catch (e) {
      emit(AuthErrorOccurred(errorMessage: e.toString()));
    } finally {
      emit(AuthLoaded());
    }
  }

  void writeToken(String jwt) {
    _repository.jwt = jwt;
  }

  AuthState? _handleGenericError(AppException exception) {
    //TODO: user more states to handle exceptions.
    if (exception is FetchDataException) {
      return AuthErrorOccurred(errorMessage: exception.errorMessage);
    }
    if (exception is BadRequestException) {
      return AuthErrorOccurred(errorMessage: exception.errorMessage);
    }
    if (exception is ValidateException) {
      return AuthErrorOccurred(errorMessage: exception.errorMessage);
    }
    return AuthErrorOccurred(errorMessage: exception.errorMessage);
  }
}
