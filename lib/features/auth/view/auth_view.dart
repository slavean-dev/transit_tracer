import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transit_tracer/core/models/auth_error_type/auth_error_type.dart';
import 'package:transit_tracer/features/auth/bloc/auth_bloc.dart';
import 'package:transit_tracer/features/auth/widgets/forms/login_form.dart';
import 'package:transit_tracer/features/auth/widgets/forms/register_form.dart';
import 'package:transit_tracer/generated/l10n.dart';

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

  final AuthErrorType? loginEmailErrorType;
  final AuthErrorType? loginPasswordErrorType;
  final AuthErrorType? registerEmailErrorType;
  final AuthErrorType? registerPasswordErrorType;

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

  String? _mapErrorToText(AuthErrorType? type) {
    if (type == null) return null;

    final s = S.of(context);

    switch (type) {
      case AuthErrorType.emailAlreadyInUse:
        return s.firebaseValidationEmailInUse;
      case AuthErrorType.invalidEmail:
        return s.firebaseValidationInvalidEmail;
      case AuthErrorType.weakPassword:
        return s.firebaseValidationWeekPassword;
      case AuthErrorType.userNotFound:
        return s.firebaseValidationUserNotFound;
      case AuthErrorType.wrongPassword:
        return s.firebaseValidationWrongPassword;
      default:
        return s.firebaseValidationSomethingWrong;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.state is LoginActive ||
        widget.state is LoginLoading ||
        widget.state is LoginFailureState) {
      return LoginForm(
        formKey: widget.formKey,
        state: widget.state,
        externalEmailError: _mapErrorToText(widget.loginEmailErrorType),
        externalPasswordError: _mapErrorToText(widget.loginPasswordErrorType),
      );
    } else {
      return RegisterForm(
        formKey: widget.formKey,
        externalEmailError: _mapErrorToText(widget.registerEmailErrorType),
        externalPasswordError: _mapErrorToText(
          widget.registerPasswordErrorType,
        ),
      );
    }
  }
}
