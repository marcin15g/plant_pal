# Plant Pal

A Flutter app for plant lovers: search a database of plant species, keep a
personal collection of your own plants with photos, and get reminded when it's
time to water them.

## Features

- **Browse**: search plant species and view details (family, genus,
  author and more) from the [FloraCodex](https://floracodex.com) API
- **My Collection**: add your own plants with a nickname, common name and a photo taken
  with the camera or picked from the gallery; edit and delete them
- **Watering assistant**: set how often each plant needs water, see which
  plants need watering today, and get a local notification on the day
- **Sign in with Google**: each user's collection is stored in their own
  Firebase account and syncs across devices

## Tech stack

- [Flutter](https://flutter.dev) / Dart, state management with
  [provider](https://pub.dev/packages/provider)
- Firebase Authentication (Google Sign-In), Realtime Database and Storage
- `flutter_local_notifications` for scheduled watering reminders
- REST calls to the FloraCodex plant API

## Project structure

```
lib/
  screens/     collection, browse, plant details, assistant, login
  widgets/     tiles, grids, details panels, drawer
  providers/   plant search (API) and user state
  models/      plant, plant details, collection plant
  database.dart              Realtime Database CRUD for collections
  notification_service.dart  watering reminders
  auth.dart                  Google Sign-In
```

## Running locally

Written in 2021 for Flutter 2 (Dart SDK `>=2.7.0 <3.0.0`, pre-null-safety),
so it needs a Flutter 2.x SDK to build as-is.

```bash
flutter pub get
flutter run            # or: flutter build apk
```

To use your own backend, create a Firebase project with Google sign-in,
Realtime Database and Storage enabled, replace
`android/app/google-services.json` with your project's file, and set your
FloraCodex API token in `lib/providers/plants.dart`.
