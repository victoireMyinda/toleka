import 'package:get/get.dart';
import 'package:toleka/presentation/screens/login/loginKelasi.dart';

List<GetPage<dynamic>> getPages() {
  return [
  
    GetPage(
        name: '/',
        page: () => const LoginKelasiScreen(),
        transition: Transition.cupertino),
  ];
}
