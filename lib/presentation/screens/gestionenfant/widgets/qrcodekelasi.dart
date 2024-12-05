// ignore_for_file: must_be_immutable

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:custom_qr_generator/custom_qr_generator.dart';
import 'package:flutter/material.dart';
import 'package:toleka/theme.dart';

class QrCodeKelasi extends StatefulWidget {
  String? content;
  QrCodeKelasi({Key? key, required this.content}) : super(key: key);

  @override
  State<QrCodeKelasi> createState() => _QrCodeKelasiState();
}

class _QrCodeKelasiState extends State<QrCodeKelasi> {
  String? codeStudent = '';
  var test;

  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // var image = Image.asset();
  @override
  Widget build(BuildContext context) {
    return Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              painter: QrPainter(
                data: widget.content.toString(),
                options: QrOptions(
                  shapes: const QrShapes(
                    darkPixel: QrPixelShapeRoundCorners(cornerFraction: .5),
                    frame: QrFrameShapeRoundCorners(cornerFraction: .50),
                    ball: QrBallShapeRoundCorners(cornerFraction: .50),
                  ),
                  colors: QrColors(
                    background: QrColorSolid(
                      AdaptiveTheme.of(context).mode.name == "dark"
                          ? Colors.black
                          : Colors.white,
                    ),
                    dark: QrColorLinearGradient(
                      colors: [
                        const Color(0xff129BFF),
                        kelasiColor,
                      ],
                      orientation: GradientOrientation.leftDiagonal,
                    ),
                  ),
                ),
              ),
              size: const Size(350, 350),
            ),
            // Image.asset(
            //   AdaptiveTheme.of(context).mode.name != "dark"
            //       ? "assets/images/logo-kelasi.png"
            //       : "assets/images/logo-kelasi.png",
            //   width: 40, // Ajustez la largeur selon vos besoins
            //   height: 40, // Ajustez la hauteur selon vos besoins
            // ),
          ],
        );
  }
}
