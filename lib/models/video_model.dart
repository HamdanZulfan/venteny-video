class VideoModel {
  final String title;
  final String previewUrl;
  final String kind;

  VideoModel(
      {required this.title, required this.previewUrl, required this.kind});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
        title: json['trackName'],
        previewUrl: json['previewUrl'],
        kind: json['kind']);
  }
}
