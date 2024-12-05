import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';

class KelasiDropdownArrets extends StatefulWidget {
  const KelasiDropdownArrets(
      {super.key,
      this.controller,
      this.value,
      this.color,
      this.label,
      this.hintText,
      this.validator,
      this.items,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final String? value;
  final String? items;
  @override
  // ignore: library_private_types_in_public_api
  _KelasiDropdownArretsState createState() => _KelasiDropdownArretsState();
}

class _KelasiDropdownArretsState extends State<KelasiDropdownArrets> {
  String? labelForDropdown;

  @override
  void initState() {
    super.initState();

    if (widget.value == "universite") {
      labelForDropdown = "abreviation";
    } else if (widget.value == "departement") {
      labelForDropdown = "Departement";
    } else if (widget.value == "promotion") {
      labelForDropdown = "Promotion";
    } else if (widget.value == "abonnement") {
      labelForDropdown = "Type";
    } else if (widget.value == "province") {
      labelForDropdown = "province";
    } else if (widget.value == "ville") {
      labelForDropdown = "labele";
    } else if (widget.value == "commune") {
      labelForDropdown = "labele";
    } else if (widget.value == "level") {
      labelForDropdown = "label";
    } else if (widget.value == "users") {
      labelForDropdown = "prenom";
    } else if (widget.value == "arrets") {
      labelForDropdown = "label";
    } else if (widget.value == "lignes") {
      labelForDropdown = "libele_ligne_parcours";
    } else {
      labelForDropdown = "libele";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              // Création d'une liste temporaire pour transformer les données
              final List<dynamic> items = (state.field![widget.items] as List)
                  .map((item) => {
                        ...item,
                        "libele_ligne_parcours":
                            "${item['libele_ligne']} / ${item['parcours']}",
                      })
                  .toList();

              return DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20.0),
                  label: Text(widget.label.toString()),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                ),
                validator: (value) =>
                    value == null ? "Sélectionner l'université" : null,
                dropdownColor: AdaptiveTheme.of(context).mode.name == "dark"
                    ? Colors.black
                    : Colors.white,
                value: state.field![widget.value] == ""
                    ? null
                    : state.field![widget.value],
                onChanged: (newValue) {
                  BlocProvider.of<SignupCubit>(context).updateField(context,
                      field: widget.value.toString(),
                      data: newValue.toString());

                  if (widget.value == "lignes") {
                    BlocProvider.of<SignupCubit>(context)
                        .updateField(context, field: "arrets", data: "");
                  }
                  BlocProvider.of<SignupCubit>(context).updateField(context,
                      field: widget.value.toString(),
                      data: newValue.toString());
                },
                items: items.map<DropdownMenuItem<String>>((item) {
                  final displayText = item[labelForDropdown] ?? "";
                  return DropdownMenuItem<String>(
                    value: item['id'].toString(),
                    child: Tooltip(
                      message: displayText,
                      child: Container(
                        constraints: const BoxConstraints(
                            maxWidth: 250), // Ajuster la largeur
                        child: Text(
                          displayText,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                          overflow: TextOverflow
                              .visible, // Permettre de voir tout le texte
                          softWrap:
                              true, // Permet au texte de revenir à la ligne
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("UNIKIN"), value: "Unikin"),
    DropdownMenuItem(child: Text("ISTA"), value: "ISTA"),
    DropdownMenuItem(child: Text("ISC"), value: "ISC"),
    DropdownMenuItem(child: Text("ABA"), value: "ABA"),
  ];
  return menuItems;
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 1,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.black26,
        width: 1,
      ));
}
