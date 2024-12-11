import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeCard extends StatelessWidget {
  final String text;
  final IconData icon;

  const HomeCard({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: const Color(0Xff6bb6e2),),
            const SizedBox(height: 8),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
  }
}