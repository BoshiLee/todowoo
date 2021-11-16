import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todowoo/model/register_model.dart';
import 'package:todowoo/networking/app_exception.dart';
import 'package:todowoo/repository/user_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final UserRepository _repository = UserRepository.shared;
  RegisterModel model = RegisterModel();

  RegisterCubit() : super(RegisterInitial());

  Future register() async {
    try {
      emit(RegisterLoading());
      final String? jwt = await _repository.register(model: model);
      if (jwt != null) emit(RegisterSuccess(jwt));
    } on AppException catch (exception) {
      _handleGenericError(exception);
    } catch (e) {
      emit(RegisterErrorOccurred(errorMessage: e.toString()));
    } finally {
      emit(RegisterLoaded());
    }
  }

  void writeToken(String jwt) {
    _repository.jwt = jwt;
  }

  RegisterState? _handleGenericError(AppException exception) {
    //TODO: user more states to handle exceptions.
    if (exception is FetchDataException) {
      return RegisterErrorOccurred(errorMessage: exception.errorMessage);
    }
    if (exception is BadRequestException) {
      return RegisterErrorOccurred(errorMessage: exception.errorMessage);
    }
    if (exception is ValidateException) {
      return RegisterErrorOccurred(errorMessage: exception.errorMessage);
    }
    return RegisterErrorOccurred(errorMessage: exception.errorMessage);
  }
}
