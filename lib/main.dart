import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transit_tracer/app.dart';
import 'package:transit_tracer/core/settings/cubit/settings_cubit.dart';
import 'package:transit_tracer/services/app_info/app_info.dart';
import 'package:transit_tracer/services/di_service/di_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  await GetIt.I.reset(dispose: true);
  final prefs = await SharedPreferences.getInstance();
  DiService().initDI(prefs);
  await GetIt.I<AppInfo>().init();
  runApp(
    BlocProvider(
      create: (context) => GetIt.I<SettingsCubit>(),
      child: TransitTracerApp(),
    ),
  );
}
