import 'package:either_dart/either.dart';
import 'package:youtube_app/core/failure/failure.dart';
import 'package:youtube_app/features/home/domain/entities/video_entity.dart';

abstract class HomeDataSources {
  Future<Either<Failure, List>> getPlayers();
}