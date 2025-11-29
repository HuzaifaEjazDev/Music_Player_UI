import 'package:flutter/material.dart';
import 'music_service.dart';

class ApiDebugScreen extends StatefulWidget {
  @override
  _ApiDebugScreenState createState() => _ApiDebugScreenState();
}

class _ApiDebugScreenState extends State<ApiDebugScreen> {
  final MusicService _musicService = MusicService();
  bool _isLoading = false;
  String _status = 'Ready to test';
  List<dynamic> _results = [];

  Future<void> _testApi() async {
    setState(() {
      _isLoading = true;
      _status = 'Testing API connection...';
      _results = [];
    });

    try {
      // Test 1: Fetch trending tracks
      setState(() {
        _status = 'Fetching trending tracks...';
      });
      
      final tracks = await _musicService.fetchTrendingTracks();
      
      setState(() {
        _status = 'Success! Found ${tracks.length} trending tracks';
        _results = tracks;
      });
      
      // Test 2: Fetch trending playlists
      setState(() {
        _status = 'Fetching trending playlists...';
      });
      
      final playlists = await _musicService.fetchTrendingPlaylists();
      
      setState(() {
        _status = 'Success! Found ${tracks.length} tracks and ${playlists.length} playlists';
        _results = [...tracks, ...playlists];
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Debug'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _isLoading ? null : _testApi,
              child: _isLoading 
                ? CircularProgressIndicator() 
                : Text('Test API Connection'),
            ),
            SizedBox(height: 20),
            Text(_status, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            if (_results.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final item = _results[index];
                    if (item.runtimeType.toString().contains('Song')) {
                      return Card(
                        child: ListTile(
                          title: Text(item.title),
                          subtitle: Text('${item.artist} - ${item.album}'),
                        ),
                      );
                    } else {
                      return Card(
                        child: ListTile(
                          title: Text(item.name),
                          subtitle: Text('Playlist'),
                        ),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}