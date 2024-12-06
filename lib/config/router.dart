import 'package:get/get.dart';
import 'package:toleka/presentation/screens/home/homescreenkelasi.dart';

List<GetPage<dynamic>> getPages() {
  return [
  
    GetPage(
        name: '/',
        page: () =>  const Homescreen (),
        transition: Transition.cupertino),
  ];
}
