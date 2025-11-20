import 'song_model.dart';

class Playlist {
  final String id;
  final String name;
  final String coverUrl;
  final List<Song> songs;

  Playlist({
    required this.id,
    required this.name,
    required this.coverUrl,
    required this.songs,
  });
}
