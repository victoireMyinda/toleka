// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/abonnement/cubit/abonnement_cubit.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/models/abonnement.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/singupkelasi/signup-step2kelasi.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownSexe.dart';
// ignore: unused_import
import 'package:toleka/locale/all_translations.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';
import 'package:toleka/presentation/widgets/stepIndicator.dart';
import 'package:toleka/sizeconfig.dart';
import 'package:toleka/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class SignupStep1Kelasi extends StatefulWidget {
  const SignupStep1Kelasi({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignupStep1KelasiState createState() => _SignupStep1KelasiState();
}

class _SignupStep1KelasiState extends State<SignupStep1Kelasi> {
  TextEditingController nomController = TextEditingController();
  TextEditingController postnomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController universiteController = TextEditingController();
  TextEditingController faculteController = TextEditingController();
  TextEditingController departementController = TextEditingController();
  TextEditingController promotionController = TextEditingController();
  TextEditingController lieuNaissanceController = TextEditingController();
  TextEditingController dateNaissanceController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? nameError;
  String? passwordError;
  String? submitError;
  bool checked = false;
  late List<Abonnement> allAbonnements;
  // String stateInfoUrl = 'https://api.trans-academia.cd/';
  // final Uri _url = Uri.parse('https://trans-academia.cd/privacy.html');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginToken();
    BlocProvider.of<SignupCubit>(context).initForm();
    BlocProvider.of<AbonnementCubit>(context).initFormPayment();
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "filePath", data: "");
  }

  loginToken() async {
    var response = await SignUpRepository.loginToken("900000000", "jacob");
    if (kDebugMode) {
      print(response);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.white,
      color: kelasiColor,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500));
        BlocProvider.of<SignupCubit>(context).initForm();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xff129BFF),
                  kelasiColor,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                        height: 10.0,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    AdaptiveTheme.of(context).mode.name !=
                                            "dark"
                                        ? "assets/images/logo-kelasi.png"
                                        : "assets/images/logo-kelasi.png"))),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Text(
                              "Inscription Parent",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const TransAcademiaDropdownSexe(
                        value: "sexe",
                        label: "Choisir le sexe",
                        hintText: "choisir le sexe",
                      ),
                       const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                        return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45.0,
                              child: TransAcademiaNameInput(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45.0,
                              child: TransAcademiaNameInput(
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45.0,
                              child: TransAcademiaNameInput(
                                isError: state.field!["prenomError"],
                                hintText: "Prenom",
                                field: "prenom",
                                label: "Prenom",
                                fieldValue: state.field!["prenom"],
                              ),
                            ));
                      }),
                       const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                        return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 45.0,
                              child: TransAcademiaNameInput(
                                hintText: "Votre adresse Email",
                                field: "email",
                                label: "Votre adresse Email",
                                fieldValue: state.field!["email"],
                              ),
                            ));
                      }),
                      SizedBox(
                        height: getProportionateScreenHeight(5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StepIndicatorWidget(
                            color: kelasiColor,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const StepIndicatorWidget(
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/loginkelasi',
                                      (Route<dynamic> route) => false);
                                },
                                child: ButtonTransAcademia(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    title: "Precedent"),
                              );
                            }),
                            BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                              return GestureDetector(
                                onTap: () {
                                  if (state.field!["sexe"] == "") {
                                    ValidationDialog.show(
                                        context, "Merci de choisir le genre.",
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
                                            field: "nomError", data: "error");
                                    ValidationDialog.show(
                                        context, "Veuillez indiquer votre nom.",
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
                                        "Veuillez indiquer votre postnom.", () {
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
                                        "Veuillez indiquer votre prénom.", () {
                                      if (kDebugMode) {
                                        print("modal");
                                      }
                                    });
                                    return;
                                  }

                                  if (state.field!["email"] == "") {
                                    ValidationDialog.show(
                                        context, "Veuillez saisir votre mail",
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
                                            const SignupStepKelasi2()),
                                  );
                                },
                                child: ButtonTransAcademia(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    title: "Suivant"),
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getProportionateScreenHeight(15),
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
