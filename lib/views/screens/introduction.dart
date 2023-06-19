import 'package:flutter/material.dart';

class IntroductionScreen extends StatelessWidget {
  const IntroductionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
            const Text(
              'Afet Yönetim Uygulamasına Hoş Geldiniz',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Afet ve acil durumları etkili bir şekilde yönetmek için çözümünüz.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 56),
            ElevatedButton(
              child: const Text('Giriş'),
              onPressed: () {
                // Navigate to the Login screen
                Navigator.pushNamed(
                  context,
                  "/login",
                );
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Kayıt'),
              onPressed: () {
                // Navigate to the Register screen
                Navigator.popAndPushNamed(
                  context,
                  "/register",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
