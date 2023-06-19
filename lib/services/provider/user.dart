import 'package:afet_yonetim/model/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../objectbox.dart';

final objectBoxServiceProvider =
    Provider<ObjectBoxService>((ref) => ObjectBoxService());

final userProvider = FutureProvider<UserModel?>((ref) async {
  final service = ref.watch(objectBoxServiceProvider);
  await service.init();
  return await service.getUser();
});
