import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/video_bloc.dart';
import '../bloc/video_state.dart';
import '../bloc/video_event.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  int? selectedVideoIndex;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  void _loadVideos() {
    context.read<VideoBloc>().add(FetchVideos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<VideoBloc, VideoState>(
          builder: (context, state) {
            if (state is VideoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is VideoLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    selectedVideoIndex =
                        null; // Reset selected index on refresh
                  });
                  _loadVideos();
                },
                child: ListView.builder(
                  itemCount: state.videos.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          if (selectedVideoIndex == index)
                            ClipRect(
                              child: SizedBox(
                                width: double.infinity,
                                height: 220,
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: FlickVideoPlayer(
                                    flickManager: FlickManager(
                                      videoPlayerController:
                                          VideoPlayerController.networkUrl(
                                        Uri.parse(
                                            state.videos[index].previewUrl),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Colors.orange,
                              radius: 18,
                              child:
                                  Icon(Icons.play_arrow, color: Colors.white),
                            ),
                            title: Text(state.videos[index].title),
                            subtitle: Text(state.videos[index].kind),
                            onTap: () {
                              setState(() {
                                selectedVideoIndex = index;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }

            if (state is VideoError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Failed to load videos: ${state.message}'),
                    ElevatedButton(
                      onPressed: () {
                        _loadVideos();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: Text('No videos available'),
            );
          },
        ),
      ),
    );
  }
}
