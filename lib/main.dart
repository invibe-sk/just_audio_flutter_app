import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:knihy_audio_app_new/screens/loading.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/service_locator.dart';
import 'package:knihy_audio_app_new/services/app_lifecycle_watcher.dart';
import 'package:knihy_audio_app_new/services/routes.dart';
import 'package:knihy_audio_app_new/services/theme_data.dart';
import 'package:sentry_flutter/sentry_flutter.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  await Hive.initFlutter();
  await Hive.openBox('books');

  await SentryFlutter.init(
        (options) {
      options.dsn = 'https://28cda0d2ed6043d7bb6d02ce207a2319@o1125131.ingest.sentry.io/6164317';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const AppLifecycleWatcher(child: MyApp())),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final myAudioPlayerState = getIt<MyAudioPlayerState>();

  @override
  initState() {
    super.initState();
    myAudioPlayerState.init();
    // Provider.of<AudioPlayerState>(context, listen: false).initAudioServices();
  }

  @override
  dispose() {
    myAudioPlayerState.dispose();
    super.dispose();
    // Provider.of<AudioPlayerState>(context, listen: false).initAudioServices();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeData.get(),
      routes: Routes.get(),
      initialRoute: LoadingScreen.routeName,
    );
  }
}
