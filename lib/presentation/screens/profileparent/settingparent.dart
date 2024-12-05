// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/screens/personneref/signupstep1.dart';
import 'package:toleka/presentation/screens/profileparent/updateprofile.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/theme.dart';

class SettingParent extends StatefulWidget {
  final String? image;
  final bool? backNavigation;
  const SettingParent({super.key, this.backNavigation, this.image});

  @override
  State<SettingParent> createState() => _SettingParentState();
}

class _SettingParentState extends State<SettingParent> {
  String image =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgXTbddKsgVA1ETOzRz4Kz9Ap-JtAZfCGGXA&usqp=CAU";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfil();
  }

  getProfil() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "nom", data: prefs.getString('nom'));
    BlocProvider.of<SignupCubit>(context).updateField(context,
        field: "postnom", data: prefs.getString('postnom'));
    BlocProvider.of<SignupCubit>(context)
        .updateField(context, field: "prenom", data: prefs.getString('prenom'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff129BFF),
                      kelasiColor,
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    AppBarKelasi(
                      visibleAvatar: false,
                      color: Colors.white,
                      title: "Profil Parent",
                      icon: widget.backNavigation == false
                          ? null
                          : Platform.isIOS
                              ? Icons.arrow_back_ios
                              : Icons.arrow_back,
                      onTapFunction: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SvgPicture.asset(
                      "assets/icons/avatarkelasi.svg",
                      width: 50,
                      color: Colors.white,
                    ),
                    // SizedBox(height: 20),
                    // BlocBuilder<SignupCubit, SignupState>(
                    //   builder: (context, state) {
                    //     return Text(
                    //       "${state.field!["nomparentcomplet"]}",
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 20,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return Text(
                                    "Nom",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return Text(
                                    "${state.field!["dataParent"]["nom"]} ${state.field!["dataParent"]["postnom"]} ${state.field!["dataParent"]["prenom"]}",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 0.5,
                            width: 400,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return Text(
                                    "Téléphone",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return Text(
                                    "${state.field!["dataParent"]["telephone"]}",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 0.5,
                            width: 400,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return Text(
                                    "Sexe",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return Text(
                                    "${state.field!["dataParent"]["sexe"]}",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 0.5,
                            width: 400,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return Text(
                                    "Email",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              ),
                              BlocBuilder<SignupCubit, SignupState>(
                                builder: (context, state) {
                                  return Text(
                                    "${state.field!["dataParent"]["email"]}",
                                    style: TextStyle(
                                      // color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(15),
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateProfileParent()),
                              );
                            },
                            splashColor: kelasiColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mettre à jour vos informations"),
                                Icon(
                                  Icons.update,
                                  color: kelasiColor,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 0.5,
                            width: 400,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PersonneRefSignup1()),
                              );
                            },
                            splashColor: kelasiColorIcon,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Ajouter la personne de référence"),
                                Container(
                                  //height: 20,
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: kelasiColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  child: Icon(Icons.add, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          // Container(
                          //   height: 0.5,
                          //   width: 400,
                          //   color: Colors.grey,
                          // ),
                          // SizedBox(height: 20),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text("Changer de theme"),
                          //     SvgPicture.asset(
                          //       "assets/icons/theme.svg",
                          //       height: 22,
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: 20),
                          Container(
                            height: 0.5,
                            width: 400,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () async {
                              BlocProvider.of<SignupCubit>(context).updateField(
                                  context,
                                  field: "phone",
                                  data: "");
                              BlocProvider.of<SignupCubit>(context).updateField(
                                  context,
                                  field: "motdepasse",
                                  data: "");
                              BlocProvider.of<SignupCubit>(context)
                                  .updateField(context, field: "nom", data: "");

                              BlocProvider.of<SignupCubit>(context).updateField(
                                  context,
                                  field: "postnom",
                                  data: "");
                              BlocProvider.of<SignupCubit>(context).updateField(
                                  context,
                                  field: "prenom",
                                  data: "");
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/loginkelasi',
                                  (Route<dynamic> route) => false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Se deconnecter"),
                                Icon(
                                  Icons.logout,
                                  color: kelasiColor,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.all(20.0),
                  //   child: Container(
                  //       padding: EdgeInsets.all(15.0),
                  //       height: 250,
                  //       width: 250,
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(30),
                  //       ),
                  //       child: BlocBuilder<SignupCubit, SignupState>(
                  //         builder: (context, state) {
                  //           return QrCodeKelasi(
                  //               content: state.field!["parentId"]);
                  //         },
                  //       )),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
