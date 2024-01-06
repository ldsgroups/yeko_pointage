import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:yeko_pointage/core/core.dart';
import 'package:yeko_pointage/features/auth/controllers/auth_controller.dart';
import 'package:yeko_pointage/features/home/views/home_view.dart';
import 'package:yeko_pointage/features/setting/views/views.dart';

class ScanPage extends StatefulHookConsumerWidget {
  const ScanPage({super.key});

  static MaterialPageRoute<ScanPage> route() => MaterialPageRoute<ScanPage>(
        builder: (context) => const ScanPage(),
      );

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  late MobileScannerController cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController(autoStart: false);
    restartScan();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> restartScan() async {
    await cameraController.stop();
    await cameraController.start();
  }

  @override
  Widget build(BuildContext context) {
    final isScanning = useState(true);

    final size = MediaQuery.of(context).size;
    final isTablet = size.width > size.height;

    Future<void> handleGetSchool(String schoolId) async {
      final authCtrl = ref.read(authControllerProvider.notifier);
      final response = await authCtrl.getSchool(schoolId: schoolId);
      print('=======================');
      print(schoolId);

      if (response != null) {
        if (context.mounted) {
          await Navigator.pushAndRemoveUntil(
            context,
            SettingPage.route(school: response),
            (route) => false,
          );
        }
      } else {
        if (context.mounted) {
          await Navigator.pushAndRemoveUntil(
            context,
            ScanPage.route(),
            (route) => false,
          );
        }
      }
    }

    Future<void> onDetect(Barcode barcode) async {
      isScanning.value = false;
      // make bip sound
      await AssetsAudioPlayer.newPlayer().open(Audio(AssetConstants.beepSound));

      //?: teacher/school--id--fullName
      //?: school--03f011f4-c8e4-4a2e-8093-f6119026a9fd--Collège Celeste Adjoufou
      final data = barcode.rawValue?.split('--');

      // close camera
      await cameraController.stop();

      if (data?[0] == 'school') {
        await handleGetSchool(data![1]);
      } else {
        if (context.mounted) {
          await Navigator.pushAndRemoveUntil(
            context,
            HomePage.route(),
            (route) => false,
          );
        }
      }
    }

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            // Logo part
            SizedBox(
              width: isTablet ? size.width * 0.3 : size.width * 0.5,
              child: Image.asset(
                AssetConstants.appLogoLight,
                fit: BoxFit.cover,
              ),
            ),

            // Scan Part
            SizedBox(
              width: isTablet ? size.width * 0.3 : size.width * 0.65,
              height: isTablet ? size.width * 0.3 : size.width * 0.65,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: isScanning.value
                    ? MobileScanner(
                        controller: cameraController,
                        onDetect: (capture) {
                          final barcodes = capture.barcodes;

                          if (barcodes.isNotEmpty) {
                            onDetect(barcodes.last);
                          }
                        },
                      )
                    : const Card(
                        child: Center(child: CircularProgressIndicator()),
                      ),
              ),
            ),
            const Spacer(flex: 3),

            ElevatedButton(
              onPressed: () async {
                await restartScan();
                isScanning.value = true;
              },
              child: const Text('Relancer le scan'),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}
