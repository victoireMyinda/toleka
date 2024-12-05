import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';

class kelasiDropdownEnfant extends StatefulWidget {
  const kelasiDropdownEnfant(
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
  _kelasiDropdownEnfantState createState() => _kelasiDropdownEnfantState();
}

class _kelasiDropdownEnfantState extends State<kelasiDropdownEnfant> {
  String getLabelText(Map<String, dynamic> item) {
    String nom = item['nom'];
    String postnom = item['postnom'];
    String prenom = item['prenom'];

    return "$nom $postnom $prenom";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<SignupCubit, SignupState>(
            builder: (context, state) {
              return DropdownButtonFormField(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 20.0),
                  label: Text(widget.label.toString()),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    // borderSide: const BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                ),
                validator: (value) =>
                    value == null ? "Selectionner l'université" : null,
                dropdownColor: AdaptiveTheme.of(context).mode.name == "dark"
                    ? Colors.black
                    : Colors.white,
                value: state.field![widget.value] == ""
                    ? null
                    : state.field![widget.value],
                onChanged: (newValue) {
                  // selectedValue = newValue!.toString();
                  BlocProvider.of<SignupCubit>(context).updateField(context,
                      field: widget.value.toString(),
                      data: newValue.toString());
                },
                items: state.field![widget.items]
                    .map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: widget.value == "enfant"
                        ? item['_uuid']
                        : item['id'].toString(),
                    child: SizedBox(
                      width: 200.0,
                      child: Text(
                        getLabelText(item),
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 12,
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
