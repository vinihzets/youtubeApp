import 'package:either_dart/either.dart';
import 'package:youtube_app/core/failure/failure.dart';
import 'package:youtube_app/features/home/domain/repositories/home_repository.dart';
import 'package:youtube_app/features/home/domain/usecases/get_suggestions_usecase.dart';

class GetSuggestionsUseCaseImp implements GetSuggestionsUseCase {
  HomeRepository homeRepository;

  GetSuggestionsUseCaseImp(this.homeRepository);

  Future<Either<Failure, dynamic>> getSuggestions(String query) {
    return homeRepository.getSuggestions(query);
  }
}
