import 'package:either_dart/either.dart';
import 'package:youtube_app/core/failure/failure.dart';

abstract class HomeDataSources {
  Future<Either<Failure, List>> getPlayers();
  Future<Either<Failure, dynamic>> getSuggestions(String query);
}
