import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/library_viewmodel.dart';
import '../../viewmodels/player_viewmodel.dart';
import '../../core/constants.dart';
import 'playlist_detail_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Library'),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Playlists'),
              Tab(text: 'Artists'),
              Tab(text: 'Albums'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [_PlaylistsTab(), _ArtistsTab(), _AlbumsTab()],
        ),
      ),
    );
  }
}

class _PlaylistsTab extends StatelessWidget {
  const _PlaylistsTab();

  @override
  Widget build(BuildContext context) {
    final libraryViewModel = Provider.of<LibraryViewModel>(context);
    final playlists = libraryViewModel.userPlaylists;

    return playlists.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              final playlist = playlists[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    playlist.coverUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 56,
                      height: 56,
                      color: Colors.grey[800],
                      child: const Icon(Icons.music_note),
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey[800],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ),
                title: Text(
                  playlist.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${playlist.songs.length} songs'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PlaylistDetailScreen(playlist: playlist),
                    ),
                  );
                },
              );
            },
          );
  }
}

class _ArtistsTab extends StatelessWidget {
  const _ArtistsTab();

  @override
  Widget build(BuildContext context) {
    final libraryViewModel = Provider.of<LibraryViewModel>(context);
    final artists = libraryViewModel.artists;

    return artists.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            itemCount: artists.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.grey[800],
                  child: Text(artists[index][0]),
                ),
                title: Text(artists[index]),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              );
            },
          );
  }
}

class _AlbumsTab extends StatelessWidget {
  const _AlbumsTab();

  @override
  Widget build(BuildContext context) {
    final libraryViewModel = Provider.of<LibraryViewModel>(context);
    final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);
    final albums = libraryViewModel.albums;
    final albumsMap = libraryViewModel.albumsMap;

    return albums.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GridView.builder(
            padding: const EdgeInsets.all(AppConstants.defaultPadding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final albumName = albums[index];
              final albumSongs = albumsMap[albumName] ?? [];
              final songCount = albumSongs.length;
              
              return GestureDetector(
                onTap: () {
                  // Play the first song in the album when tapped
                  if (albumSongs.isNotEmpty) {
                    playerViewModel.playSong(albumSongs.first);
                    
                    // Show a snackbar to indicate the song is playing
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Playing ${albumSongs.first.title} from $albumName'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(
                            AppConstants.defaultRadius,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              // Use the cover URL from the first song in the album if available
                              albumSongs.isNotEmpty && albumSongs.first.coverUrl.isNotEmpty
                                  ? albumSongs.first.coverUrl
                                  : 'https://placehold.co/300/303030/FFFFFF?text=${Uri.encodeComponent(albumName)}',
                            ),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {
                              // Handle image loading errors by showing a placeholder
                            },
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppConstants.defaultRadius,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.play_circle,
                              color: Colors.white.withOpacity(0.8),
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      albumName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '$songCount songs',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
  }
}