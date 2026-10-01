# Playground Booking - Frontend

Mobile app for booking indoor playground courts (netball, cricket, tennis, etc.), built with
Flutter and the BLoC pattern (`Event` → `Bloc` → `State`), talking to the FastAPI backend in
the sibling `playground-booking-backend` project.

## Stack
- **Flutter** (Dart)
- **flutter_bloc** — state management, full `Bloc<Event, State>` pattern throughout
- **equatable** — value equality for states/events
- **http** — API calls
- **shared_preferences** — JWT persistence across app restarts
- **intl** — date/time formatting
- **payhere_mobilesdk_flutter** — native PayHere checkout

## Prerequisites
- Flutter SDK (stable channel)
- The backend running and reachable (see `playground-booking-backend/README.md`)
- A PayHere sandbox Merchant ID + Secret configured on the backend

## Setup

```bash
flutter pub get
```

Point the app at your backend in `lib/core/api_config.dart`:

```dart
class ApiConfig {
  static const String baseUrl = "http://10.0.2.2:8000"; // Android emulator -> host localhost
  // static const String baseUrl = "http://192.168.x.x:8000"; // physical device on same Wi-Fi
  // static const String baseUrl = "https://your-deployed-backend.example.com"; // production
}
```

> `10.0.2.2` only works on the **Android emulator**. A physical device needs your machine's actual LAN IP; iOS simulator can use `localhost` directly.

Run it:

```bash
flutter run
```

### Android: PayHere manifest conflict

If you hit a manifest-merger error mentioning `application@label` conflicting with the
PayHere SDK, add `tools:replace="android:label"` to the `<application>` tag in
`android/app/src/main/AndroidManifest.xml` (and the `xmlns:tools` namespace on `<manifest>`
if it's missing). Then `flutter clean && flutter pub get`.
