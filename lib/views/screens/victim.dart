import 'package:afet_yonetim/constants.dart';
import 'package:afet_yonetim/model/location.dart';
import 'package:afet_yonetim/services/provider/location.dart';
import 'package:afet_yonetim/services/provider/photo.dart';
import 'package:afet_yonetim/services/provider/storage.dart';
import 'package:afet_yonetim/values.dart';
import 'package:afet_yonetim/views/widgets/text_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/image/big_image.dart';

class VictimScreen extends ConsumerWidget {
  const VictimScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final formKey = GlobalKey<FormState>();
    final phoneNumberController = TextEditingController();
    final position = ref.watch(gnssLocationProvider);
    final photo = ref.watch(photoProvider);
    double latitude = 0;
    double longitude = 0;
    String photoUrl = "";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Yardım Talebi'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.kDefaultPadding),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (photo != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BigImageScreen(
                              file: ref.watch(photoProvider.notifier).state!,
                            ),
                          ),
                        ),
                        child: Hero(
                          tag: ref.watch(photoProvider.notifier).state!.path,
                          child: SizedBox(
                            width: double.infinity,
                            height: 200,
                            child: Image.file(
                              ref.watch(photoProvider.notifier).state!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        color: Theme.of(context).brightness == Brightness.light
                            ? kDefaultIconLightColor
                            : kDefaultIconDarkColor,
                        icon: const Icon(
                          Icons.close,
                          size: Constants.kDefaultPadding * 3,
                        ),
                        onPressed: () {
                          ref.read(photoProvider.notifier).state = null;
                        },
                      ),
                    ],
                  )
                else
                  GestureDetector(
                    onTap: () async {
                      try {
                        ref.refresh(photoSelectionProvider).value;
                        ref.read(photoProvider.notifier).state =
                            await ref.read(photoSelectionProvider.future);
                      } catch (ex) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              ex.toString(),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: 48,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: phoneNumberController,
                  label: const Text('Telefon Numarası'),
                  bottomPadding: Constants.kDefaultPadding,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  prefixIcon: const Icon(Icons.phone),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Lütfen telefon numaranızı giriniz..";
                    } else if (value.length < 10) {
                      return "Telefon numarası geçersiz. (Olması gerekenden kısa)";
                    } else if (value.length > 10) {
                      return "Telefon numarası geçersiz. (Olması gerekenden uzun)";
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                position.when(
                  data: (value) {
                    latitude = value.latitude;
                    longitude = value.longitude;
                    return Text(value.toString());
                  },
                  error: (err, s) => Text(err.toString()),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                const SizedBox(
                  height: Constants.kDefaultPadding,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Yükleniyor...",
                            ),
                          ),
                        );
                        if (photo != null) {
                          photoUrl =
                              await ref.read(fileUploadProvider(photo).future);
                        }
                        var model = LocationModel(
                          phoneNumber: phoneNumberController.text,
                          photo: photoUrl,
                          latitude: latitude,
                          longitude: longitude,
                          userID: currentUser!.id,
                        );
                        ref
                            .read(
                              locationSetProvider(model).future,
                            )
                            .then((value) =>
                                Navigator.popAndPushNamed(context, "/home"));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Yardım talebiniz başarıyla gönderildi",
                            ),
                          ),
                        );
                      } catch (ex) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              ex.toString(),
                            ),
                          ),
                        );
                      }
                    }
                  },
                  child: const Text("Gönder"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
