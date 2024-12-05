// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
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
import 'package:toleka/presentation/widgets/inputs/dropdownKelasi.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownPersonRef.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownSexe.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';
import 'package:toleka/sizeconfig.dart';

class UpdateEfant extends StatefulWidget {
  Map? data;
  UpdateEfant({super.key, this.data});

  @override
  State<UpdateEfant> createState() => _UpdateEfantState();
}

class _UpdateEfantState extends State<UpdateEfant> {
  TextEditingController arretEnfantController = TextEditingController();
  TextEditingController ligneEnfantController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadEtablissementData();
    BlocProvider.of<SignupCubit>(context).loadSectionData();
    BlocProvider.of<SignupCubit>(context).loadLeveltData();
    BlocProvider.of<SignupCubit>(context).loadLignesKelasi();
    BlocProvider.of<SignupCubit>(context).loadPersonneRef();
    BlocProvider.of<SignupCubit>(context).loadCommunesKelasi();

    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "opstudent", data: "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBarKelasi(
          title: "Modififcation enfant",
          icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          backgroundColor: Colors.white,
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AdaptiveTheme.of(context).mode.name != "dark"
                            ? Colors.white
                            : Colors.black,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const SizedBox(height: 30),
                                const Text(
                                  "Les informations de l'enfant",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  height: 45.0,
                                  child: TransAcademiaNameInput(
                                    // controller: phoneController,
                                    isError: state.field!["nomError"],
                                    hintText: "Nom",
                                    field: "nom",
                                    label: "Nom",
                                    fieldValue: state.field!["nom"],
                                  ),
                                ));
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  height: 45.0,
                                  child: TransAcademiaNameInput(
                                    // controller: phoneController,
                                    isError: state.field!["postnomError"],
                                    hintText: "Postnom",
                                    field: "postnom",
                                    label: "Postnom",
                                    fieldValue: state.field!["postnom"],
                                  ),
                                ));
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  height: 45.0,
                                  child: TransAcademiaNameInput(
                                    // controller: phoneController,
                                    isError: state.field!["prenomError"],
                                    hintText: "Prenom",
                                    field: "prenom",
                                    label: "Prenom",
                                    fieldValue: state.field!["prenom"],
                                  ),
                                ));
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                margin: const EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                  height: 45.0,
                                  child: TransAcademiaNameInput(
                                    // controller: phoneController,
                                    hintText: "Avenue",
                                    field: "avenue",
                                    label: "Avenue",
                                    fieldValue: state.field!["avenue"],
                                  ),
                                ));
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                margin: const EdgeInsets.only(bottom: 20),
                                child: SizedBox(
                                  height: 45.0,
                                  child: TransAcademiaNameInput(
                                    // controller: phoneController,
                                    hintText: "numero",
                                    field: "numero",
                                    label: "Numero",
                                    fieldValue: state.field!["numero"],
                                  ),
                                ));
                          }),
                          const TransAcademiaDropdownSexe(
                            value: "sexe",
                            label: "Choisir le sexe",
                            hintText: "choisir le sexe",
                          ),
                          const SizedBox(height: 20),
                          const TransAcademiaDropdownKelasi(
                            items: "communeDataKelasi",
                            value: "commune",
                            label: "Choisir la commune",
                            hintText: "Choisir la commune",
                          ),
                          const SizedBox(height: 20),
                          const TransAcademiaDropdown(
                            items: "ecoleData",
                            value: "ecole",
                            label: "Choisir l'ecole",
                            hintText: "Choisir l'ecole",
                          ),
                          const SizedBox(height: 20),
                          const TransAcademiaDropdown(
                            items: "sectionData",
                            value: "section",
                            label: "Choisir la section",
                            hintText: "Choisir la section",
                          ),
                          const SizedBox(height: 20),
                          const TransAcademiaDropdown(
                            items: "optionData",
                            value: "option",
                            label: "Choisir l'option",
                            hintText: "Choisir l'option",
                          ),
                          const SizedBox(height: 20),
                          const TransAcademiaDropdown(
                            items: "levelData",
                            value: "level",
                            label: "Choisir la classe",
                            hintText: "Choisir la classe",
                          ),
                          const SizedBox(height: 20),
                          const TransAcademiaDropDownPersRef(
                            items: "PersonneRefData",
                            value: "personneref",
                            label: "personne de reference",
                            hintText: "personne de reference",
                          ),
                          const SizedBox(height: 20),
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
                            height: 30,
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
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocBuilder<SignupCubit, SignupState>(
                                    builder: (context, state) {
                                  return GestureDetector(
                                    onTap: () async {
                                      // check connexion
                                      try {
                                        final response =
                                            await InternetAddress.lookup(
                                                'www.google.com');
                                        if (response.isNotEmpty) {
                                          print("connected");
                                        }
                                      } on SocketException catch (err) {
                                        ValidationDialog.show(context,
                                            "Pas de connexion internet !", () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                       if (state.field!["nom"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez indiquer votre nom.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      if (state.field!["postnom"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez indiquer votre postnom.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      if (state.field!["prenom"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez indiquer votre prenom.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      if (state.field!["ecole"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez renseigner l'ecole de l'eleve.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                      if (state.field!["section"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez renseigner la section de l'eleve.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                      if (state.field!["option"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez renseigner l'option de l'eleve.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                      if (state.field!["level"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez renseigner la classe de l'eleve.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      if (state.field!["personneref"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez indiquer la personne de reference.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      if (state.field!["lignes"] == "") {
                                        ValidationDialog.show(context,
                                            "Vueillez renseigner l'arret de l'enfant.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }
                                      if (state.field!["arrets"] == "") {
                                        ValidationDialog.show(context,
                                            "Vueillez renseigner l'arret de l'enfant.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      TransAcademiaLoadingDialog.show(context);

                                      Map data = {
                                        "nom": state.field!["nom"],
                                        "postnom": state.field!["postnom"],
                                        "prenom": state.field!["prenom"],
                                        "sexe": state.field!["sexe"],
                                        "section_id": int.tryParse(
                                            state.field!["section"]),
                                        "option_id": int.tryParse(
                                            state.field!["option"]),
                                        "level_id":
                                            int.tryParse(state.field!["level"]),
                                        "etablissement_id":
                                            int.tryParse(state.field!["ecole"]),
                                        "avenue": state.field!["avenue"],
                                        "numero": state.field!["numero"],
                                        "DateNaissance": "2024-06-13",
                                        "personne_ref_id": int.tryParse(
                                            state.field!["personneref"]),
                                        "commune_id": int.tryParse(
                                            state.field!["commune"]),
                                        "bus_stop_id": int.tryParse(
                                            state.field!["arrets"]),
                                        "code_generate_tac":
                                            widget.data!["code_generate_tac"],
                                        "promotion_id": 1
                                      };

                                      // print(data);

                                      Map? response =
                                          await SignUpRepository.updateEnfant(
                                              data);

                                      int status = response["status"];

                                      if (status == 200) {
                                        String? message = response["message"];
                                        TransAcademiaLoadingDialog.stop(
                                            context);

                                        TransAcademiaDialogSuccess.show(
                                            context, message, "Auth");

                                        Future.delayed(
                                            const Duration(milliseconds: 4000),
                                            () async {
                                          TransAcademiaDialogSuccess.stop(
                                              context);
                                          Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ContactEncadreurScreen()));
                                        });
                                      } else {
                                        String? message = response["message"];
                                        TransAcademiaLoadingDialog.stop(
                                            context);
                                        TransAcademiaDialogError.show(
                                            context, message, "login");
                                      }
                                    },
                                    child: const ButtonTransAcademia(
                                        width: 300, title: "Suivant"),
                                  );
                                }),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getProportionateScreenHeight(30),
                          ),
                        ],
                      ),
                    ),
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
