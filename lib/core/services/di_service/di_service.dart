import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:transit_tracer/core/services/network_service/network_service.dart';
import 'package:transit_tracer/features/orders/bloc/order_details/order_details_bloc.dart';
import 'package:transit_tracer/features/user/bloc/app_user_bloc.dart';
import 'package:transit_tracer/core/data/repositories/media_repository/abstract_media_repository.dart';
import 'package:transit_tracer/core/data/repositories/media_repository/firebase_media_repository.dart';
import 'package:transit_tracer/features/orders/bloc/orders_bloc/orders_bloc.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/abstract_order_repository.dart';
import 'package:transit_tracer/features/orders/data/order_data_repository/order_data_repository.dart';
import 'package:transit_tracer/features/user/user_data_repository/abstract_user_data.dart';
import 'package:transit_tracer/features/user/user_data_repository/user_data_repository.dart';
import 'package:transit_tracer/features/settings/cubit/settings_cubit.dart';
import 'package:transit_tracer/features/settings/settings_reposytory/abstract_settings_repository.dart';
import 'package:transit_tracer/features/settings/settings_reposytory/settings_repository.dart';

import 'package:transit_tracer/features/auth/bloc/auth_bloc.dart';
import 'package:transit_tracer/features/auth/auth_repository/abstract_auth_repository.dart';
import 'package:transit_tracer/features/auth/auth_repository/auth_repository.dart';
import 'package:transit_tracer/features/profile/cubit/profile_cubit.dart';
import 'package:transit_tracer/features/profile/repository/abstract_profile_repository.dart';
import 'package:transit_tracer/features/profile/repository/profile_repository.dart';
import 'package:transit_tracer/app/router/router.dart';
import 'package:transit_tracer/core/services/app_info/app_info.dart';
import 'package:transit_tracer/core/services/env_service/env_service.dart';
import 'package:transit_tracer/core/services/google_route_service/google_route_service.dart';
import 'package:transit_tracer/core/services/media_service/media_service.dart';

class DiService {
  void initDI(SharedPreferences prefs) async {
    final getIt = GetIt.I;

    getIt.registerSingleton<InternetConnection>(InternetConnection());

    getIt.registerSingleton<NetworkService>(
      NetworkService(checker: getIt<InternetConnection>()),
    );

    getIt.registerSingleton<AppRouter>(AppRouter());

    getIt.registerSingleton<AppInfo>(AppInfo());

    getIt.registerSingleton<EnvService>(EnvService()..initEnv());

    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
    getIt.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);

    getIt.registerSingleton<SharedPreferences>(prefs);

    getIt.registerLazySingleton<PlatformDispatcher>(
      () => PlatformDispatcher.instance,
    );

    getIt.registerLazySingleton<Dio>(() => Dio());

    getIt.registerSingleton<GoogleRouteService>(
      GoogleRouteService(
        dio: getIt<Dio>(),
        apiKey: getIt<EnvService>().autocompleteApiKey,
      ),
    );

    getIt.registerSingleton<AbstractSettingsRepository>(
      SettingsRepository(
        sharedPreferences: getIt<SharedPreferences>(),
        dispatcher: getIt<PlatformDispatcher>(),
      ),
    );

    getIt.registerFactory(
      () => SettingsCubit(getIt<AbstractSettingsRepository>()),
    );

    getIt.registerSingleton<AbstractAuthRepository>(
      AuthRepository(
        auth: getIt<FirebaseAuth>(),
        firestore: getIt<FirebaseFirestore>(),
      ),
    );

    getIt.registerFactory(() => AuthBloc(getIt<AbstractAuthRepository>()));

    getIt.registerSingleton<AbstractMediaRepository>(
      FirebaseMediaRepository(firebaseStorage: getIt<FirebaseStorage>()),
    );

    getIt.registerSingleton<AbstractUserDataRepository>(
      UserDataRepository(
        firebaseAuth: getIt<FirebaseAuth>(),
        firebaseFirestore: getIt<FirebaseFirestore>(),
      ),
    );

    getIt.registerSingleton<AbstractOrderRepository>(
      OrderDataRepository(
        firebaseAuth: getIt<FirebaseAuth>(),
        firebaseFirestore: getIt<FirebaseFirestore>(),
      ),
    );

    getIt.registerFactory(() => OrdersBloc(getIt<AbstractOrderRepository>()));

    getIt.registerSingleton<AbstractProfileRepository>(
      ProfileRepository(
        media: getIt<AbstractMediaRepository>(),
        userData: getIt<AbstractUserDataRepository>(),
      ),
    );

    getIt.registerFactory(
      () => OrderDetailsBloc(
        getIt<AbstractOrderRepository>(),
        getIt<NetworkService>(),
      ),
    );

    getIt.registerFactory(
      () => AppUserBloc(
        abstractAuthRepository: getIt<AbstractAuthRepository>(),
        abstractUserDataRepository: getIt<AbstractUserDataRepository>(),
      ),
    );

    getIt.registerLazySingleton<ImagePicker>(() => ImagePicker());
    getIt.registerLazySingleton<ImageCropper>(() => ImageCropper());

    getIt.registerLazySingleton<MediaService>(
      () => MediaService(
        picker: getIt<ImagePicker>(),
        cropper: getIt<ImageCropper>(),
      ),
    );

    getIt.registerFactory(
      () => ProfileCubit(getIt<AbstractProfileRepository>()),
    );
  }
}
