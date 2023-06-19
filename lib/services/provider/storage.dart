import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants.dart';

final fileUploadProvider =
    FutureProvider.autoDispose.family<String, File>((ref, file) async {
  final storageRef = Constants.storage
      .ref()
      .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

  final uploadTask = storageRef.putFile(file);
  final snapshot = await uploadTask.whenComplete(() {});

  if (snapshot.state == TaskState.success) {
    final downloadUrl = await storageRef.getDownloadURL();
    return downloadUrl;
  } else {
    throw Exception('Dosya yüklenemedi');
  }
});
