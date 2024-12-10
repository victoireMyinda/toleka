import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:country_picker/country_picker.dart';

class TransAcademiaPhoneNumber extends StatefulWidget {
  const TransAcademiaPhoneNumber(
      {super.key,
      this.controller,
      this.color,
      this.hintText,
      this.validator,
      this.field,
      this.fieldValue,
      this.number});
  final TextEditingController? controller;
  final String? hintText;
  final String? validator;
  final Color? color;
  final int? number;
  final String? field;
  final String? fieldValue;
  @override
  // ignore: library_private_types_in_public_api
  _TransAcademiaPhoneNumberState createState() =>
      _TransAcademiaPhoneNumberState();
}

class _TransAcademiaPhoneNumberState extends State<TransAcademiaPhoneNumber> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.fieldValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return phoneForm(context, _controller, widget.field);
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        // color: Colors.redAccent,
        width: 1,
      ));
}

OutlineInputBorder myfocusborder(context) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Theme.of(context).backgroundColor,
        width: 1,
      ));
}

Widget phoneForm(context, _controller, field) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).backgroundColor.withOpacity(0.3), 
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10.0)),
    child: Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 90,
          padding: const EdgeInsets.only(bottom: 4.0),
          child: InkWell(
            onTap: () {},
            child: const Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Text(
                    '+243',
                  ),
                ),
                SizedBox(width: 10),
                Image(
                  image: AssetImage("assets/images/flag-trans.png"),
                  width: 30,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            width: double.infinity,
            child: Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      onChanged: (value) {
                        BlocProvider.of<SignupCubit>(context).updateField(
                            context,
                            data: value.toString(),
                            field: field.toString());
                      },
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(9),
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      controller: _controller,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        border: InputBorder.none,
                        hintText: "XXX XXX XXX",
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Ink(
                  width: 40,
                  height: 40,
                  child: InkWell(
                    onTap: () {
                      BlocProvider.of<SignupCubit>(context).updateField(context,
                          data: "", field: field.toString());
                      _controller.text = "";
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Icon(
                      Icons.highlight_remove,
                      color: Theme.of(context).backgroundColor,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

