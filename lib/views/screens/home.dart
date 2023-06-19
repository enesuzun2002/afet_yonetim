import 'package:afet_yonetim/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Afet Yönetim"),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.kDefaultPadding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/victim"),
                child: const Text("Afetzedeyim"),
              ),
              const SizedBox(
                height: Constants.kDefaultPadding,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, "/volunteer"),
                child: const Text("Gönüllüyüm"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
