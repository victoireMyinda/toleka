import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogSuccess.dart';
import 'package:toleka/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownSexe.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';
import 'package:toleka/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:toleka/sizeconfig.dart';

class PersonneRefSignup1 extends StatefulWidget {
  const PersonneRefSignup1({super.key});

  @override
  State<PersonneRefSignup1> createState() => _PersonneRefSignup1State();
}

class _PersonneRefSignup1State extends State<PersonneRefSignup1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "nom", data: "");

    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "postnom", data: "");
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "prenom", data: "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          title: "Enregistrement P. de reference",
          backgroundColor: Colors.white,
          icon: Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          onTapFunction: () => Navigator.of(context).pop(),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            //padding: const EdgeInsets.all(3),
            color: const Color(0xffF2F2F2),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,

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
                        // height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height,
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
                                    "Identité",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            const TransAcademiaDropdownSexe(
                              value: "sexe",
                              label: "Choisir le sexe",
                              hintText: "choisir le sexe",
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
                                      hintText: "Nom complet",
                                      field: "nomcomplet",
                                      label: "Nom complet",
                                      fieldValue: state.field!["nomcomplet"],
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
                                      hintText: "Adresse complete",
                                      field: "adressecomplete",
                                      label: "Adresse complete",
                                      fieldValue:
                                          state.field!["adressecomplete"],
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
                                    child: TransAcademiaPhoneNumber(
                                      number: 20,
                                      hintText: "Numéro de téléphone",
                                      field: "phone",
                                      fieldValue: state.field!["phone"],
                                    ),
                                  ));
                            }),

                            const SizedBox(height: 20),

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
                                        if (state.field!["sexe"] == "") {
                                          ValidationDialog.show(context,
                                              "Veuillez indiquer le sexe de l'enfant.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }

                                        if (state.field!["nomcomplet"] == "") {
                                          ValidationDialog.show(context,
                                              "Veuillez indiquer le nom complet.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }

                                        if (state.field!["adressecomplete"] ==
                                            "") {
                                          ValidationDialog.show(context,
                                              "Veuillez indiquer l'adresse complete.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }

                                        if (state.field!["phone"] == "") {
                                          ValidationDialog.show(context,
                                              "Veuillez saisir le numéro de téléphone",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }

                                        if (state.field!["phone"]
                                                    .substring(0, 1) ==
                                                "0" ||
                                            state.field!["phone"]
                                                    .substring(0, 1) ==
                                                "+") {
                                          ValidationDialog.show(context,
                                              "Veuillez saisir le numéro avec le format valide, par exemple: (826016607).",
                                              () {
                                            print("modal");
                                          });
                                          return;
                                        }
                                        if (state.field!["phone"].length < 8) {
                                          ValidationDialog.show(context,
                                              "Le numéro ne doit pas avoir moins de 9 caractères, par exemple: (826016607).",
                                              () {
                                            print("modal");
                                          });
                                          return;
                                        }
                                        TransAcademiaLoadingDialog.show(
                                            context);

                                        Map data = {
                                          "nom_complet":
                                              state.field!["nomcomplet"],
                                          "sexe": state.field!["sexe"],
                                          "telephone": state.field!["phone"],
                                          "adresse_complete":
                                              state.field!["adressecomplete"],
                                          "created_by_user": int.tryParse(
                                              state.field!["parentasuser"]),
                                          "parent": int.parse(
                                              state.field!["parentId"])
                                        };

                                        // print(data);

                                        var response = await SignUpRepository
                                            .signupPersonneRef(data, context);
                                        int status = response["status"];
                                        String? message = response["message"];

                                        if (status == 201) {
                                          TransAcademiaLoadingDialog.stop(
                                              context);

                                          String? messageSucces = message;
                                          TransAcademiaDialogSuccess.show(
                                              context, messageSucces, "Auth");

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 4000),
                                              () async {
                                            TransAcademiaDialogSuccess.stop(
                                                context);
                                            Navigator.of(context)
                                                .pushNamedAndRemoveUntil(
                                                    '/routestackkelasi',
                                                    (Route<dynamic> route) =>
                                                        false);
                                          });
                                        } else {
                                          TransAcademiaLoadingDialog.stop(
                                              context);

                                          TransAcademiaDialogError.show(
                                              context, message, "login");
                                        }
                                      },
                                      child: const ButtonTransAcademia(
                                          width: 300, title: "Enregitrer"),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(60),
                            ),

                            // SizedBox(
                            //   height: MediaQuery.of(context).size.height * 0.20,
                            // ),
                            //
                            // Text("A propos",style:GoogleFonts.montserrat(color: Colors.white, fontSize: 12)),
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
      ),
    );
  }
}
