import 'package:get/get.dart';
import 'package:toleka/presentation/screens/home/homescreenkelasi.dart';
import 'package:toleka/presentation/screens/login/login.dart';

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(
        name: '/', page: () => const Login(), transition: Transition.cupertino),
    GetPage(
        name: '/home',
        page: () => const Homescreen(),
        transition: Transition.cupertino),
  ];
}
