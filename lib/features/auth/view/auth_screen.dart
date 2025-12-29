import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:transit_tracer/core/models/auth_error_type/auth_error_type.dart';
import 'package:transit_tracer/features/auth/view/auth_view.dart';
import 'package:transit_tracer/features/auth/bloc/auth_bloc.dart';
import 'package:transit_tracer/features/auth/cubit/password_strength_meter_cubit.dart';
import 'package:transit_tracer/features/auth/widgets/blur_loader/blur_loader.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  AuthErrorType? loginEmailErrorType;
  AuthErrorType? loginPasswordErrorType;

  AuthErrorType? registerEmailErrorType;
  AuthErrorType? registerPasswordErrorType;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetIt.I<AuthBloc>()),
        BlocProvider(create: (context) => PasswordStrengthMeterCubit()),
      ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoginFailureState) {
                setState(() {
                  loginEmailErrorType = state.errorEmailType;
                  loginPasswordErrorType = state.errorPasswordType;
                });
              }
              if (state is RegisterFailureState) {
                setState(() {
                  registerEmailErrorType = state.errorEmailType;
                  registerPasswordErrorType = state.errorPasswordType;
                });
              }
              if (state is AuthInitial) {
                setState(() {
                  loginEmailErrorType = null;
                  loginPasswordErrorType = null;

                  registerEmailErrorType = null;
                  registerPasswordErrorType = null;
                });
              }
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    SafeArea(
                      child: Center(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: AuthView(
                                    state: state,
                                    formKey: _formKey,
                                    loginEmailErrorType: loginEmailErrorType,
                                    loginPasswordErrorType:
                                        loginPasswordErrorType,
                                    registerEmailErrorType:
                                        registerEmailErrorType,
                                    registerPasswordErrorType:
                                        registerPasswordErrorType,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (state is LoginLoading || state is RegisterLoading)
                      const BlurLoader(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
