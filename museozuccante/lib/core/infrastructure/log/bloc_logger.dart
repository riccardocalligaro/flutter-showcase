import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:museo_zuccante/core/infrastructure/log/logger.dart';

class LoggerBlocDelegate extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    Logger.info('📟 [BLOC] $bloc Change: $change');
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    Logger.info('📟 [BLOC] $bloc Event: $event');
    super.onEvent(bloc, event);
  }

  @override
  void onClose(BlocBase bloc) {
    Logger.info('📟 Close BLOC $bloc');
    super.onClose(bloc);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    Logger.info('📟 [BLOC] $bloc Transition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    Object ex;
    if (error is Exception) {
    } else {
      ex = Exception(error.toString());
    }

    Logger.error(
      ex,
      stacktrace,
      text: '📟❌ [BLOC] $bloc',
    );
    super.onError(bloc, error, stacktrace);
  }
}
