import 'dart:developer';

import 'package:bloc/bloc.dart';

/// Reports bloc errors without dropping the stack trace.
final class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log(
      error.toString(),
      name: bloc.runtimeType.toString(),
      stackTrace: stackTrace,
    );
  }
}
