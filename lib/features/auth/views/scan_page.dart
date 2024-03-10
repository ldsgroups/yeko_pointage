import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:yeko_pointage/commons/commons.dart';
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
    cameraController = MobileScannerController(
      autoStart: false,
      detectionTimeoutMs: 1250,
    );
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
    const teacherName = 'Ibrahim Koné';
    final isScanning = useState(true);

    final size = MediaQuery.of(context).size;
    final isTablet = size.width > size.height;

    Future<void> handleGetSchool(String schoolId) async {
      final authCtrl = ref.read(authControllerProvider.notifier);
      final response = await authCtrl.getSchool(schoolId: schoolId);

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
          await AppUtils.infoDialog(
            onPressed: () async {
              Navigator.of(context).pop();

              await Navigator.pushAndRemoveUntil(
                context,
                ScanPage.route(),
                (route) => false,
              );
            },
            context: context,
            text: 'Nous ne reconnaissons pas cette école.',
          );
        }
      }
    }

    Future<void> onDetect(List<Barcode> barcodes) async {
      isScanning.value = false;
      // make bip sound
      await AssetsAudioPlayer.newPlayer().open(Audio(AssetConstants.beepSound));

      //?: teacher/school--id--fullName
      final data = barcodes[0].rawValue?.split('--');

      if (data?[0] == 'school') {
        await handleGetSchool(data![1]);
      } else if (data?[0] == 'teacher') {
        if (PreferenceUtils.getString(PrefConst.classId).isNotEmpty) {
          if (!context.mounted) return;
          return AppUtils.infoDialog(
            context: context,
            child: Column(
              children: [
                Text('Akwaba M. $teacherName'.toUpperCase()),
                Text(
                  'Prof de Maths'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                colDivider,
                buildTeacherSpecification('Classe', '5ème 2'),
                buildTeacherSpecification('Timing', '10h15 - 12h00'),
              ],
            ),
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              HomePage.route(),
              (route) => false,
            ),
          );
        } else {
          if (context.mounted) {
            await AppUtils.infoDialog(
              onPressed: () async {
                Navigator.of(context).pop();

                await Navigator.pushAndRemoveUntil(
                  context,
                  ScanPage.route(),
                  (route) => false,
                );
              },
              context: context,
              text:
                  "Veillez contacter l'administration pour assigner d'abord la tablette à la classe",
            );
          }
        }
      } else {
        await restartScan();
        isScanning.value = true;

        if (context.mounted) {
          AppUtils.showSnackBar(
            context,
            'Oups, nous ne vous reconnaissons pas',
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
                            onDetect(barcodes);
                          }
                        },
                      )
                    : const Card(
                        child: Center(child: CircularProgressIndicator()),
                      ),
              ),
            ),
            largeColDivider,
            SizedBox(
              width: size.width * 0.8,
              child: Text(
                'Veuillez scanner votre QR Code pour vous identifier'
                    .toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Spacer(flex: 3),

            ElevatedButton(
              onPressed: () async {
                return AppUtils.infoDialog(
                  context: context,
                  child: Column(
                    children: [
                      Text('Akwaba M. $teacherName'.toUpperCase()),
                      Text(
                        'Prof de Math'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      colDivider,
                      buildTeacherSpecification('Classe', '5ème 2'),
                      buildTeacherSpecification('Timing', '10h15 - 12h00'),
                    ],
                  ),
                  onPressed: () => Navigator.pop(context),
                );
                // await restartScan();
                // isScanning.value = true;
              },
              child: const Text('Relancer le scan'),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Row buildTeacherSpecification(String leftText, String rightText) {
    const textTheme = TextStyle(fontWeight: FontWeight.w700);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          leftText.toUpperCase(),
          style: textTheme.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Text(
          ': $rightText'.toUpperCase(),
          style: textTheme,
        ),
      ],
    );
  }
}
