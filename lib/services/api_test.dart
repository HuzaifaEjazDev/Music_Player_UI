import 'package:flutter/material.dart';
import 'music_service.dart';

class ApiTestScreen extends StatefulWidget {
  @override
  _ApiTestScreenState createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  final MusicService _musicService = MusicService();
  List<dynamic> _tracks = [];
  bool _isLoading = false;
  String _error = '';

  Future<void> _testApi() async {
    setState(() {
      _isLoading = true;
      _error = '';
      _tracks = [];
    });

    try {
      final tracks = await _musicService.fetchTrendingTracks();
      setState(() {
        _tracks = tracks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _testApi,
              child: Text('Fetch Trending Tracks'),
            ),
            SizedBox(height: 20),
            if (_isLoading)
              CircularProgressIndicator()
            else if (_error.isNotEmpty)
              Text('Error: $_error', style: TextStyle(color: Colors.red)),
            if (_tracks.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _tracks.length,
                  itemBuilder: (context, index) {
                    final track = _tracks[index];
                    return Card(
                      child: ListTile(
                        title: Text(track.title),
                        subtitle: Text('${track.artist} - ${track.album}'),
                        trailing: Text(
                          '${track.duration.inMinutes}:${(track.duration.inSeconds % 60).toString().padLeft(2, '0')}',
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}