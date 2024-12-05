// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/screens/gestionenfant/updateenfant/updateenfant.dart';
import 'package:toleka/presentation/screens/gestionenfant/widgets/carddetailenfant.dart';
import 'package:toleka/presentation/screens/gestionenfant/widgets/headerdetailenfant.dart';
import 'package:toleka/presentation/screens/gestionenfant/widgets/qrcodekelasi.dart';

class DetailEnfant extends StatefulWidget {
  final Map? data;
  const DetailEnfant({super.key, this.data});

  @override
  State<DetailEnfant> createState() => _DetailEnfantState();
}

class _DetailEnfantState extends State<DetailEnfant> {
  String image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgXTbddKsgVA1ETOzRz4Kz9Ap-JtAZfCGGXA&usqp=CAU";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadServicesKelasi();
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "idStudent", data: "");
  }

  @override
  Widget build(BuildContext context) {
    double widthAll = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        // appBar: AppBarKelasi(
        //   backgroundColor: Colors.white,
        //   title: "Enfants liés",
        //   icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
        //   onTapFunction: () => Navigator.of(context).pop(),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderDetailEnfant(
                image: image,
                data: widget.data,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Actions"),
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateEfant(
                                            data: widget.data,
                                          )));
                            },
                            child: Icon(Icons.edit_outlined)),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.delete_outline)
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CardDetailEnfant(
                  width: widthAll,
                  title: "Nom complet",
                  content:
                      "${widget.data!["nom"]} ${widget.data!["postnom"]} ${widget.data!["prenom"]}",
                  icon: "assets/icons/avatar.svg",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CardDetailEnfant(
                  width: widthAll,
                  title: "Etablissement",
                  content:
                      "${widget.data!["school"]},  ${widget.data!["option"]}",
                  icon: "assets/icons/school.svg",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CardDetailEnfant(
                  width: widthAll,
                  title: "Adresse",
                  content:
                      "${widget.data!["commune"]}, ${widget.data!["ville"]}  ${widget.data!["province"]}, ${widget.data!["numero"]}, ${widget.data!["avenue"]}",
                  icon: "assets/icons/location.svg",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CardDetailEnfant(
                  width: widthAll,
                  title: "Personne de reference",
                  content:
                      "${widget.data!["personne_ref"]}, ${widget.data!["tel_personne_ref"]}",
                  icon: "assets/icons/avatar.svg",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Scan moi je te dirais qui je suis.",
                  style: GoogleFonts.habibi()),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        // padding: EdgeInsets.all(15.0),
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: QrCodeKelasi(
                            content: widget.data!["code_generate_tac"])),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
