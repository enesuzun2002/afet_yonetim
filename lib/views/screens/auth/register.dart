import 'package:afet_yonetim/services/provider/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants.dart';
import '../../widgets/text_field/custom_text_form_field.dart';

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final formKey = GlobalKey<FormState>();
    final tcController = TextEditingController();
    final nameController = TextEditingController();
    final surnameController = TextEditingController();
    final yearController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Constants.kDefaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                controller: tcController,
                bottomPadding: Constants.kDefaultPadding,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                label: const Text("TC Kimlik No"),
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.person_2_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen TC kimlik numaranızı girin.";
                  } else if (value.length < 11) {
                    return "TC kimlik numarası geçersiz. (Olması gerekenden kısa)";
                  } else if (value.length > 11) {
                    return "TC kimlik numarası geçersiz. (Olması gerekenden uzun)";
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                controller: nameController,
                bottomPadding: Constants.kDefaultPadding,
                label: const Text("Ad"),
                prefixIcon: const Icon(Icons.abc_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen adınızı giriniz";
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                controller: surnameController,
                bottomPadding: Constants.kDefaultPadding,
                label: const Text("Soyad"),
                prefixIcon: const Icon(Icons.abc_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen soyadınızı giriniz";
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                controller: yearController,
                bottomPadding: Constants.kDefaultPadding,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                label: const Text("Doğum Yılı"),
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.numbers_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen doğum yılınızı girin.";
                  } else if (int.parse(value) < DateTime.now().year - 100 ||
                      int.parse(value) > DateTime.now().year) {
                    return "Lütfen geçerli bir doğum yılı giriniz.";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Yükleniyor...",
                          ),
                        ),
                      );
                      ref
                          .read(
                            registerProvider(
                              [
                                int.parse(tcController.text),
                                nameController.text,
                                surnameController.text,
                                yearController.text,
                              ],
                            ).future,
                          )
                          .then((value) =>
                              Navigator.popAndPushNamed(context, "/home"));
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
                child: const Text("Kayıt"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Zaten bir hesabınız var mı?"),
                  TextButton(
                    onPressed: () {
                      // Navigate to login screen
                      Navigator.popAndPushNamed(
                        context,
                        "/login",
                      );
                    },
                    child: const Text("Giriş yap"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
