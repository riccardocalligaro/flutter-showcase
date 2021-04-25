import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:museo_zuccante/core/presentation/customization/mz_colors.dart';

import 'core/core_container.dart';
import 'core/data/remote/mz_dio_client.dart';
import 'core/infrastructure/localization/app_localizations.dart';
import 'core/infrastructure/localization/bloc/language_bloc.dart';
import 'core/infrastructure/log/bloc_logger.dart';
import 'core/infrastructure/log/logger.dart';
import 'feature/mz_navigator.dart';

void main() async {
  // E' necessario aggiungerlo prima della dependency injection
  WidgetsFlutterBinding.ensureInitialized();

  await CoreContainer.init();

  Bloc.observer = LoggerBlocDelegate();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));

  runZonedGuarded(() {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LanguageBloc(),
          ),
          ...CoreContainer.getBlocProviders(),
        ],
        child: MZApp(),
      ),
    );
  }, Logger.error);
}

class MZApp extends StatelessWidget {
  const MZApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, languageState) {
        return MaterialApp(
          title: 'Museo Zuccante',
          navigatorKey: navigatorKey,
          supportedLocales: [
            Locale('en', 'US'),
            Locale('it', 'IT'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          locale: languageState.locale,
          theme: ThemeData(
            // fontFamily: 'Montserrat',
            textTheme: GoogleFonts.karlaTextTheme(
              Theme.of(context).textTheme,
            ),

            scaffoldBackgroundColor: Color(0xffffffff),
            primaryColor: MZColors.primary,
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MZNavigator(),
        );
      },
    );
  }
}
