import 'package:get/get.dart';
import 'package:task_project/app/data/models/product_models.dart';

import '../../../../services/api_end_point.dart';
import '../../../../services/newtwork_caller.dart';
import '../../../data/core/utils/logging/logger.dart';

class HomeController extends GetxController {
  final productList = Product().obs;
  final inProgress = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  /// get all athlete
  Future<void> fetchProduct() async {
    inProgress.value = true;
    try {
      final response = await NetworkCaller()
          .getRequest(
          AppUrls.product,
          //'${AppUrls.getAllAthlete}?page=$currentPage',

      );
      inProgress.value = false;
      if (response.isSuccess) {
        if (response.responseData is String) {
          //productList.value = productFromJson(response.responseData);
        } else if (response.responseData is Map<String, dynamic>) {
          productList.value = Product.fromJson(response.responseData);
        } else {
          throw Exception('Unexpected response data format');
        }
      }
    }
    catch (e) {
      AppLoggerHelper.error('Error: $e');
    } finally {
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    }
  }
}
