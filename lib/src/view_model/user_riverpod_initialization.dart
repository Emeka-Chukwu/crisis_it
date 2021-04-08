import 'package:create_it/src/view_model/crisis.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user.dart';

final userProvider =
    ChangeNotifierProvider<UserProvider>((ref) => UserProvider());

final crisisProvider = ChangeNotifierProvider<CrisisProvider>((ref) {
  return CrisisProvider();
});
