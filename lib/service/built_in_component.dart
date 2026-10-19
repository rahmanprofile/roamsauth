import 'package:flutter/material.dart';
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
                border: Border.all(color: _line),
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
                    child: const Icon(Icons.graphic_eq_outlined, color: _red, size: 48),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'RoamsAuth',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
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
                    child: const Text(
                      'Version ${RoamsVersion.version}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _muted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Developed by Coach Maintenance & Management Group, Centre for Railway Information Systems',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
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
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue with RoamsAuth',
                            style: TextStyle(
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
                  const Text(
                    'By continuing, RoamsAuth will receive ongoing access to the information you share and the settings you have.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: _muted,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: _line, height: 1),
                  const SizedBox(height: 16),
                  Text(
                    'Coach-Mitra | RailCare | CMM-Dashboard | Watering'.toUpperCase(),
                    style: TextStyle(fontSize: 13, color: _red),
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

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 22, color: BuiltInComponent._red),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: BuiltInComponent._muted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 1.35,
                    color: BuiltInComponent._dark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
