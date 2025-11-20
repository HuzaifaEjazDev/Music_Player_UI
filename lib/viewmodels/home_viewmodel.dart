import 'package:flutter/material.dart';
import '../models/song_model.dart';
import '../models/playlist_model.dart';

class HomeViewModel extends ChangeNotifier {
  List<Song> _recentlyPlayed = [];
  List<Playlist> _playlists = [];

  List<Song> get recentlyPlayed => _recentlyPlayed;
  List<Playlist> get playlists => _playlists;

  HomeViewModel() {
    _loadDummyData();
  }

  void _loadDummyData() {
    _recentlyPlayed = [
      Song(
        id: '1',
        title: 'Starboy',
        artist: 'The Weeknd',
        album: 'Starboy',
        coverUrl: 'https://upload.wikimedia.org/wikipedia/en/3/39/The_Weeknd_-_Starboy.png',
        audioUrl: '',
        duration: const Duration(minutes: 3, seconds: 50),
      ),
      Song(
        id: '2',
        title: 'Blinding Lights',
        artist: 'The Weeknd',
        album: 'After Hours',
        coverUrl: 'https://upload.wikimedia.org/wikipedia/en/e/e6/The_Weeknd_-_Blinding_Lights.png',
        audioUrl: '',
        duration: const Duration(minutes: 3, seconds: 20),
      ),
      Song(
        id: '3',
        title: 'Levitating',
        artist: 'Dua Lipa',
        album: 'Future Nostalgia',
        coverUrl: 'https://upload.wikimedia.org/wikipedia/en/f/f5/Dua_Lipa_-_Levitating.png',
        audioUrl: '',
        duration: const Duration(minutes: 3, seconds: 23),
      ),
    ];

    _playlists = [
      Playlist(
        id: '1',
        name: 'Chill Vibes',
        coverUrl: 'https://images.unsplash.com/photo-1493225255756-d9584f8606e9?w=500&q=80',
        songs: _recentlyPlayed,
      ),
      Playlist(
        id: '2',
        name: 'Workout Hits',
        coverUrl: 'https://images.unsplash.com/photo-1534258936925-c48947387e3b?w=500&q=80',
        songs: _recentlyPlayed,
      ),
    ];
    
    notifyListeners();
  }
}
