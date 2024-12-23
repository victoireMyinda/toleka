import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonTransAcademia extends StatefulWidget {
  const ButtonTransAcademia({super.key, this.title, this.width});
  final String? title;
  final double? width;

  @override
  State<ButtonTransAcademia> createState() => _ButtonTransAcademiaState();
}

class _ButtonTransAcademiaState extends State<ButtonTransAcademia> {
  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 50.0,
      width: widget.width ?? MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color:  Color(0xff225e7b),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          widget.title.toString(),
          style: GoogleFonts.montserrat(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
