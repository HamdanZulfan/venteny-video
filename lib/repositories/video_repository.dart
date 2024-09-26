import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/video_model.dart';

class VideoRepository {
  final String apiUrl =
      "https://itunes.apple.com/search?term=jack+johnson&entity=musicVideo";

  Future<List<VideoModel>> fetchVideos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List videos = json.decode(response.body)['results'];
      return videos.map((video) => VideoModel.fromJson(video)).toList();
    } else {
      throw Exception("Failed to load videos");
    }
  }
}
