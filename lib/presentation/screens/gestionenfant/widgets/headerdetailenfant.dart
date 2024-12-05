// ignore_for_file: unnecessary_const, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/theme.dart';

class HeaderDetailEnfant extends StatefulWidget {
  final String? image;
  final Map? data;
  final bool? backNavigation;

  const HeaderDetailEnfant(
      {super.key, this.image, this.data, this.backNavigation});

  @override
  State<HeaderDetailEnfant> createState() => _HeaderDetailEnfantState();
}

class _HeaderDetailEnfantState extends State<HeaderDetailEnfant> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff129BFF),
            kelasiColor,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          AppBarKelasi(
            color: Colors.white,
            title: "Détail Enfant",
            icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            onTapFunction: () {
              Navigator.of(context).pop();
            },
            visibleAvatar: false,
          ),
          // const SizedBox(height: 20),
          // SvgPicture.asset(
          //   "assets/icons/avatarkelasi.svg",
          //   width: 70,
          //   color: Colors.white,
          // ),
          SizedBox(
            height: 10,
          ),
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return Text(
                "${widget.data!["nom"]} ${widget.data!["postnom"]} ${widget.data!["prenom"]}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              );
            },
          ),
          // const SizedBox(height: 10),
          // Text(
          //   "Ecole ${widget.data!["school"]}",
          //   style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200),
          // ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Abonnement en cours : ",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    widget.data!["types_abonnement"] == null
                        ? "Pas d'abonnement" 
                        : "${widget.data!["types_abonnement"]}",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              const Text("|",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400)),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    "Date d'expiration",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    widget.data!["types_abonnement"] == null
                        ? "Pas d'abonnement" 
                        : "${widget.data!["expiration_abonnement"]}",
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
