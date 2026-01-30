import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/firebase_error_handler/error_translator/error_translator.dart';
import 'package:transit_tracer/core/firebase_error_handler/firebase_error_type/firebase_error_type.dart';
import 'package:transit_tracer/features/auth/bloc/auth_bloc.dart';
import 'package:transit_tracer/features/auth/widgets/forms/login_form.dart';
import 'package:transit_tracer/features/auth/widgets/forms/register_form.dart';

class AuthView extends StatefulWidget {
  const AuthView({
    super.key,
    required this.state,
    required this.formKey,
    this.loginEmailErrorType,
    this.loginPasswordErrorType,
    this.registerEmailErrorType,
    this.registerPasswordErrorType,
  });

  final FirebaseErrorType? loginEmailErrorType;
  final FirebaseErrorType? loginPasswordErrorType;
  final FirebaseErrorType? registerEmailErrorType;
  final FirebaseErrorType? registerPasswordErrorType;

  final GlobalKey<FormState> formKey;
  final AuthState state;

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(StartLogin());
  }

  // String? _mapErrorToText(FirebaseErrorType? type) {
  //   if (type == null) return null;

  //   final s = S.of(context);

  //   switch (type) {
  //     case FirebaseErrorType.emailAlreadyInUse:
  //       return s.firebaseValidationEmailInUse;
  //     case FirebaseErrorType.invalidEmail:
  //       return s.firebaseValidationInvalidEmail;
  //     case FirebaseErrorType.weakPassword:
  //       return s.firebaseValidationWeekPassword;
  //     case FirebaseErrorType.userNotFound:
  //       return s.firebaseValidationUserNotFound;
  //     case FirebaseErrorType.wrongPassword:
  //       return s.firebaseValidationWrongPassword;
  //     default:
  //       return s.firebaseValidationSomethingWrong;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (widget.state is LoginActive ||
        widget.state is LoginLoading ||
        widget.state is LoginFailureState) {
      return LoginForm(
        formKey: widget.formKey,
        state: widget.state,
        externalEmailError: ErrorTranslator.translate(
          context,
          widget.loginEmailErrorType,
        ),
        externalPasswordError: ErrorTranslator.translate(
          context,
          widget.loginPasswordErrorType,
        ),
      );
    } else {
      return RegisterForm(
        formKey: widget.formKey,
        externalEmailError: ErrorTranslator.translate(
          context,
          widget.registerEmailErrorType,
        ),
        externalPasswordError: ErrorTranslator.translate(
          context,
          widget.registerPasswordErrorType,
        ),
      );
    }
  }
}
