// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toleka/presentation/screens/singupkelasi/signup-step1kelasi.dart';
import 'package:toleka/presentation/widgets/recipedlogin.dart';
import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/ValidationDialog.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/presentation/widgets/inputs/passwordTextField.dart';
import 'package:toleka/presentation/widgets/inputs/simplePhoneNumberField.dart';
import 'package:toleka/theme.dart';

class LoginKelasiScreen extends StatefulWidget {
  const LoginKelasiScreen({Key? key}) : super(key: key);

  @override
  _LoginKelasiScreenState createState() => _LoginKelasiScreenState();
}

class _LoginKelasiScreenState extends State<LoginKelasiScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? nameError;
  String? passwordError;
  String? submitError;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            const RecipeDetailAppBarLogin(
              height: 200,
              image: "image: widget.image",
            ),
            SliverToBoxAdapter(
              child: Container(
                color: const Color(0xFFF5F5F5),
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "TAC Kelasi",
                            style: GoogleFonts.montserrat(
                                fontSize: 17, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 80,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/log.png"),
                          ),
                        ),
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15, top: 20),
                            child: SizedBox(
                              height: 50.0,
                              child: TransAcademiaPhoneNumber(
                                number: 20,
                                controller: phoneController,
                                hintText: "Numéro de téléphone",
                                field: "phone",
                                fieldValue: state.field!["phone"],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      BlocBuilder<SignupCubit, SignupState>(
                        builder: (context, state) {
                          return Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            margin: const EdgeInsets.only(bottom: 15),
                            child: SizedBox(
                              height: 50.0,
                              child: TransAcademiaPasswordField(
                                controller: passwordController,
                                label: "Mot de passe",
                                hintText: "Mot de passe",
                                field: "password",
                                fieldValue: state.field!["password"],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (() => showToast("Bientôt disponible",
                                  duration: 3, gravity: Toast.bottom)),
                              child: Text(
                                "Mot de passe oublié ? ",
                                style: TextStyle(
                                    color: primaryColor, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<SignupCubit, SignupState>(
                              builder: (context, state) {
                                return GestureDetector(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    if (state.field!["phone"] == "") {
                                      ValidationDialog.show(
                                          context,
                                          "Veuillez saisir le numéro de téléphone",
                                          () {});
                                      return;
                                    }

                                    if (state.field!["phone"].substring(0, 1) ==
                                            "0" ||
                                        state.field!["phone"].substring(0, 1) ==
                                            "+") {
                                      ValidationDialog.show(
                                        context,
                                        "Veuillez saisir le numéro avec le format valide, par exemple: (826016607).",
                                        () {},
                                      );
                                      return;
                                    }
                                    if (state.field!["phone"].length < 8) {
                                      ValidationDialog.show(
                                        context,
                                        "Le numéro ne doit pas avoir moins de 9 caractères, par exemple: (826016607).",
                                        () {},
                                      );
                                      return;
                                    }
                                    if (state.field!["password"] == "") {
                                      ValidationDialog.show(
                                          context,
                                          "le mot de passe ne doit pas être vide",
                                          () {});
                                      return;
                                    }

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
                                          "Pas de connexion internet !", () {});
                                      return;
                                    }

                                    TransAcademiaLoadingDialog.show(context);

                                    var response = await SignUpRepository.login(
                                      state.field!["phone"],
                                      state.field!["password"],
                                    );
                                    int status = response["status"];
                                    String? token = response["token"];
                                    //String? message = response["message"];
                                    Map? data = response["data"];

                                    if (status == 200) {
                                      await prefs.setString(
                                          "token", token.toString());
                                      await prefs.setString(
                                        "parentId",
                                        data!["id"].toString(),
                                      );
                                      await prefs.setString(
                                        "parentuuid",
                                        data["user"]["_uuid"],
                                      );
                                      await prefs.setString(
                                          "parentid",
                                          data["user"]["id"]
                                              .toString()
                                              .toString());

                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(context,
                                              field: "nomparentcomplet",
                                              data: data["prenom"] +
                                                  " " +
                                                  data["nom"]);

                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(context,
                                              field: "dataParent", data: data);

                                      // BlocProvider.of<SignupCubit>(context)
                                      //     .updateField(
                                      //   context,
                                      //   field: "nom",
                                      //   data: data["nom"],
                                      // );
                                      // BlocProvider.of<SignupCubit>(context)
                                      //     .updateField(
                                      //   context,
                                      //   field: "prenom",
                                      //   data: data["prenom"],
                                      // );
                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(
                                        context,
                                        field: "userId",
                                        data: data["id_user_created_at"]
                                            .toString(),
                                      );
                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(
                                        context,
                                        field: "parentId",
                                        data: data["id"].toString(),
                                      );

                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(
                                        context,
                                        field: "parentuuid",
                                        data: data["user"]["_uuid"],
                                      );
                                      BlocProvider.of<SignupCubit>(context)
                                          .updateField(
                                        context,
                                        field: "parentasuser",
                                        data: data["user"]["id"].toString(),
                                      );
                                      AdaptiveTheme.of(context).setLight();

                                      TransAcademiaLoadingDialog.stop(context);
                                      Navigator.of(context)
                                          .pushNamedAndRemoveUntil(
                                              '/routestackkelasi',
                                              (Route<dynamic> route) => false);
                                    } else if (response["status"] == 404) {
                                      TransAcademiaLoadingDialog.stop(context);
                                      TransAcademiaDialogError.show(
                                        context,
                                        response["message"],
                                        "login",
                                      );
                                      Future.delayed(
                                          const Duration(milliseconds: 3000),
                                          () {
                                        TransAcademiaDialogError.stop(context);
                                      });
                                    } else {
                                      TransAcademiaLoadingDialog.stop(context);
                                      TransAcademiaDialogError.show(context,
                                          response["message"], "login");
                                      Future.delayed(
                                          const Duration(milliseconds: 3000),
                                          () {
                                        TransAcademiaDialogError.stop(context);
                                      });
                                    }
                                  },
                                  child: const ButtonTransAcademia(
                                      title: "Se connecter"),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Vous n'avez pas un compte ? ",
                                  style: TextStyle(fontSize: 13),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupStep1Kelasi()),
                                    );
                                  },
                                  child: Text(
                                    "Creez un compte",
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: (() => showToast("Bientôt disponible",
                                      duration: 3, gravity: Toast.bottom)),
                                  child: Text(
                                    "Aide? ",
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}
