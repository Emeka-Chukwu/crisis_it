import 'package:create_it/src/view_model/audio.dart';
import 'package:create_it/src/view_model/crisis.dart';
import 'package:create_it/src/view_model/image_vm.dart';
import 'package:create_it/src/view_model/video.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user.dart';

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

final crisisProvider = ChangeNotifierProvider<CrisisProvider>((ref) {
  return CrisisProvider();
});
final audioProvider =
    ChangeNotifierProvider<AudioProvider>((ref) => AudioProvider());
final videoProvider =
    ChangeNotifierProvider<VideoProvider>((ref) => VideoProvider());

final imageProvider =
    ChangeNotifierProvider<ImagesProvider>((ref) => ImagesProvider());
