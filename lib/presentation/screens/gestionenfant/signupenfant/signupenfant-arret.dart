// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/gestionenfant/signupenfant/contactencadreur.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:toleka/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownArret.dart';

class SignupEnfantStep4 extends StatefulWidget {
  SignupEnfantStep4({super.key});

  @override
  State<SignupEnfantStep4> createState() => _SignupEnfantStep4State();
}

class _SignupEnfantStep4State extends State<SignupEnfantStep4> {
  TextEditingController arretEnfantController = TextEditingController();
  TextEditingController ligneEnfantController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<SignupCubit>(context).loadLignesKelasi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          title: "Arret de l'enfant",
          backgroundColor: Colors.white,
          icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        // margin: const EdgeInsets.only(bottom: 30, top: 20),
                        child: SizedBox(
                      height: 50.0,
                      child: KelasiDropdownArrets(
                        items: "lignesDatakelasi",
                        value: "lignes",
                        controller: ligneEnfantController,
                        hintText: "Selectionner la ligne de l'enfant",
                        color: Colors.white,
                        label: "Selectionner la ligne de l'enfant",
                      ),
                    ));
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<SignupCubit, SignupState>(
                  builder: (context, state) {
                    return Container(
                        // padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        // margin: const EdgeInsets.only(bottom: 30, top: 20),
                        child: SizedBox(
                      height: 50.0,
                      child: KelasiDropdownArrets(
                        items: "arretDatakelasi",
                        value: "arrets",
                        controller: arretEnfantController,
                        hintText: "Selectionner l'arret de l'enfant",
                        color: Colors.white,
                        label: "Selectionner l'arret de l'enfant",
                      ),
                    ));
                  },
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                        return GestureDetector(
                          onTap: () async {
                            if (state.field!["lignes"] == "") {
                              ValidationDialog.show(context,
                                  "Vueillez renseigner l'arret de l'enfant.", () {
                                if (kDebugMode) {
                                  print("modal");
                                }
                              });
                              return;
                            }
                            if (state.field!["arrets"] == "") {
                              ValidationDialog.show(context,
                                  "Vueillez renseigner l'arret de l'enfant.", () {
                                if (kDebugMode) {
                                  print("modal");
                                }
                              });
                              return;
                            }
                            TransAcademiaLoadingDialog.show(context);
        
                            Map data = {
                              "bus_stop_id": int.tryParse(state.field!["arrets"])
                            };
                            //  print(data);
        
                            Map? response =
                                await SignUpRepository.putArretStudent(
                                    data, state.field!["opstudent"]);
        
                            // print(state.field!["rfstudent"]);
        
                            int status = response["status"];
                            String? message = response["message"];
        
                            if (status == 200) {
                              String? messageSucces =
                                  "Enfant enregistré avec succes";
                              TransAcademiaDialogSuccess.show(
                                  context, messageSucces, "put arret");
        
                              Future.delayed(const Duration(milliseconds: 4000),
                                  () async {
                                TransAcademiaDialogSuccess.stop(context);
                                 Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ContactEncadreurScreen()));
                              });
                            } else {
                              TransAcademiaLoadingDialog.stop(context);
                              
                              TransAcademiaDialogError.show(
                                  context, message, "login");
                            }
                          },
                          child: const ButtonTransAcademia(
                              width: 300, title: "Enregistrer"),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
