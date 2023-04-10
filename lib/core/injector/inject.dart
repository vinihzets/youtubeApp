import 'package:get_it/get_it.dart';
import 'package:youtube_app/features/initialization/presentation/bloc/initialize_bloc.dart';

class Inject {
  static injector() {
    GetIt getIt = GetIt.instance;

    //core

    //datasources

    // repositories

    //usecases

    //bloc

    getIt.registerFactory(() => InitializeBloc());
  }
}
