
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

  static const Color teal = Color(0xFF087F78);
  static const Color tealDark = Color(0xFF075E59);
  static const Color gold = Color(0xFFD6B36A);

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final user = _authService.currentUser;

    if (user != null) {
      final profile = createStudentProfile(
        user.email ?? '',
      );

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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              teal,
              tealDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // LOGO STUDENT ID
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      border: Border.all(
                        color: gold,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(
                            alpha: 0.12,
                          ),
                          blurRadius: 22,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      size: 55,
                      color: teal,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // BRAND NAME
                  const Text(
                    'STUDENT ID',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 29,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),

                  const SizedBox(height: 13),

                  // GOLD ACCENT
                  Container(
                    width: 52,
                    height: 2,
                    decoration: BoxDecoration(
                      color: gold,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  const SizedBox(height: 14),

                  // TAGLINE
                  const Text(
                    'IDENTITAS DIGITAL MAHASISWA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE0F2EF),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),

                  const SizedBox(height: 65),

                  // LOADING
                  const SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'Menyiapkan Aplikasi...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 75),

                  // FOOTER
                  const Text(
                    'Created by RyutaDev',
                    style: TextStyle(
                      color: gold,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
