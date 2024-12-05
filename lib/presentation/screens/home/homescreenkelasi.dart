// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toleka/business_logic/cubit/signup/cubit/signup_cubit.dart';
import 'package:toleka/presentation/screens/home/widgets/cardmenukelasi.dart';
import 'package:toleka/presentation/widgets/appbarkelasi.dart';
import 'package:toleka/presentation/widgets/buttons/buttonTransAcademia.dart';
import 'package:toleka/presentation/widgets/caroussel.dart';
import 'package:toleka/presentation/widgets/imageview.dart';
import 'package:toleka/sizeconfig.dart';
import 'package:toleka/theme.dart';
import 'widgets/cardNumberCourse.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:toast/toast.dart';
import 'package:animate_do/animate_do.dart';

class HomeScreenKelasi extends StatefulWidget {
  const HomeScreenKelasi({Key? key}) : super(key: key);

  @override
  State<HomeScreenKelasi> createState() => _HomeScreenKelasiState();
}

class _HomeScreenKelasiState extends State<HomeScreenKelasi> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? nom, postnom, prenom;
  String? code;
  var androidState;
  var iosState;
  Timer? timer, timerdeconnect;
  String url = "https://api-bantou-store.vercel.app/api/v1/images";
  var dataImages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SignupCubit>(context).loadServicesKelasi();

    // getProfil();
    // getDate();
    // checkRefresh();
    // getCourse();
    // getProfilStudent();
    // checkVersion();
    // _startTimerDeconnect();
  }

  // void _startTimerDeconnect() {
  //   const timeLimit = Duration(minutes: 10);
  //   timerdeconnect = Timer(timeLimit, () async {
  //     // Code de déconnexion ici
  //     BlocProvider.of<SignupCubit>(context)
  //         .updateField(context, field: "phone", data: "");
  //     BlocProvider.of<SignupCubit>(context)
  //         .updateField(context, field: "motdepasse", data: "");
  //     BlocProvider.of<SignupCubit>(context)
  //         .updateField(context, field: "nom", data: "");

  //     BlocProvider.of<SignupCubit>(context)
  //         .updateField(context, field: "postnom", data: "");
  //     BlocProvider.of<SignupCubit>(context)
  //         .updateField(context, field: "prenom", data: "");
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.clear();
  //     Navigator.of(context)
  //         .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  //   });
  // }

  // void _resetTimer() {
  //   if (timerdeconnect != null) {
  //     timerdeconnect!.cancel();
  //   }
  //   _startTimerDeconnect();
  // }

  // @override
  // void dispose() {
  //   timer?.cancel();
  //   if (timerdeconnect != null) {
  //     timerdeconnect!.cancel();
  //   }
  //   super.dispose();
  // }

  // checkRefresh() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var refresh;
  //   refresh = prefs.getString('refresh');

  //   if (refresh == "0") {
  //     timerdeconnect!.cancel();
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => SignupStep3(
  //                 backNavigation: false,
  //               )),
  //     );
  //   } else {
  //     print("refresh oui");
  //   }
  // }

  // getProfil() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "nom", data: prefs.getString('nom'));
  //   BlocProvider.of<SignupCubit>(context).updateField(context,
  //       field: "postnom", data: prefs.getString('postnom'));
  //   BlocProvider.of<SignupCubit>(context)
  //       .updateField(context, field: "prenom", data: prefs.getString('prenom'));
  // }

  // checkVersion() async {
  //   WidgetsFlutterBinding.ensureInitialized();

  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   String appName = packageInfo.appName;
  //   String packageName = packageInfo.packageName;
  //   String version = packageInfo.version;
  //   String buildNumber = packageInfo.buildNumber;

  //   print('build' + buildNumber);

  //   final response = await http
  //       .get(Uri.parse('https://api-bantou-store.vercel.app/api/v1/versions'));

  //   if (response.statusCode == 200) {
  //     var data = json.decode(response.body);

  //     print(data["android"]);

  //     androidState = data["android"];
  //     iosState = data["ios"];
  //     List<String> descriptionList = data["description"].split(",");

  //     BlocProvider.of<SignupCubit>(context).updateField(context,
  //         field: "descriptionVersion", data: data["description"]);

  //     if (Platform.isIOS == true) {
  //       if (int.parse(buildNumber) < int.parse(iosState)) {
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "iconVersion", data: "assets/images/update.json");
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "titreVersion", data: "Découvrez les nouveautés");
  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             '/version', (Route<dynamic> route) => false,
  //             arguments: descriptionList);
  //       } else {
  //         print('ok');
  //         return;
  //       }
  //     }

  //     if (Platform.isIOS == false) {
  //       if (int.parse(buildNumber) < int.parse(androidState)) {
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "iconVersion", data: "assets/images/update.json");
  //         BlocProvider.of<SignupCubit>(context).updateField(context,
  //             field: "titreVersion", data: "Découvrez les nouveautés");
  //         Navigator.of(context).pushNamedAndRemoveUntil(
  //             '/version', (Route<dynamic> route) => false,
  //             arguments: descriptionList);
  //         // return;
  //       } else {
  //         print('ok');
  //       }
  //     }
  //   } else {
  //     print('error');
  //   }
  // }

  // String stateInfoUrl = 'https://api.trans-academia.cd/';
  // void getCourse() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();

  //   await http.post(
  //       Uri.parse("https://tag.trans-academia.cd/Api_view_courses_user.php"),
  //       body: {'IDetudiant': prefs.getString('code')}).then((response) {
  //     var data = json.decode(response.body);
  //     int status;
  //     print(data['donnees']);
  //     status = data['status'];
  //     if (status == 200) {
  //       BlocProvider.of<SignupCubit>(context).updateField(context,
  //           field: "course", data: data['donnees'][0]["Nombre Course"] ?? "");
  //       BlocProvider.of<SignupCubit>(context).updateField(context,
  //           field: "date", data: data['donnees'][0]["Date Expiration"] ?? "");
  //     } else {
  //       print('ok');
  //     }
  //   });
  // }

  // void getDate() async {
  //   await http
  //       .get(Uri.parse(
  //           "https://tag.trans-academia.cd/Api_check_day_hours_appmobile.php"))
  //       .then((response) {
  //     var data = json.decode(response.body);
  //     int status;
  //     status = data['status'];
  //     if (status == 200) {
  //       BlocProvider.of<SignupCubit>(context).updateField(context,
  //           field: "day", data: data['donnees'][0]["Day"] ?? "");
  //       BlocProvider.of<SignupCubit>(context).updateField(context,
  //           field: "hours", data: data['donnees'][0]["Heure"] ?? "");
  //       if (data['donnees'][0]["Day"] == "1" ||
  //           data['donnees'][0]["Heure"] == "21" ||
  //           data['donnees'][0]["Heure"] == "22" ||
  //           data['donnees'][0]["Heure"] == "23") {
  //         BlocProvider.of<AbonnementCubit>(context).updateField(context,
  //             field: "valueAbonnement", data: "Kwenda vuntuka");
  //       } else {
  //         BlocProvider.of<AbonnementCubit>(context)
  //             .updateField(context, field: "valueAbonnement", data: "");
  //       }
  //     } else {
  //       print('ok');
  //     }
  //   });
  // }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return RefreshIndicator(
      displacement: 250,
      backgroundColor: Colors.white,
      color: Colors.blueAccent,
      strokeWidth: 3,
      triggerMode: RefreshIndicatorTriggerMode.onEdge,
      onRefresh: () async {
        await Future.delayed(Duration(milliseconds: 1500));
        // getCourse();
      },
      child: SafeArea(
        child: Scaffold(
            appBar: AppBarKelasi(
              onTapFunction: () => _scaffoldKey.currentState!.openDrawer(),
              title: "Accueil",
              icon: Icons.list_sharp,
              color: kelasiColor,
            ),
            key: _scaffoldKey,
            // backgroundColor: Colors.grey.withOpacity(0.1),
            drawer: drawerMenu(context),
            
            body: Container(
              height: MediaQuery.of(context).size.height,
              // color: Colors.grey.withOpacity(0.1),
              padding: const EdgeInsets.only(top: 10.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image(image: AssetImage("assets/images/logo-trans1.png")),

                  
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: CardNumberOfCourseKelasi(),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        FadeInLeft(
                          from: 50,
                          child: CardMenuKelasi(
                              icon: "assets/icons/enfantkelasi.svg",
                              title: "Enfants enregistrés"),
                        ),
                        FadeInUp(
                          from: 50,
                          child: CardMenuKelasi(
                              icon: "assets/icons/enfantkelasi.svg",
                              title: "Enfants liés"),
                        ),
                        FadeInUp(
                          from: 50,
                          child: CardMenuKelasi(
                              icon: "assets/icons/avatar.svg",
                              title: "Personne de ref."),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        FadeInLeft(
                          from: 50,
                          child: CardMenuKelasi(
                              icon: "assets/icons/geolocalisationkelasi.svg",
                              title: "Localiser l'enfant"),
                        ),
                        FadeInRight(
                          from: 50,
                          child: CardMenuKelasi(
                            icon: "assets/icons/partagekelasi.svg",
                            title: "Partager l'app",
                          ),
                        ),
                        FadeInRight(
                          from: 50,
                          child: CardMenuKelasi(
                              icon: "assets/icons/historiquekelasi.svg",
                              title: "historique payement"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

Widget drawerMenu(context) {
  final Uri _url = Uri.parse('https://trans-academia.cd');

  Future<void> launchUrlSite() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  ToastContext().init(context);

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }

  return Drawer(
    child: ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            bottom: getProportionateScreenWidth(15),
          ),
          height: getProportionateScreenWidth(150),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xff129BFF),
                  kelasiColor,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  getProportionateScreenWidth(30),
                ),
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: 30),
                  child: Container(
                    child: Row(
                      children: [
                        BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                child: state.field!['photo'] == '' ||
                                        state.field!['photo'] == "NULL"
                                    ? SvgPicture.asset(
                                        "assets/icons/avatarkelasi.svg",
                                        color: Colors.white,
                                        width: 40,
                                        // ignore: prefer_interpolation_to_compose_strings
                                      )
                                    : ImageViewerWidget(
                                        url:
                                            // ignore: prefer_interpolation_to_compose_strings
                                            "https://app.web.trans-academia.cd/app-assets/img/utilisateurs/" +
                                                state.field!["photo"],
                                        width: 50.0,
                                        height: 50.0,
                                        borderRadius:
                                            BorderRadius.circular(50.0)));
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: getProportionateScreenWidth(10),
                          ),
                        ),
                        BlocBuilder<SignupCubit, SignupState>(
                          builder: (context, state) {
                            return Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              state.field!["nomparentcomplet"],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        //Liste title

        Container(
          margin: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            bottom: getProportionateScreenWidth(20),
          ),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  getProportionateScreenWidth(30),
                ),
              )),
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                      vertical: 30),
                  child: Container(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () async {
                            launchUrlSite();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/site-trans.svg",
                                width: 30,
                              ),
                              const Text(
                                "Site web",
                                style: TextStyle(
                                  // color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Divider(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        InkWell(
                          onTap: () {
                            showToast("Bientôt disponible",
                                duration: 3, gravity: Toast.bottom);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SvgPicture.asset(
                                "assets/icons/about-trans.svg",
                                width: 30,
                              ),
                              const Text(
                                "A propos",
                                style: TextStyle(
                                  // color: Colors.black87,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        const Divider(
                          height: 1,
                        ),
                        const SizedBox(
                          height: 60.0,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                            onTap: (() async {
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
                            }),
                            child: const ButtonTransAcademia(
                                title: "Se déconnecter")),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("G.O.D | by Teams Developper"),
                            ]),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
