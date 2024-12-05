// ignore_for_file: use_build_context_synchronously, unused_catch_clause

import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/screens/singupkelasi/signup-step1kelasi.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogOTPParent.dart';
import 'package:toleka/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
// ignore: unused_import
import 'package:toleka/locale/all_translations.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownKelasi.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';
import 'package:toleka/presentation/widgets/stepIndicator.dart';
import 'package:toleka/sizeconfig.dart';
import 'package:toleka/theme.dart';
import 'package:toleka/presentation/widgets/inputs/passwordTextField.dart';
import 'package:toleka/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class SignupStepKelasi2 extends StatefulWidget {
  const SignupStepKelasi2({Key? key, this.isStudentPage}) : super(key: key);
  final bool? isStudentPage;

  @override
  // ignore: library_private_types_in_public_api
  _SignupStepKelasi2State createState() => _SignupStepKelasi2State();
}

class _SignupStepKelasi2State extends State<SignupStepKelasi2>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool status = false;

  TextEditingController avenueController = TextEditingController();
  TextEditingController numeroAdresseController = TextEditingController();

  String? nameError;
  String? passwordError;
  String? submitError;
  bool checked = false;
  bool isWoman = false;
  var communes = [];
  var provinces = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BlocProvider.of<SignupCubit>(context).loadCommunesKelasi();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blue,
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
              // const SizedBox(height: 100,),

              // const SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).mode.name != "dark"
                      ? Colors.white
                      : Colors.black,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: Platform.isIOS == true ? 30 : 30,
                    ),

                    // const SizedBox(
                    //   height: 80.0,
                    // ),
                    Container(
                      height: 50,
                      // width: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  AdaptiveTheme.of(context).mode.name != "dark"
                                      ? "assets/images/logo-kelasi.png"
                                      : "assets/images/logo-kelasi.png"))),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                     const SizedBox(
                        height: 20,
                      ),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: SizedBox(
                              height: 45.0,
                              child: TransAcademiaPasswordField(
                                isError: state.field!["passwordError"],
                                label: "Mot de passe",
                                hintText: "Mot de passe",
                                field: "password",
                                fieldValue: state.field!["password"],
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: SizedBox(
                              height: 45.0,
                              child: TransAcademiaPasswordField(
                                isError: state.field!["confirmPasswordError"],
                                label: "Confirmer mot de passe",
                                hintText: "Confirmer mot de passe",
                                field: "confirmPassword",
                                fieldValue: state.field!["confirmPassword"],
                              ),
                            ));
                      },
                    ),
                     const SizedBox(
                        height: 20,
                      ),

                    const TransAcademiaDropdownKelasi(
                      items: "communeDataKelasi",
                      value: "commune",
                      label: "Choisir la commune",
                      hintText: "Choisir la commune",
                    ),
                     const SizedBox(
                        height: 20,
                      ),

                    BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 10),
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
                        height: 20,
                      ),

                    BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                      return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            height: 45.0,
                            child: TransAcademiaNameInput(
                              // controller: phoneController,
                              hintText: "Numéro d'adresse",
                              field: "numeroAdresse",
                              label: "Numéro d'adresse",
                              fieldValue: state.field!["numeroAdresse"],
                            ),
                          ));
                    }),

                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const StepIndicatorWidget(
                          color: Colors.black26,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        StepIndicatorWidget(
                          color: kelasiColor,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        // const StepIndicatorWidget(
                        //   color: Colors.black26,
                        // ),
                      ],
                    ),

                    SizedBox(
                      height: getProportionateScreenHeight(15),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupStep1Kelasi()),
                                );
                              },
                              child: ButtonTransAcademia(
                                  width: MediaQuery.of(context).size.width / 3,
                                  title: "Precedent"),
                            );
                          }),
                          BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                            return GestureDetector(
                              onTap: () async {
                                if (state.field!["phone"].substring(0, 1) ==
                                        "0" ||
                                    state.field!["phone"].substring(0, 1) ==
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

                                if (state.field!["password"] == "") {
                                  ValidationDialog.show(context,
                                      "le mot de passe ne doit pas être vide",
                                      () {
                                    if (kDebugMode) {
                                      print("modal");
                                    }
                                  });
                                  return;
                                }

                                if (state.field!["confirmPassword"] !=
                                    state.field!["password"]) {
                                  ValidationDialog.show(context,
                                      "Les deux mots de passe doivent être identiques.",
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
                                  "prenom": state.field!["prenom"],
                                  "postnom": state.field!["postnom"],
                                  "sexe": state.field!["sexe"],
                                  "telephone": state.field!["phone"],
                                  "avenue": state.field!["avenue"],
                                  "numero": state.field!["numeroAdresse"],
                                  "email": state.field!["email"],
                                  "commune":
                                      int.tryParse(state.field!["commune"]),
                                  "pwd": state.field!["password"],
                                  "pwd_confirm":
                                      state.field!["confirmPassword"],
                                  "created_by_user": 1,
                                };

                                // print(data);

                                var response = await SignUpRepository.signup(
                                    data, context);
                                int status = response["status"];
                                String? message = response["message"];

                                if (status == 201) {
                                  TransAcademiaLoadingDialog.stop(context);
                                  TransAcademiaDialogOTPParent.show(context);

                                  // String? messageSucces ="La création de l'utilisateur a été effectuée avec succès";
                                  // TransAcademiaDialogSuccess.show(context,
                                  //     messageSucces, "Auth");

                                  // Future.delayed(
                                  //     const Duration(milliseconds: 4000),
                                  //     () async {

                                  // TransAcademiaDialogSuccess.stop(context);
                                  // Navigator.of(context)
                                  //     .pushNamedAndRemoveUntil('/loginkelasi',
                                  //         (Route<dynamic> route) => false);
                                  // });
                                } else {
                                  TransAcademiaLoadingDialog.stop(context);

                                  TransAcademiaDialogError.show(
                                      context, message, "login");
                                }
                              },
                              child: ButtonTransAcademia(
                                  width: MediaQuery.of(context).size.width / 3,
                                  title: "S'inscrire"),
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
