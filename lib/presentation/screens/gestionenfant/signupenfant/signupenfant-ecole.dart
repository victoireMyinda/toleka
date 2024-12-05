// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/gestionenfant/signupenfant/signupenfant-arret.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownTransAcademia.dart';
import 'package:toleka/presentation/widgets/stepIndicator.dart';
import 'package:toleka/sizeconfig.dart';
import 'package:toleka/theme.dart';

class SignupEnfantStep3 extends StatefulWidget {
  const SignupEnfantStep3({super.key});

  @override
  State<SignupEnfantStep3> createState() => _SignupEnfantStep3State();
}

class _SignupEnfantStep3State extends State<SignupEnfantStep3> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadEtablissementData();
    BlocProvider.of<SignupCubit>(context).loadSectionData();
    BlocProvider.of<SignupCubit>(context).loadLeveltData();

    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "opstudent", data: "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBarKelasi(
          title: "Enregistrement enfant",
          icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          backgroundColor: Colors.white,
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: Column(
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              const SizedBox(height: 30),
                              const Text(
                                "Les informations de l'ecole de l'enfant",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
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
                        // const TransAcademiaDropdown(
                        //   items: "ecoleData",
                        //   value: "ecole",
                        //   label: "Choisir la ligne trajectoire",
                        //   hintText: "Choisir la ligne trajectoire",
                        // ),
                        // const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const StepIndicatorWidget(
                              color: Colors.black26,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            const StepIndicatorWidget(
                              color: Colors.black26,
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            StepIndicatorWidget(
                              color: kelasiColor,
                            ),
                          ],
                        ),

                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),

                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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

                                    TransAcademiaLoadingDialog.show(context);

                                    Map data = {
                                      "nom": state.field!["nom"],
                                      "postnom": state.field!["postnom"],
                                      "prenom": state.field!["prenom"],
                                      "sexe": state.field!["sexe"],
                                      "section_id":
                                          int.tryParse(state.field!["section"]),
                                      "option_id":
                                          int.tryParse(state.field!["option"]),
                                      "level_id":
                                          int.tryParse(state.field!["level"]),
                                      "etablissement_id":
                                          int.tryParse(state.field!["ecole"]),
                                      "avenue": state.field!["avenue"],
                                      "numero": state.field!["numero"],
                                      "DateNaissance": "2024-06-13",
                                      "personne_ref_id": int.tryParse(
                                          state.field!["personneref"]),
                                      "commune_id":
                                          int.tryParse(state.field!["commune"]),
                                      "id_user_created_at": int.tryParse(
                                          state.field!["parentasuser"]),
                                      "id_parent":
                                          int.tryParse(state.field!["parentId"])
                                    };

                                    // print(data);

                                    Map? response =
                                        await SignUpRepository.signupEnfant(
                                            data);

                                    int status = response["status"];
                                    String? message = response["message"];
                                    if (status == 201) {
                                      TransAcademiaLoadingDialog.stop(context);
                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(context,
                                              field: "opstudent",
                                              data: response["data"]
                                                  ["code_generate_tac"]);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupEnfantStep4()));
                                    } else {
                                      TransAcademiaLoadingDialog.stop(context);
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
    );
  }
}
