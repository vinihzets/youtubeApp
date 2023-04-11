import 'package:either_dart/either.dart';
import 'package:youtube_app/core/failure/failure.dart';

abstract class HomeRepository {
  Future<Either<Failure, dynamic>> getPlayers();
}
