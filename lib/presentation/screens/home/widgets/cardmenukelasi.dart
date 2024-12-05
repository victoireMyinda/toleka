import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toleka/presentation/screens/abonnement/abonnementkelasi.dart';
import 'package:toleka/presentation/screens/abonnement/historiquetransanction/historiquepaiement.dart';
import 'package:toleka/presentation/screens/gestionenfant/enfantactif.dart';
import 'package:toleka/presentation/screens/gestionenfant/enfantnonacif.dart';
import 'package:toleka/presentation/screens/gestionenfant/signupenfant/contactencadreur.dart';
import 'package:toleka/presentation/screens/localisation/localisation.dart';
import 'package:toleka/presentation/screens/personneref/listepersonneref.dart';
import 'package:toleka/presentation/screens/profileparent/settingparent.dart';
import 'package:toast/toast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toleka/theme.dart';

class CardMenuKelasi extends StatefulWidget {
  String? icon;
  String? title;
  CardMenuKelasi({super.key, this.icon, this.title});

  @override
  State<CardMenuKelasi> createState() => _CardMenuKelasiState();
}

class _CardMenuKelasiState extends State<CardMenuKelasi> {
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return InkWell(
      onTap: () {
        if (widget.title == "Partager l'app") {
          Share.share(
              'Télécharger l\'application Trans-academia \nAndroid : https://play.google.com/store/apps/details?id=com.tac.kelasi&hl=fr&gl=US \n IOS : https://itunes.apple.com/cd/app/id6447296971?mt=8');
        } else if (widget.title == "Abonnement") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AbonnementKelasi(backNavigation: false)),
          );
        } else if (widget.title == "Enfants enregistrés") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EnfantsInactifs(
                      backNavigation: true,
                      fromSingup: false,
                    )),
          );
        } else if (widget.title == "Enfants liés") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EnfantActifs(
                      backNavigation: true,
                    )),
          );
        } else if (widget.title == "Personne de ref.") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PersonneDeReference()),
          );
        } else if (widget.title == "historique payement") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoriqueTransanction(
                      backNavigation: true,
                      fromSingup: false,
                    )),
          );
        } else if (widget.title == "Profil") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const SettingParent(backNavigation: true)),
          );
        } else if (widget.title == "Contacter encadreur") {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ContactEncadreurScreen()),
          );
        } else {
          showToast("Bientôt disponible", duration: 3, gravity: Toast.bottom);
        }
      },
      child: Container(
        height: 90.0,
        width: 95.0,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          // color: Colors.white,
          color: Theme.of(context).colorScheme.secondary,

          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.icon.toString(),
              width: 24,
              color: kelasiColor,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.title.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}
