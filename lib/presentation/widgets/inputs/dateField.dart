import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:intl/intl.dart';

class TransAcademiaDatePicker extends StatefulWidget {
  const TransAcademiaDatePicker({
    super.key,
    this.controller,
    this.color,
    this.hintText,
    this.validator,
    this.label,
    this.field,
    this.fieldValue,
    this.number,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? label;
  final String? field;
  final String? fieldValue;

  @override
  _TransAcademiaDatePickerState createState() => _TransAcademiaDatePickerState();
}

class _TransAcademiaDatePickerState extends State<TransAcademiaDatePicker> {
  TextEditingController _date = TextEditingController();

  @override
  void initState() {
    super.initState();
    _date.text = widget.fieldValue ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _date,
      onTap: () async {
        DateTime? pickeddate = await showDatePicker(
          locale: const Locale("fr", "FR"),
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1960),
          lastDate: DateTime(2101),
        );

        if (pickeddate != null) {
          setState(() {
            _date.text = DateFormat('yyyy-MM-dd').format(pickeddate);
          });

          final fieldToUpdate = widget.field;
          if (fieldToUpdate == "dateReservation") {
            BlocProvider.of<SignupCubit>(context).updateField(
              context,
              data: _date.text,
              field: "dateReservation",
            );
          } else if (fieldToUpdate == "dateFinReservation") {
            BlocProvider.of<SignupCubit>(context).updateField(
              context,
              data: _date.text,
              field: "dateFinReservation",
            );
          }
        }
      },
      decoration: InputDecoration(
        label: Text(
          widget.label ?? "",
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
          ),
        ),
        suffixIcon: const Icon(Icons.date_range_outlined),
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Theme.of(context).backgroundColor,
        ),
        border: myinputborder(context),
        enabledBorder: myfocusborder(context),
        focusedBorder: myfocusborder(context),
      ),
    );
  }
}

OutlineInputBorder myinputborder(BuildContext context) {
  return const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: Colors.redAccent,
      width: 1,
    ),
  );
}

OutlineInputBorder myfocusborder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      color: Theme.of(context).backgroundColor,
      width: 1,
    ),
  );
}
