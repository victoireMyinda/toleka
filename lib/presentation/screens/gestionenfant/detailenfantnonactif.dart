// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/screens/gestionenfant/widgets/carddetailenfant.dart';
import 'package:toleka/presentation/screens/gestionenfant/widgets/qrcodekelasi.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/theme.dart';

class DetailEnfantNonActif extends StatefulWidget {
  final Map? data;
  const DetailEnfantNonActif({super.key, this.data});

  @override
  State<DetailEnfantNonActif> createState() => _DetailEnfantNonActifState();
}

class _DetailEnfantNonActifState extends State<DetailEnfantNonActif> {
  String image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgXTbddKsgVA1ETOzRz4Kz9Ap-JtAZfCGGXA&usqp=CAU";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadServicesKelasi();
  }

  @override
  Widget build(BuildContext context) {
    double widthAll = MediaQuery.of(context).size.width;
    // double heightAll = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          backgroundColor: Colors.white,
          title: "Detail enfant enregistré",
          icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          onTapFunction: () {
            Navigator.of(context).pop();
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // HeaderDetailEnfant(
              //   image: image,
              //   data: widget.data,
              // ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Informations liées à l'enfant",
                      style: TextStyle(
                          color: kelasiColor, fontWeight: FontWeight.w500),
                    ),
                    // Row(children: [
                    //   Icon(
                    //     Icons.delete_outlined,
                    //     color: Colors.blue,
                    //   ),
                    //   SizedBox(width: 10),
                    //   InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 const SignupEnfantStep1()),
                    //       );
                    //     },
                    //     child: Icon(Icons.edit_outlined, color: Colors.blue),
                    //   )
                    // ]),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: CardDetailEnfant(
              //     width: widthAll,
              //     title: "Periode de l'abonnement en cours",
              //     content: "du 15/05/2023 au 15/06/2023",
              //     icon: "assets/icons/calendar.svg",
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardDetailEnfant(
                      width: widthAll / 2 - 20,
                      title: "Nom",
                      content: widget.data!["nom"],
                      icon: "assets/icons/avatar.svg",
                    ),
                    CardDetailEnfant(
                      width: widthAll / 2 - 20,
                      title: "Postnom",
                      content: widget.data!["postnom"],
                      icon: "assets/icons/avatar.svg",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardDetailEnfant(
                      width: widthAll / 2 - 20,
                      title: "Prenom",
                      content: widget.data!["prenom"],
                      icon: "assets/icons/avatar.svg",
                    ),
                    CardDetailEnfant(
                      width: widthAll / 2 - 20,
                      title: "Sexe",
                      content: widget.data!["sexe"],
                      icon: "assets/icons/sexe.svg",
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CardDetailEnfant(
                  width: widthAll,
                  title: "Etablissement",
                  content: "${widget.data!["school"]}",
                  icon: "assets/icons/school.svg",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return CardDetailEnfant(
                          width: widthAll / 2 - 20,
                          title: "Ecole",
                          content: widget.data!["school"],
                          icon: "assets/icons/school.svg",
                        );
                      },
                    ),
                    CardDetailEnfant(
                      width: widthAll / 2 - 20,
                      title: "Niveau",
                      content: widget.data!["level"],
                      icon: "assets/icons/school.svg",
                    ),
                  ],
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

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                    padding: EdgeInsets.all(15.0),
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: QrCodeKelasi(content: widget.data!["_uuid"])),
              ),

              // BlocBuilder<SignupCubit, SignupState>(
              //   builder: (context, state) {
              //     return InkWell(
              //       onTap: () {
              //         BlocProvider.of<SignupCubit>(context).updateField(context,
              //             field: "idStudent",
              //             data: widget.data!["id"].toString());
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => AbonnementKelasi(
              //                     data: state.field!["serviceDataKelasi"],
              //                   )),
              //         );
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: ButtonTransAcademia(title: "Abonnement"),
              //       ),
              //     );
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
