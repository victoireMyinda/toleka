import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Assurez-vous que cette dépendance est ajoutée
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/dialog/TransAcademiaDialogError.dart';
import 'package:toleka/presentation/widgets/dialog/loading.dialog.dart';
import 'package:toleka/presentation/widgets/inputs/passwordTextField.dart';
import 'package:toleka/presentation/widgets/inputs/simplePhoneNumberField.dart';
import '../../widgets/dialog/ValidationDialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? nameError;
  String? passwordError;
  String? submitError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        children: [
          // Premier bloc avec une hauteur fixe
          Container(
            height: 230,
            color: Colors.blue,
            child: const Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.png'),
                radius: 50,
              ),
            ),
          ),
          // Deuxième bloc qui occupe le reste de l'espace
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                ),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.montserrat(
                          
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                    BlocBuilder<SignupCubit, SignupState>(
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            if (state.field?["phone"]?.isEmpty ?? true) {
                              ValidationDialog.show(
                                context,
                                "Veuillez saisir le numéro de téléphone",
                                () {},
                              );
                              return;
                            }

                            String phone = state.field!["phone"];
                            if (phone.startsWith("0") ||
                                phone.startsWith("+")) {
                              ValidationDialog.show(
                                context,
                                "Veuillez saisir le numéro avec un format valide, par exemple: (826016607).",
                                () {},
                              );
                              return;
                            }
                            if (phone.length < 9) {
                              ValidationDialog.show(
                                context,
                                "Le numéro doit contenir au moins 9 caractères.",
                                () {},
                              );
                              return;
                            }
                            if (state.field?["password"]?.isEmpty ?? true) {
                              ValidationDialog.show(
                                context,
                                "Le mot de passe ne doit pas être vide.",
                                () {},
                              );
                              return;
                            }

                            // Vérification de la connexion Internet
                            try {
                              final response = await InternetAddress.lookup(
                                  'www.google.com');
                              if (response.isEmpty) {
                                throw SocketException("Pas de connexion");
                              }
                            } on SocketException {
                              ValidationDialog.show(
                                context,
                                "Pas de connexion internet !",
                                () {},
                              );
                              return;
                            }

                            TransAcademiaLoadingDialog.show(context);

                            var response = await SignUpRepository.login(
                              phone,
                              state.field!["password"],
                            );

                            int status = response["status"];
                            String? token = response["token"];
                            Map? data = response["data"];

                            if (status == 200 && data != null) {
                              await prefs.setString("token", token ?? "");
                              await prefs.setString(
                                  "parentId", data["id"]?.toString() ?? "");
                              await prefs.setString(
                                  "parentuuid", data["user"]["_uuid"] ?? "");
                              await prefs.setString("parentid",
                                  data["user"]["id"]?.toString() ?? "");

                              BlocProvider.of<SignupCubit>(context).updateField(
                                context,
                                field: "nomparentcomplet",
                                data: "${data['prenom']} ${data['nom']}",
                              );
                              BlocProvider.of<SignupCubit>(context).updateField(
                                context,
                                field: "dataParent",
                                data: data,
                              );

                              TransAcademiaLoadingDialog.stop(context);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                '/routestackkelasi',
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              TransAcademiaLoadingDialog.stop(context);
                              TransAcademiaDialogError.show(
                                context,
                                response["message"] ?? "Erreur inconnue",
                                "login",
                              );
                              Future.delayed(const Duration(seconds: 3), () {
                                TransAcademiaDialogError.stop(context);
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: const ButtonTransAcademia(
                                title: "Se connecter"),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Vous n'avez pas de compte ? ",
                            style: GoogleFonts.montserrat(
                                fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                          Text("Inscrivez-vous",
                          
                              style: GoogleFonts.montserrat(
                                  fontSize: 12, fontWeight: FontWeight.w600,
                                  
                                  )),
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
    );
  }
}
