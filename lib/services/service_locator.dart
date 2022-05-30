import 'package:audio_service/audio_service.dart';
import 'package:get_it/get_it.dart';
import 'package:knihy_audio_app_new/services/api.dart';
import 'package:knihy_audio_app_new/services/audio_handler.dart';
import 'package:knihy_audio_app_new/services/audio_player_state.dart';
import 'package:knihy_audio_app_new/services/device_info.dart';
import 'package:knihy_audio_app_new/services/login_screen_state.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerSingleton<DeviceInfo>(DeviceInfo());
  getIt.registerSingleton<Api>(Api());
  getIt.registerSingleton<AudioHandler>(await initAudioService());
  getIt.registerSingleton<LoginScreenState>(LoginScreenState());
  getIt.registerSingleton<MyAudioPlayerState>(MyAudioPlayerState());
}