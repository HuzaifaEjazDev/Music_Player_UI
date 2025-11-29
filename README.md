# Music Player UI with External API Integration

A modern Flutter music player that streams songs from free music APIs instead of hosting them locally.

## Features

- Stream music from free APIs (Audius, YouTube Music, SoundCloud)
- Modern UI with glassmorphism effects
- Full playback controls
- Search functionality
- Playlist support

## Getting Started

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run` to start the application

## Music APIs Integration

This project integrates with the following free music APIs:

### 1. Audius API (Primary)
- Completely free with no rate limits
- Over 1 million tracks with high-quality audio (320kbps)
- No API key required for basic usage

### 2. YouTube Music API (Alternative)
- Access to millions of songs
- Uses the `yt_flutter_musicapi` package

### 3. SoundCloud API (Alternative)
- Large collection of independent music
- Requires registration for API key but offers generous free limits

## Architecture

The project follows a clean architecture pattern:

```
lib/
├── core/              # Constants and theme
├── models/            # Data models (Song, Playlist)
├── services/          # API services
├── viewmodels/        # Business logic (Provider)
├── views/             # UI components
└── widgets/           # Reusable widgets
```

## Implementation Details

### Music Service Layer

The [MusicService] class handles all API communications:
- Fetches trending tracks
- Searches for songs
- Retrieves playlists

### Data Models

The existing [Song] and [Playlist] models were adapted to work with external APIs:
- [audioUrl] stores the streaming URL
- [coverUrl] stores the album art URL

### ViewModels

Updated viewmodels to fetch data from APIs instead of using hardcoded dummy data:
- [HomeViewModel] loads trending tracks and playlists
- [PlayerViewModel] plays songs from streaming URLs

## Dependencies

Key dependencies for API integration:
- `http`: For making API requests
- `just_audio`: For audio playback
- `provider`: For state management

## Cost Considerations

This implementation uses completely free APIs with no infrastructure costs:
- Audius API is completely free with no rate limits
- YouTube Music integration uses a community-maintained package
- SoundCloud offers generous free tiers

## Future Enhancements

- Add offline caching for downloaded songs
- Implement more advanced search filters
- Add user authentication for personalized recommendations
- Integrate with additional music APIs for broader coverage