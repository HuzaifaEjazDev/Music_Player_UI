import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_model.dart';

class PlayerViewModel extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  Song? _currentSong;

  bool get isPlaying => _isPlaying;
  Duration get position => _position;
  Duration get duration => _duration;
  Song? get currentSong => _currentSong;

  PlayerViewModel() {
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });

    _audioPlayer.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((dur) {
      _duration = dur ?? Duration.zero;
      notifyListeners();
    });
  }

  Future<void> playSong(Song song) async {
    _currentSong = song;
    try {
      // Set the audio URL from the song model and play
      await _audioPlayer.setUrl(song.audioUrl);
      await _audioPlayer.play();
      _isPlaying = true;
      notifyListeners();
    } catch (e) {
      print('Error playing song: $e');
    }
  }

  void togglePlayPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
      _isPlaying = false;
    } else {
      _audioPlayer.play();
      _isPlaying = true;
    }
    notifyListeners();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void next() {
    // Implement next logic
  }

  void previous() {
    // Implement previous logic
  }
  
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}