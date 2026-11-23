
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  static const Color teal = Color(0xFF087F78);
  static const Color tealLight = Color(0xFF1ABC9C);
  static const Color gold = Color(0xFFD6B36A);

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      await _authService.logout();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrasi berhasil! Silakan masuk.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = 'Email sudah terdaftar.';
          break;
        case 'invalid-email':
          message = 'Format email tidak valid.';
          break;
        case 'weak-password':
          message = 'Kata sandi terlalu lemah.';
          break;
        case 'network-request-failed':
          message = 'Periksa koneksi internet kamu.';
          break;
        default:
          message = 'Registrasi gagal: ${e.message ?? e.code}';
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
          behavior: SnackBarBehavior.floating,
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

  Widget _buildPasswordField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
    required bool isDark,
    required Color secondaryText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
            color: secondaryText,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          decoration: _inputDecoration(
            hint: hint,
            icon: Icons.lock_outline,
            isDark: isDark,
            suffixIcon: IconButton(
              onPressed: onToggle,
              icon: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
                color: secondaryText,
              ),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    required bool isDark,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: teal),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: isDark
          ? const Color(0xFF263330)
          : const Color(0xFFF4F8F7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0x1F087F78),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: tealLight,
          width: 1.5,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surface = theme.colorScheme.surface;
    final textColor = theme.colorScheme.onSurface;
    final secondaryText = theme.colorScheme.onSurfaceVariant;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
                          // HEADER BRANDING
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 25,
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
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    tooltip: 'Kembali',
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),

                                Container(
                                  width: 78,
                                  height: 78,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(23),
                                    border: Border.all(
                                      color: gold,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.school_rounded,
                                    size: 46,
                                    color: teal,
                                  ),
                                ),

                                const SizedBox(height: 17),

                                const Text(
                                  'STUDENT ID',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 27,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                Container(
                                  width: 48,
                                  height: 2,
                                  color: gold,
                                ),

                                const SizedBox(height: 12),

                                const Text(
                                  'IDENTITAS DIGITAL MAHASISWA',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFE0F2EF),
                                    fontSize: 10,
                                    letterSpacing: 1.3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 26),

                          // REGISTER CARD
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
                                    'Buat Akun Baru',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: textColor,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  Text(
                                    'Daftarkan akun untuk mulai menggunakan STUDENT ID.',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: secondaryText,
                                      height: 1.5,
                                    ),
                                  ),

                                  const SizedBox(height: 28),

                                  Text(
                                    'ALAMAT EMAIL',
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
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: _inputDecoration(
                                      hint: 'Masukkan alamat email',
                                      icon: Icons.email_outlined,
                                      isDark: isDark,
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

                                  _buildPasswordField(
                                    label: 'KATA SANDI',
                                    hint: 'Buat kata sandi',
                                    controller: _passwordController,
                                    obscure: _obscurePassword,
                                    isDark: isDark,
                                    secondaryText: secondaryText,
                                    onToggle: () {
                                      setState(() {
                                        _obscurePassword =
                                            !_obscurePassword;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Kata sandi tidak boleh kosong';
                                      }

                                      if (value.length < 6) {
                                        return 'Minimal 6 karakter';
                                      }

                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 22),

                                  _buildPasswordField(
                                    label: 'KONFIRMASI KATA SANDI',
                                    hint: 'Ulangi kata sandi',
                                    controller: _confirmPasswordController,
                                    obscure: _obscureConfirmPassword,
                                    isDark: isDark,
                                    secondaryText: secondaryText,
                                    onToggle: () {
                                      setState(() {
                                        _obscureConfirmPassword =
                                            !_obscureConfirmPassword;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Konfirmasi kata sandi wajib diisi';
                                      }

                                      if (value != _passwordController.text) {
                                        return 'Kata sandi tidak sama';
                                      }

                                      return null;
                                    },
                                  ),

                                  const SizedBox(height: 28),

                                  SizedBox(
                                    height: 54,
                                    child: ElevatedButton(
                                      onPressed:
                                          _isLoading ? null : _register,
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
                                                  'DAFTAR SEKARANG',
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

                                  const SizedBox(height: 18),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Sudah punya akun?',
                                          style: TextStyle(
                                            color: secondaryText,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: _isLoading
                                            ? null
                                            : () => Navigator.pop(context),
                                        child: const Text(
                                          'Masuk di sini',
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
