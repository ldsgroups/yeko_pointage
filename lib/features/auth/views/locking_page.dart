import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:yeko_pointage/core/constants/constants.dart';

class LockingPage extends StatelessWidget {
  const LockingPage({super.key});

  static MaterialPageRoute<LockingPage> route() =>
      MaterialPageRoute<LockingPage>(
        builder: (context) => const LockingPage(),
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > size.height;
    const logo = AssetConstants.appLogoLight;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Logo part
                SizedBox(
                  width: isTablet ? size.width * 0.3 : size.width * 0.5,
                  child: Image.asset(logo, fit: BoxFit.cover),
                ),

                // Form part
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orangeAccent, width: 4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      QrImageView(
                        data: 'Bonjour Darius',
                        size: 270,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
