import 'package:flutter/material.dart';

var _baseTextTheme = const TextTheme(
  titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
  titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  bodyMedium: TextStyle(fontSize: 18),
  bodySmall: TextStyle(fontSize: 12),
  headlineLarge: TextStyle(fontWeight: FontWeight.bold),
);

var darkTheme = ThemeData(
  primaryColor: const Color(0xFFFFA632),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFF1E1F22),

  popupMenuTheme: PopupMenuThemeData(
    color: const Color(0xFF2C2C2C).withValues(alpha: 0.8),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
    labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2A2B2F),
    foregroundColor: Colors.white,
    centerTitle: true,
    elevation: 0,
  ),

  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFA632),
    surface: const Color(0xFF2A2B2F),
    surfaceContainer: const Color(0xFF3A3A40),
    onSurface: Colors.white,
    brightness: Brightness.dark,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF2A2B2f),
    selectedItemColor: Color(0xFFFFA632),
    unselectedItemColor: Colors.white54,
  ),

  textTheme: _baseTextTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),

  iconTheme: const IconThemeData(color: Colors.white),

  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xFF2D3238),
    contentTextStyle: const TextStyle(color: Colors.white, fontSize: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: const BorderSide(color: Color(0xFF33373B), width: 1),
    ),
    elevation: 10,
  ),
);

var lightTheme = ThemeData(
  primaryColor: const Color(0xFFFFA632),
  useMaterial3: true,
  scaffoldBackgroundColor: const Color(0xFFF3F3F5),

  popupMenuTheme: PopupMenuThemeData(
    color: Colors.white.withValues(alpha: 0.95),
  ),

  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
    labelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,

    centerTitle: true,
    elevation: 0,
  ),

  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFA632),
    surface: Colors.white,
    surfaceContainer: const Color(0xFFC8C8C8),
    onSurface: Colors.black,
    brightness: Brightness.light,
  ),

  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: Color(0xFFFFA632),
    unselectedItemColor: Colors.black54,
  ),

  iconTheme: const IconThemeData(color: Colors.black),

  textTheme: _baseTextTheme.apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  ),
  snackBarTheme: SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.white,
    contentTextStyle: const TextStyle(color: Colors.black, fontSize: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: Colors.grey.shade600, width: 1),
    ),
    elevation: 8,
  ),
);

// var darkTheme = ThemeData(
//   useMaterial3: true,

//   // ✅ фон экрана (очень тёмный, без зелени)
//   scaffoldBackgroundColor: Color(0xFF0E0F12),

//   // ✅ основной акцент (как в рендере)
//   primaryColor: const Color(0xFFFFB547),

//   // ✅ ColorScheme — ключевое
//   colorScheme: ColorScheme.fromSeed(
//     seedColor: const Color(0xFFFFB547),
//     brightness: Brightness.dark,

//     // ⚠️ по твоему правилу:
//     // surface = контейнеры/карточки
//     surface: const Color(0xFF24262D),

//     // surfaceContainer = формы/поля (чуть темнее/ровнее)
//     surfaceContainer: const Color(0xFF1F2127),

//     // текст
//     onSurface: const Color(0xFFF1F1F1),
//     onSurfaceVariant: const Color(0xFFB0B3BA),

//     // фон схемы
//     background: const Color(0xFF0F1115),

//     // primary
//     primary: const Color(0xFFFFB547),
//     onPrimary: const Color(0xFF141414),
//   ),

//   // ✅ AppBar как на картинке: чуть светлее фона, но темнее карточек
//   appBarTheme: const AppBarTheme(
//     backgroundColor: Color(0xFF1A1C21),
//     foregroundColor: Color(0xFFF1F1F1),
//     centerTitle: true,
//     elevation: 0,
//   ),

//   // ✅ BottomNav такой же, как AppBar
//   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
//     backgroundColor: Color(0xFF1A1C21),
//     selectedItemColor: Color(0xFFFFB547),
//     unselectedItemColor: Color(0xFFB0B3BA),
//     type: BottomNavigationBarType.fixed,
//   ),

//   // ✅ PopupMenu без “грязно-серого”
//   popupMenuTheme: PopupMenuThemeData(
//     color: const Color(0xFF24262D).withValues(alpha: 0.95),
//     surfaceTintColor: Colors.transparent,
//   ),

//   // ✅ Инпуты: плейсхолдер/лейбл — спокойные серые
//   inputDecorationTheme: const InputDecorationTheme(
//     hintStyle: TextStyle(
//       fontWeight: FontWeight.normal,
//       fontSize: 16,
//       color: Color(0xFFB0B3BA),
//     ),
//     labelStyle: TextStyle(
//       fontWeight: FontWeight.normal,
//       fontSize: 16,
//       color: Color(0xFFB0B3BA),
//     ),
//   ),

//   // ✅ текст
//   textTheme: _baseTextTheme.apply(
//     bodyColor: const Color(0xFFF1F1F1),
//     displayColor: const Color(0xFFF1F1F1),
//   ),
// );
