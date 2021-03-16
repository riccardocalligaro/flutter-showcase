import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memos/core/core_container.dart';
import 'package:memos/core/presentation/m_colors.dart';

import 'package:memos/feature/memos/presentation/memos_page.dart';
import 'package:memos/feature/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'feature/login/login_page.dart';
import 'feature/login/model/current_user.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  // Always use this before initializing the firebase app
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();

  await Firebase.initializeApp();

  // Wait for dependency injection
  await CoreContainer.init();

  // nel dubbio
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);

  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  // trasparent status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(
    MultiBlocProvider(
      providers: CoreContainer.getBlocProviders(),
      child: MemosApp(),
    ),
  );
}

class MemosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: FirebaseAuth.instance
          .authStateChanges()
          .map((user) => CurrentUser.create(user)),
      initialData: CurrentUser.initial,
      child: Consumer<CurrentUser>(
        builder: (context, user, _) {
          return MaterialApp(
            title: 'Memos App',
            theme: ThemeData(
              fontFamily: 'Product Sans',
              primaryColor: MColors.primary,
              primarySwatch: Colors.blue,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: MColors.primary,
              ),
              appBarTheme: AppBarTheme(
                color: MColors.primary,
              ),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: user.isInitialValue
                ? SplashScreen()
                : user.data != null
                    ? MemosPage()
                    : LoginPage(),
          );
        },
      ),
    );
  }
}
