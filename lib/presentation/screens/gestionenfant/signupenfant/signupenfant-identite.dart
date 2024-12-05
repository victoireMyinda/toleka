import 'dart:io';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/screens/gestionenfant/signupenfant/signupenfant-adresse.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownPersonRef.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';
import 'package:toleka/presentation/widgets/stepIndicator.dart';
import 'package:toleka/sizeconfig.dart';
import 'package:toleka/theme.dart';

class SignupEnfantStep1 extends StatefulWidget {
  const SignupEnfantStep1({super.key});

  @override
  State<SignupEnfantStep1> createState() => _SignupEnfantStep1State();
}

class _SignupEnfantStep1State extends State<SignupEnfantStep1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadPersonneRef();

    // BlocProvider.of<SignupCubit>(context)
    //     .updateField(context, field: "nom", data: "");

    // BlocProvider.of<SignupCubit>(context)
    //     .updateField(context, field: "postnom", data: "");
    // BlocProvider.of<SignupCubit>(context)
    //     .updateField(context, field: "prenom", data: "");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarKelasi(
          title: "Enregistrement enfant",
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
                                    "Vueillez renseigner l'identité de l'enfant",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
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
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                StepIndicatorWidget(
                                  color: kelasiColor,
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
                                const StepIndicatorWidget(
                                  color: Colors.black26,
                                ),

                                // const SizedBox(
                                //   width: 10.0,
                                // ),
                                // const StepIndicatorWidget(
                                //   color: Colors.black26,
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: getProportionateScreenHeight(15),
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
                                      onTap: () {
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

                                        if (state.field!["nom"] == "") {
                                          BlocProvider.of<SignupCubit>(context)
                                              .updateField(context,
                                                  field: "nomError",
                                                  data: "error");
                                          ValidationDialog.show(context,
                                              "Veuillez indiquer le nom de l'enfant.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }

                                        if (state.field!["postnom"] == "") {
                                          BlocProvider.of<SignupCubit>(context)
                                              .updateField(context,
                                                  field: "postnomError",
                                                  data: "error");
                                          ValidationDialog.show(context,
                                              "Veuillez indiquer le postnom de l'enfant.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }

                                        if (state.field!["prenom"] == "") {
                                          BlocProvider.of<SignupCubit>(context)
                                              .updateField(context,
                                                  field: "prenomError",
                                                  data: "error");
                                          ValidationDialog.show(context,
                                              "Veuillez indiquer le prénom de l'enfant.",
                                              () {
                                            if (kDebugMode) {
                                              print("modal");
                                            }
                                          });
                                          return;
                                        }

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignupEnfantStep2()),
                                        );
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
      ),
    );
  }
}
