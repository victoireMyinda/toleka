import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class TransAcademiaDialogSuccess {
  static stop(BuildContext context){
    Navigator.of(context).pop();
  }
  
  static show(BuildContext context , String? text, String? title) {
    showDialog<void>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 7.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AdaptiveTheme.of(context).mode.name == "dark"
                                  ? Colors.black
                                  : Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Lottie.asset('assets/images/success-trans.json',
                                height: 100),
                                 Text(text.toString(),textAlign: TextAlign.center, style: const TextStyle(fontSize: 16 ),),
                                 const SizedBox(height: 20,)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
        });
  }
}
