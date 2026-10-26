import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:roamsauth/generic/version.dart';

class BuiltInComponent extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onRefresh;

  const BuiltInComponent({
    super.key,
    required this.onLogin,
    required this.onRefresh,
  });

  static const Color _red = Color(0XFFEE0000);
  static const Color _dark = Color(0xFF151515);
  static const Color _muted = Color(0xFF6A6E73);
  static const Color _line = Color(0xFFE6E8EB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(36, 44, 36, 28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 32,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 84,
                    height: 84,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFDECEC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.recommend, color: _red, size: 48),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'RoamsAuth',
                    style: GoogleFonts.roboto(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      color: _dark,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F3F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Version ${RoamsVersion.version}',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _muted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Developed by Coach Maintenance & Management Group, Centre for Railway Information Systems',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      height: 1.5,
                      color: _muted,
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: onLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _red,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue with RoamsAuth',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.arrow_forward, size: 18),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'By continuing, RoamsAuth will receive ongoing access to the information you share and the settings you have.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      height: 1.5,
                      color: _muted,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: _line, height: 1),
                  const SizedBox(height: 16),
                  Text(
                    'Coach-Mitra | RailCare | CMM-Dashboard | Watering'.toUpperCase(),
                    style: GoogleFonts.roboto(fontSize: 11.5, color: _red),
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