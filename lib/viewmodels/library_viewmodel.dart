import 'package:flutter/material.dart';
import '../models/playlist_model.dart';
import '../models/song_model.dart';
import '../services/music_service.dart';

class LibraryViewModel extends ChangeNotifier {
  List<Playlist> _userPlaylists = [];
  List<Song> _likedSongs = [];
  List<String> _artists = [];
  List<String> _albums = [];
  final MusicService _musicService = MusicService();

  List<Playlist> get userPlaylists => _userPlaylists;
  List<Song> get likedSongs => _likedSongs;
  List<String> get artists => _artists;
  List<String> get albums => _albums;

  LibraryViewModel() {
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Load trending playlists from Audius API
      _userPlaylists = await _musicService.fetchTrendingPlaylists();
      
      // Load trending tracks to use for liked songs and extract artists/albums
      final trendingTracks = await _musicService.fetchTrendingTracks();
      _likedSongs = trendingTracks;
      
      // Extract unique artists and albums
      final uniqueArtists = <String>{};
      final uniqueAlbums = <String>{};
      
      for (var track in trendingTracks) {
        uniqueArtists.add(track.artist);
        uniqueAlbums.add(track.album);
      }
      
      _artists = uniqueArtists.toList();
      _albums = uniqueAlbums.toList();
      
      notifyListeners();
    } catch (e) {
      print('Error loading library data: $e');
      // Fallback to dummy data if API fails
      _loadDummyData();
    }
  }

  void _loadDummyData() {
    // Reuse some dummy data structure or create new
    _userPlaylists = [
      Playlist(
        id: '3',
        name: 'My Favorites',
        coverUrl:
            'https://images.unsplash.com/photo-1494232410401-ad00d5433cfa?w=500&q=80',
        songs: [],
      ),
      Playlist(
        id: '4',
        name: 'Gym Motivation',
        coverUrl:
            'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=500&q=80',
        songs: [],
      ),
    ];

    _artists = [
      'The Weeknd',
      'Dua Lipa',
      'Drake',
      'Ariana Grande',
      'Post Malone',
    ];
    _albums = [
      'Starboy',
      'Future Nostalgia',
      'After Hours',
      'Positions',
      'Hollywood\'s Bleeding',
    ];

    notifyListeners();
  }
}