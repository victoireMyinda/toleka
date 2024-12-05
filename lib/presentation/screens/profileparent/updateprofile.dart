// ignore_for_file: use_build_context_synchronously

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
import 'package:toleka/presentation/widgets/inputs/dropdownKelasi.dart';
import 'package:toleka/presentation/widgets/inputs/dropdownSexe.dart';
import 'package:toleka/presentation/widgets/inputs/nameField.dart';
import 'package:toleka/presentation/widgets/inputs/passwordTextField.dart';
import 'package:toleka/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:toleka/sizeconfig.dart';

class UpdateProfileParent extends StatefulWidget {
  Map? data;
  UpdateProfileParent({super.key, this.data});

  @override
  State<UpdateProfileParent> createState() => _UpdateProfileParentState();
}

class _UpdateProfileParentState extends State<UpdateProfileParent> {
  TextEditingController arretEnfantController = TextEditingController();
  TextEditingController ligneEnfantController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadCommunesKelasi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBarKelasi(
          title: "Mis à jour de parent",
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
                                  "Les informations du parent",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // const TransAcademiaDropdownSexe(
                          //   value: "sexe",
                          //   label: "Choisir le sexe",
                          //   hintText: "choisir le sexe",
                          // ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
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
                                    hintText: "Votre adresse Email",
                                    field: "email",
                                    label: "Votre adresse Email",
                                    fieldValue: state.field!["email"],
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaPasswordField(
                                      // isError: state.field!["passwordError"],
                                      label: "Ancien mot de passe",
                                      hintText: "Ancien mot de passe",
                                      field: "oldPassword",
                                      fieldValue: state.field!["newPassword"],
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: SizedBox(
                                    height: 45.0,
                                    child: TransAcademiaPasswordField(
                                      label: "Nouveau mot de passe",
                                      hintText: "Nouveau mot de passe",
                                      field: "newPassword",
                                      fieldValue: state.field!["newPassword"],
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                margin: const EdgeInsets.only(bottom: 10),
                                child: SizedBox(
                                  height: 45.0,
                                  child: TransAcademiaNameInput(
                                    // controller: phoneController,
                                    hintText: "Numéro d'adresse",
                                    field: "numeroAdresse",
                                    label: "Numéro d'adresse",
                                    fieldValue: state.field!["numero"],
                                  ),
                                ));
                          }),
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

                                      // if (state.field!["sexe"] == "") {
                                      //   ValidationDialog.show(context,
                                      //       "Merci de choisir le genre.", () {
                                      //     if (kDebugMode) {
                                      //       print("modal");
                                      //     }
                                      //   });
                                      //   return;
                                      // }

                                      if (state.field!["nom"] == "") {
                                        ValidationDialog.show(context,
                                            "Veuillez indiquer votre nom.", () {
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

                                      if (state.field!["phone"] == "") {
                                        ValidationDialog.show(context,
                                            "le numero ne doit pas etre vide.",
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

                                      if (state.field!["oldPassword"] == "") {
                                        ValidationDialog.show(context,
                                            "Inserer votre ancien mot de passe.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      if (state.field!["newPassword"] == "") {
                                        ValidationDialog.show(context,
                                            "Inserer votre nouveau mot de passe.",
                                            () {
                                          if (kDebugMode) {
                                            print("modal");
                                          }
                                        });
                                        return;
                                      }

                                      TransAcademiaLoadingDialog.show(context);

                                      Map data = {
                                        "id": int.tryParse(
                                            state.field!["parentId"]),
                                        "nom": state.field!["nom"],
                                        "postnom": state.field!["postnom"],
                                        "prenom": state.field!["prenom"],
                                        // "sexe": state.field!["sexe"],
                                        "telephone": state.field!["phone"],
                                        "avenue": state.field!["avenue"],
                                        "numero": state.field!["numeroAdresse"],
                                        "email": state.field!["email"],
                                        "commune": int.tryParse(
                                            state.field!["commune"]),
                                        "old_pwd": state.field!["oldPassword"],
                                        "new_pwd": state.field!["newPassword"],
                                      };

                                       print(data);

                                      Map? response =
                                          await SignUpRepository.updateParent(
                                              data);

                                      int status = response["status"];
                                      String? message = response["message"];
                                      if (status == 200) {
                                        TransAcademiaLoadingDialog.stop(
                                            context);

                                        // String? messageSucces = message;
                                        TransAcademiaDialogSuccess.show(
                                            context, message, "Auth");

                                        Future.delayed(
                                            const Duration(milliseconds: 4000),
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
                                        width: 300, title: "Mis à jour"),
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
