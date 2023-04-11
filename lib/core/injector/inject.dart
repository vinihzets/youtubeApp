import 'package:get_it/get_it.dart';
import 'package:youtube_app/features/home/data/datasources/home_datasources.dart';
import 'package:youtube_app/features/home/data/datasources/remote/home_datasources_remote_imp.dart';
import 'package:youtube_app/features/home/data/repositories/home_repository_imp.dart';
import 'package:youtube_app/features/home/domain/repositories/home_repository.dart';
import 'package:youtube_app/features/home/domain/usecases/get_suggestions_usecase.dart';
import 'package:youtube_app/features/home/domain/usecases/get_suggestions_usecase_imp.dart';
import 'package:youtube_app/features/home/domain/usecases/get_youtube_usecase.dart';
import 'package:youtube_app/features/home/domain/usecases/get_youtube_usecase_imp.dart';
import 'package:youtube_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:youtube_app/features/initialization/presentation/bloc/initialize_bloc.dart';

class Inject {
  static injector() {
    GetIt getIt = GetIt.instance;

    //core

    //datasources

    getIt.registerLazySingleton<HomeDataSources>(
        () => HomeDataSourcesRemoteImp());

    // repositories

    getIt.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImp(getIt()));

    //usecases

    getIt.registerLazySingleton<GetSuggestionsUseCase>(
        () => GetSuggestionsUseCaseImp(getIt()));

    getIt.registerLazySingleton<GetYoutubeUseCase>(
        () => GetYoutubeUseCaseImp(getIt()));

    //bloc

    getIt.registerFactory(() => HomeBloc(getIt(), getIt()));
    getIt.registerFactory(() => InitializeBloc());
  }
}
