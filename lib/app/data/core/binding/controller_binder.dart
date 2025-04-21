import 'package:get/get.dart';
import 'package:task_project/app/modules/home/controllers/home_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
      fenix: true,
    );
  }}