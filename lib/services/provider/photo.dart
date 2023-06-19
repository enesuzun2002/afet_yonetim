import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final photoProvider = StateProvider<File?>((ref) => null);

final photoSelectionProvider = FutureProvider<File>(
  (ref) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw Exception('Fotoğraf seçilemedi');
    }
  },
);
