import 'package:youtube_app/features/home/domain/entities/video_entity.dart';

class VideoDto extends VideoEntity {
  VideoDto(super.publishedAt, super.title, super.description,
      super.imageDefault, super.imageMedium, super.imageHigh, super.videoId);

  factory VideoDto.fromJson(Map map) {
    return VideoDto(
        map['snippet']['publishedAt'],
        map['snippet']['title'],
        map['snippet']['description'],
        map['snippet']['thumbnails']['default']['url'],
        map['snippet']['thumbnails']['medium']['url'],
        map['snippet']['thumbnails']['high']['url'],
        map['id']['videoId']);
  }
}
