import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song_model.dart';
import '../models/playlist_model.dart';

class MusicService {
  // Audius API base URL - we'll dynamically fetch the host
  static const String audiusHostsUrl = 'https://api.audius.co';
  
  /// Get a random Audius API host
  Future<String> _getAudiusHost() async {
    try {
      final response = await http.get(Uri.parse(audiusHostsUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final hosts = List<String>.from(data['data']);
        // Return the first host for simplicity
        return hosts.first;
      } else {
        // Fallback host
        return 'https://discoveryprovider.audius.co';
      }
    } catch (e) {
      // Fallback host
      return 'https://discoveryprovider.audius.co';
    }
  }
  
  /// Fetch trending tracks from Audius API
  Future<List<Song>> fetchTrendingTracks() async {
    try {
      final host = await _getAudiusHost();
      final response = await http.get(
        Uri.parse('$host/v1/tracks/trending?app_name=music_player_ui&limit=10'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final tracks = data['data'] as List;
        
        return tracks.map((track) {
          // Get the cover image URL from the track data
          String coverUrl = '';
          if (track['artwork'] != null && track['artwork']['sizes'] != null) {
            // Get the largest available artwork size
            final sizes = track['artwork']['sizes'] as List;
            if (sizes.isNotEmpty) {
              coverUrl = sizes.last['url'] ?? '';
            }
          }
          
          return Song(
            id: track['id'],
            title: track['title'],
            artist: track['user']['name'],
            album: track['genre'] ?? 'Unknown',
            coverUrl: coverUrl,
            audioUrl: '$host/v1/tracks/${track['id']}/stream?app_name=music_player_ui',
            duration: Duration(seconds: track['duration'] ?? 0),
          );
        }).toList();
      } else {
        throw Exception('Failed to load trending tracks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching trending tracks: $e');
      rethrow;
    }
  }
  
  /// Search tracks on Audius API
  Future<List<Song>> searchTracks(String query) async {
    try {
      final host = await _getAudiusHost();
      final response = await http.get(
        Uri.parse('$host/v1/tracks/search?app_name=music_player_ui&query=$query&limit=20'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final tracks = data['data'] as List;
        
        return tracks.map((track) {
          // Get the cover image URL from the track data
          String coverUrl = '';
          if (track['artwork'] != null && track['artwork']['sizes'] != null) {
            // Get the largest available artwork size
            final sizes = track['artwork']['sizes'] as List;
            if (sizes.isNotEmpty) {
              coverUrl = sizes.last['url'] ?? '';
            }
          }
          
          return Song(
            id: track['id'],
            title: track['title'],
            artist: track['user']['name'],
            album: track['genre'] ?? 'Unknown',
            coverUrl: coverUrl,
            audioUrl: '$host/v1/tracks/${track['id']}/stream?app_name=music_player_ui',
            duration: Duration(seconds: track['duration'] ?? 0),
          );
        }).toList();
      } else {
        throw Exception('Failed to search tracks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error searching tracks: $e');
      rethrow;
    }
  }
  
  /// Fetch playlists from Audius API
  Future<List<Playlist>> fetchTrendingPlaylists() async {
    try {
      final host = await _getAudiusHost();
      final response = await http.get(
        Uri.parse('$host/v1/playlists/trending?app_name=music_player_ui&limit=5'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final playlists = data['data'] as List;
        
        return playlists.map((playlist) {
          // Get the cover image URL from the playlist data
          String coverUrl = '';
          if (playlist['artwork'] != null && playlist['artwork']['sizes'] != null) {
            // Get the largest available artwork size
            final sizes = playlist['artwork']['sizes'] as List;
            if (sizes.isNotEmpty) {
              coverUrl = sizes.last['url'] ?? '';
            }
          }
          
          // For simplicity, we're not fetching playlist tracks here
          // In a real implementation, you'd fetch the full playlist details
          return Playlist(
            id: playlist['id'],
            name: playlist['playlist_name'],
            coverUrl: coverUrl,
            songs: [], // Would be populated with actual songs in a full implementation
          );
        }).toList();
      } else {
        throw Exception('Failed to load trending playlists: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching trending playlists: $e');
      rethrow;
    }
  }
}