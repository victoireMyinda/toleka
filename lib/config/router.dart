import 'package:get/get.dart';
import 'package:toleka/presentation/screens/login/loginKelasi.dart';
import 'package:toleka/splashscreen.dart';

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(
        name: '/',
        page: () => const SplashScreen(),
        transition: Transition.cupertino),
    GetPage(
        name: '/login',
        page: () => const LoginKelasiScreen(),
        transition: Transition.cupertino),
  ];
}
