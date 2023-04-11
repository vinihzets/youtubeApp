import 'package:either_dart/either.dart';
import 'package:youtube_app/core/failure/failure.dart';
import 'package:youtube_app/features/home/domain/repositories/home_repository.dart';
import 'package:youtube_app/features/home/domain/usecases/get_youtube_usecase.dart';

class GetYoutubeUseCaseImp implements GetYoutubeUseCase {
  HomeRepository homeRepository;

  GetYoutubeUseCaseImp(this.homeRepository);
  Future<Either<Failure, dynamic>> get() {
    return homeRepository.getPlayers();
  }
}
