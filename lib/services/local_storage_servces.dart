import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService extends GetxService {
  late Box<String> _productBox;

  Future<LocalStorageService> init() async {
    await Hive.initFlutter();
    _productBox = await Hive.openBox<String>('products');
    return this;
  }

  void cacheProducts(String url, String data) {
    _productBox.put(url, data);
  }

  String? getProductsFromCache(String url) {
    return _productBox.get(url);
  }

  void clearCache() {
    _productBox.clear();
  }
}
