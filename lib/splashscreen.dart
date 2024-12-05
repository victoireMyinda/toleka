import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnect();
  }

  @override
  void dispose() {
    super.dispose();
  }


  checkConnect() async {
    WidgetsFlutterBinding.ensureInitialized();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // var id = prefs.getString('id');
    // var nom = prefs.getString('nom');
    // var postnom = prefs.getString('postnom');
    // var prenom = prefs.getString('prenom');

    Future.delayed(const Duration(seconds: 5)).then((val) {
      Navigator.of(context)
            .pushNamedAndRemoveUntil('/loginkelasi', (Route<dynamic> route) => false);
      // if (id == null) {    
      //   Navigator.of(context)
      //       .pushNamedAndRemoveUntil('/inscription', (Route<dynamic> route) => false);
      // } else {
      //   BlocProvider.of<SignupCubit>(context)
      //       .updateField(context, field: "nom", data: nom);
      //   BlocProvider.of<SignupCubit>(context)
      //       .updateField(context, field: "postnom", data: postnom);
      //   BlocProvider.of<SignupCubit>(context)
      //       .updateField(context, field: "prenom", data: prenom);
      //   Navigator.of(context).pushNamedAndRemoveUntil(
      //       '/routestack', (Route<dynamic> route) => false);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/splash40.gif',
                width: 300.0,
                height: 300.0,
                // fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 80.0,
              ),
              Lottie.asset(
                // 'assets/images/loader-trans.json',
                'assets/images/load3.json',
               height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
