import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../utils/profile_data.dart';
import 'login_page.dart';
import 'profile_page.dart';

class SplashScreen extends StatefulWidget {
  final ValueChanged<bool> onToggleTheme;

  const SplashScreen({
    super.key,
    required this.onToggleTheme,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Memberikan waktu agar SplashScreen terlihat.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final user = _authService.currentUser;

    if (user != null) {
      final profile = createStudentProfile(user.email ?? '');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            profile: profile,
            onToggleTheme: widget.onToggleTheme,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(
            onToggleTheme: widget.onToggleTheme,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.teal.shade700,
              Colors.teal.shade400,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  size: 65,
                  color: Colors.teal,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'PROFIL MAHASISWA',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Aplikasi Informasi Profil Mahasiswa',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 45),

              const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),

              const SizedBox(height: 15),

              const Text(
                'Memuat aplikasi...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
