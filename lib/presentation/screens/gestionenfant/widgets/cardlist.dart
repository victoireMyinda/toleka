// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/screens/gestionenfant/detailenfant.dart';
import 'package:toleka/presentation/widgets/imageview.dart';
import 'package:toleka/theme.dart';

class CardListEnfant extends StatefulWidget {
  final Map? data;
  const CardListEnfant({super.key, this.data});

  @override
  State<CardListEnfant> createState() => _CardListEnfantState();
}

class _CardListEnfantState extends State<CardListEnfant> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailEnfant(data: widget.data)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 110,
          // width: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                widget.data!["photo"] == null
                    ? SvgPicture.asset(
                        "assets/icons/avatarkelasi.svg",
                        width: 50,
                        color: kelasiColor,
                      )
                    : ImageViewerWidget(
                        url:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTgXTbddKsgVA1ETOzRz4Kz9Ap-JtAZfCGGXA&usqp=CAU",
                        width: 55,
                        height: 55,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
              ]),
              const Spacer(),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.data!["nom"]}  ${widget.data!["prenom"]}  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 11),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 237, 236, 236),
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          child:  Text("sexe : ${widget.data!["sexe"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  // color: Colors.red,
                                  fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Text(
                        //   "${widget.data?["promotion"]?["etablissement"] ?? "College saint theophile"}",
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w400,
                        //     fontSize: 11,
                        //   ),
                        // ),
                        BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return Text(
                              "Ecole : ${widget.data!["school"]}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 11),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width - 115,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width - 115,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.data!["created_at"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 11)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
