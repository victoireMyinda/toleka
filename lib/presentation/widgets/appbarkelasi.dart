import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toleka/presentation/screens/profileparent/settingparent.dart';
import 'package:toleka/theme.dart';

class AppBarKelasi extends StatefulWidget implements PreferredSizeWidget {
  final Color? color, backgroundColor;
  final IconData? icon; // Remplace `leftIcon` par `icon`
  final double? iconSize; // Renommé pour une meilleure clarté
  final String title;
  final bool? visibleAvatar;
  final VoidCallback? onTapFunction;

  const AppBarKelasi({
    Key? key,
    this.color,
    this.icon, // Utilisation de `IconData` pour l'icône
    required this.title,
    this.onTapFunction,
    this.iconSize,
    this.backgroundColor,
    this.visibleAvatar,
  }) : super(key: key);

  @override
  _AppBarKelasiState createState() => _AppBarKelasiState();

  @override
  Size get preferredSize => Size.fromHeight(60.0); // Ajustez la hauteur selon vos besoins
}

class _AppBarKelasiState extends State<AppBarKelasi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.icon != null // Vérifier si une icône a été passée
              ? IconButton(
                  icon: Icon(
                    widget.icon,
                    size: 26, // Utilisation de `iconSize`
                    color: widget.color ?? kelasiColor,
                  ),
                  onPressed: widget.onTapFunction,
                )
              : Container(), // Afficher un conteneur vide si aucune icône n'est passée
          Text(
            widget.title,
            style: TextStyle(
              color: widget.color ?? kelasiColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          widget.visibleAvatar == false
              ? Container()
              : GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingParent(
                          backNavigation: true,
                        ),
                      ),
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/icons/avatarkelasi.svg",
                    width: 40,
                    color: widget.color,
                  ),
                ),
        ],
      ),
    );
  }
}
