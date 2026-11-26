import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FcmTokenCard extends StatefulWidget {
  const FcmTokenCard({super.key});

  @override
  State<FcmTokenCard> createState() => _FcmTokenCardState();
}

class _FcmTokenCardState extends State<FcmTokenCard> {
  String? token;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    try {
      // ignore: deprecated_member_use
      final result = await FirebaseMessaging.instance.getToken();

      if (!mounted) return;

      setState(() {
        token = result;
        isLoading = false;
        errorMessage = result == null
            ? 'FCM Token tidak tersedia'
            : null;
      });
    } catch (e) {
      debugPrint('[FCM CARD] Gagal mengambil token: $e');

      if (!mounted) return;

      setState(() {
        isLoading = false;
        errorMessage = 'Gagal mengambil FCM Token';
      });
    }
  }

  Future<void> _copyToken() async {
    if (token == null || token!.isEmpty) return;

    await Clipboard.setData(
      ClipboardData(text: token!),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('FCM Token berhasil disalin!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FCM Token:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (token == null)
              Text(errorMessage ?? 'FCM Token tidak tersedia')
            else
              SelectableText(
                token!,
                style: const TextStyle(fontSize: 12),
              ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: token == null ? null : _copyToken,
              icon: const Icon(Icons.copy),
              label: const Text('Salin Token'),
            ),
          ],
        ),
      ),
    );
  }
}
