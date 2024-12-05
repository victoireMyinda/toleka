import 'package:get/get.dart';
import 'package:toleka/splashscreen.dart';

List<GetPage<dynamic>> getPages() {
  return [
    GetPage(
        name: '/',
        page: () => const SplashScreen(),
        transition: Transition.cupertino),
  ];
}
