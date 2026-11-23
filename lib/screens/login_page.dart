
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'register_page.dart';
import 'profile_page.dart';

import '../services/auth_service.dart';
import '../utils/profile_data.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<bool> onToggleTheme;

  const LoginPage({
    super.key,
    required this.onToggleTheme,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final credential = await _authService.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      final user = credential.user;

      if (user == null) {
        throw Exception('Data pengguna tidak ditemukan.');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil! Selamat datang.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 2),
        ),
      );

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
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message;

      switch (e.code) {
        case 'invalid-credential':
        case 'wrong-password':
        case 'user-not-found':
          message = 'Email atau password salah.';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid.';
          break;
        case 'user-disabled':
          message = 'Akun ini telah dinonaktifkan.';
          break;
        case 'too-many-requests':
          message = 'Terlalu banyak percobaan. Coba lagi nanti.';
          break;
        case 'network-request-failed':
          message = 'Periksa koneksi internet kamu.';
          break;
        default:
          message = 'Login gagal: ${e.message ?? e.code}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final background = theme.scaffoldBackgroundColor;
    final surface = theme.colorScheme.surface;
    final textColor = theme.colorScheme.onSurface;
    final secondaryText = theme.colorScheme.onSurfaceVariant;

    const teal = Color(0xFF087F78);
    const tealLight = Color(0xFF1ABC9C);
    const gold = Color(0xFFD6B36A);

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 28,
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 440,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // BRANDING HEADER
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 30,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  teal,
                                  Color(0xFF075E59),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(26),
                              boxShadow: [
                                BoxShadow(
                                  color: teal.withValues(alpha: 0.22),
                                  blurRadius: 24,
                                  offset: const Offset(0, 12),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        widget.onToggleTheme(!isDark);
                                      },
                                      icon: Icon(
                                        isDark
                                            ? Icons.light_mode_outlined
                                            : Icons.dark_mode_outlined,
                                        color: Colors.white,
                                      ),
                                      tooltip: 'Ganti tema',
                                    ),
                                  ],
                                ),

                                Container(
                                  width: 82,
                                  height: 82,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(24),
                                    border: Border.all(
                                      color: gold,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.school_rounded,
                                    size: 48,
                                    color: teal,
                                  ),
                                ),

                                const SizedBox(height: 20),

                                const Text(
                                  'STUDENT ID',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Container(
                                  width: 48,
                                  height: 2,
                                  color: gold,
                                ),

                                const SizedBox(height: 12),

                                const Text(
                                  'IDETITAS DIGITAL MAHASISWA',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFE0F2EF),
                                    fontSize: 10,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 26),

                          // LOGIN CARD
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(26),
                            decoration: BoxDecoration(
                              color: surface,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: theme.dividerColor.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(
                                    alpha: isDark ? 0.12 : 0.045,
                                  ),
                                  blurRadius: 24,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Selamat Datang',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    'Masuk ke akun Anda untuk mengakses identitas mahasiswa.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: secondaryText,
                                      height: 1.5,
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  // EMAIL
                                  Text(
                                    'EMAIL',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: secondaryText,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType:
                                        TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan email Anda',
                                      prefixIcon: const Icon(
                                        Icons.email_outlined,
                                        color: teal,
                                      ),
                                      filled: true,
                                      fillColor: isDark
                                          ? theme.colorScheme
                                              .surfaceContainerHighest
                                          : const Color(0xFFF4F8F7),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                        borderSide: BorderSide(
                                          color: theme.dividerColor
                                              .withValues(alpha: 0.2),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: tealLight,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Email tidak boleh kosong';
                                      }

                                      if (!RegExp(
                                        r'^[^@]+@[^@]+\.[^@]+$',
                                      ).hasMatch(value.trim())) {
                                        return 'Format email tidak valid';
                                      }

                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 22),

                                  // PASSWORD
                                  Text(
                                    'PASSWORD',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      color: secondaryText,
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    decoration: InputDecoration(
                                      hintText: 'Masukkan password',
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: teal,
                                      ),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscurePassword =
                                                !_obscurePassword;
                                          });
                                        },
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: secondaryText,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: isDark
                                          ? theme.colorScheme
                                              .surfaceContainerHighest
                                          : const Color(0xFFF4F8F7),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                        borderSide: BorderSide.none,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                        borderSide: BorderSide(
                                          color: theme.dividerColor
                                              .withValues(alpha: 0.2),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: tealLight,
                                          width: 1.5,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          value.isEmpty) {
                                        return 'Password tidak boleh kosong';
                                      }

                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 28),

                                  // LOGIN BUTTON
                                  SizedBox(
                                    height: 54,
                                    child: ElevatedButton(
                                      onPressed:
                                          _isLoading ? null : _login,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: teal,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      child: _isLoading
                                          ? const SizedBox(
                                              width: 23,
                                              height: 23,
                                              child:
                                                  CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                          : const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'MASUK SEKARANG',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                Icon(
                                                  Icons.arrow_forward,
                                                  size: 19,
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),

                                  const SizedBox(height: 22),

                                  // REGISTER
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Belum punya akun?',
                                          style: TextStyle(
                                            color: secondaryText,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Daftar di sini',
                                          style: TextStyle(
                                            color: tealLight,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          // FOOTER
                          Text(
                            'STUDENT ID',
                            style: TextStyle(
                              color: secondaryText,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontSize: 11,
                            ),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            'Created by RyutaDev',
                            style: TextStyle(
                              color: secondaryText,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
