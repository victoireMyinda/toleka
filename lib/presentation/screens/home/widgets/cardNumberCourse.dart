import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/data/repository/signUp_repository.dart';
import 'package:toleka/theme.dart';

class CardNumberOfCourseKelasi extends StatefulWidget {
  const CardNumberOfCourseKelasi({super.key});

  @override
  State<CardNumberOfCourseKelasi> createState() =>
      _CardNumberOfCourseKelasiState();
}

class _CardNumberOfCourseKelasiState extends State<CardNumberOfCourseKelasi> {
  int dataStudentLength = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadData();
  }

  // loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? idParent = prefs.getString("parentId");
  //   Map? response =
  //       await SignUpRepository.getEnfantsDuParent(idParent.toString());
  //   List? recorded = response["data"]["active"];

  //   setState(() {
  //     dataStudentLength = recorded!.length;
  //     BlocProvider.of<SignupCubit>(context).updateField(context,
  //         field: "nombreEnfant", data: dataStudentLength.toString());
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(20.0),
        gradient: LinearGradient(
          colors: [
            const Color(0xff129BFF),
            kelasiColor,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                  return const Text(
                    "Merci d'utiliser nos services cher parent",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  );
                }),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<SignupCubit, SignupState>(
                    builder: (context, state) {
                  return Text(
                    state.field!["nomparentcomplet"],
                    style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
