import 'package:afet_yonetim/services/api/auth.dart';
import 'package:afet_yonetim/model/user.dart';
import 'package:afet_yonetim/services/provider/user.dart';
import 'package:afet_yonetim/values.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = Provider<AuthAPI>((ref) => AuthAPI());

final loginProvider = FutureProvider.autoDispose
    .family<UserModel, List<dynamic>>((ref, args) async {
  currentUser = await ref.watch(authProvider).login(args[0], args[1]);
  ref.read(objectBoxServiceProvider).addUser(currentUser!);
  return currentUser!;
});

final registerProvider = FutureProvider.autoDispose
    .family<UserModel, List<dynamic>>((ref, args) async {
  currentUser = UserModel(
      idNumber: args[0], name: args[1], surname: args[2], birthYear: args[3]);
  ref.read(objectBoxServiceProvider).addUser(currentUser!);
  return await ref
      .watch(authProvider)
      .register(args[0], args[1], args[2], args[3]);
});
