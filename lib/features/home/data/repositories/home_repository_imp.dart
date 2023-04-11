import 'package:either_dart/either.dart';
import 'package:youtube_app/core/failure/failure.dart';
import 'package:youtube_app/features/home/data/datasources/home_datasources.dart';
import 'package:youtube_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeDataSources homeDataSources;

  HomeRepositoryImp(this.homeDataSources);

  @override
  Future<Either<Failure, dynamic>> getPlayers() {
    return homeDataSources.getPlayers();
  }

  @override
  Future<Either<Failure, dynamic>> getSuggestions(String query) {
    return homeDataSources.getSuggestions(query);
  }
}
