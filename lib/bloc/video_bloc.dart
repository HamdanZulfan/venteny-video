import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/video_repository.dart';
import 'video_event.dart';
import 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  final VideoRepository videoRepository;

  VideoBloc(this.videoRepository) : super(VideoInitial()) {
    // Daftarkan handler untuk event FetchVideos
    on<FetchVideos>(_onFetchVideos);
  }

  // Handler untuk event FetchVideos
  Future<void> _onFetchVideos(
      FetchVideos event, Emitter<VideoState> emit) async {
    emit(VideoLoading());
    try {
      final videos = await videoRepository.fetchVideos();
      emit(VideoLoaded(videos));
    } catch (e) {
      emit(VideoError("Failed to fetch videos"));
    }
  }
}
