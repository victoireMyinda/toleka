import 'package:get/get.dart';
import 'package:toleka/presentation/screens/home/homescreendart';
import 'package:toleka/presentation/screens/login/login.dart';
import 'package:toleka/routestack.dart';

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(
        name: '/', page: () => const Login(), transition: Transition.cupertino),
    GetPage(
        name: '/routestack',
        page: () => const RouteStack(),
        transition: Transition.cupertino),
    GetPage(
        name: '/home',
        page: () => const Homescreen(),
        transition: Transition.cupertino),
  ];
}
