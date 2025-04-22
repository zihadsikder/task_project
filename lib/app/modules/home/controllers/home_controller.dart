import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:task_project/app/data/core/utils/logging/logger.dart';
import 'package:task_project/app/data/models/product_models.dart';

import '../../../../services/api_end_point.dart';
import '../../../../services/newtwork_caller.dart';

class HomeController extends GetxController {
  final RxList<Product> productList = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxBool inProgress = false.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final RxString searchQuery = ''.obs;
  final RxString sortOption = 'featured'.obs;
  final ScrollController scrollController = ScrollController();
  final RxBool isConnected = true.obs;
  late Box<Product> productBox;

  @override
  void onInit() {
    super.onInit();
    initializeHive();
    checkConnectivity();
    setupConnectivityListener();
    setupScrollListener();
    fetchOrLoadProducts();
  }

  @override
  void onClose() {
    scrollController.dispose();
    productBox.close();
    super.onClose();
  }
/// hive
  void initializeHive() async {
    productBox = Hive.box<Product>('products');
  }

  void setupScrollListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!inProgress.value && hasMoreData.value) {
          loadMoreProducts();
        }
      }
    });
  }
/// internet connectivity
  void setupConnectivityListener() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      isConnected.value = result != ConnectivityResult.none;
      if (isConnected.value) {
        fetchOrLoadProducts(); // Retry fetching data when connection is restored
      }
    });
  }

  Future<void> checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    isConnected.value = result != ConnectivityResult.none;
  }
/// search function
  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  void updateSortOption(String option) {
    sortOption.value = option;
    filterProducts();
  }
/// filter function
  void filterProducts() {
    if (searchQuery.isEmpty) {
      filteredProducts.value = List.from(productList);
    } else {
      filteredProducts.value = productList
          .where((product) =>
      product.title?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
          .toList();
    }

    /// Apply sorting
    switch (sortOption.value) {
      case 'price_low_high':
        filteredProducts.sort((a, b) => (a.price ?? 0).compareTo(b.price ?? 0));
        break;
      case 'price_high_low':
        filteredProducts.sort((a, b) => (b.price ?? 0).compareTo(a.price ?? 0));
        break;
      case 'rating':
        filteredProducts.sort((a, b) => (b.rating?.rate ?? 0).compareTo(a.rating?.rate ?? 0));
        break;
      default:
        break;
    }
  }
/// fetchOrLoadProducts
  Future<void> fetchOrLoadProducts() async {
    if (isConnected.value) {
      await fetchProducts();
    } else {
      loadFromHive();
    }
  }
/// fetchProducts
  Future<void> fetchProducts() async {
    inProgress.value = true;
    try {
      final response = await NetworkCaller().getRequest(AppUrls.product);

      if (response.isSuccess) {
        List<Product> products;

        if (response.responseData is String) {
          products = productFromJson(response.responseData);
        } else if (response.responseData is List) {

          products = (response.responseData as List)
              .map((json) => Product.fromJson(json))
              .toList();
        } else {
          throw Exception("Unexpected response format: ${response.responseData.runtimeType}");
        }

        productList.value = products;
        filterProducts();

        /// Save to Hive
        await productBox.clear(); // Clear old data
        await productBox.addAll(products); // Save new data
      } else {
        Get.snackbar(
          'Error',
          'Failed to load products',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      AppLoggerHelper.error('Error fetching products: $e');
      Get.snackbar(
        'Error',
        'An unexpected error occurred: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      inProgress.value = false;
    }
  }

  void loadFromHive() {
    final cachedProducts = productBox.values.toList();
    if (cachedProducts.isNotEmpty) {
      productList.value = cachedProducts;
      filterProducts();
    } else {
      productList.clear();
      filteredProducts.clear();
    }
  }

  /// Load more products (pagination)
  Future<void> loadMoreProducts() async {
    if (!isConnected.value) {
      Get.snackbar(
        'No Internet',
        'Cannot load more products offline',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    if (currentPage.value >= 2) {
      hasMoreData.value = false;
      return;
    }
    inProgress.value = true;
    currentPage.value++;
    try {
      await Future.delayed(const Duration(seconds: 1));

      final List<Product> moreProducts = productList.map((product) {
        return Product(
          id: product.id! + 100,
          title: product.title,
          price: product.price,
          description: product.description,
          category: product.category,
          image: product.image,
          rating: product.rating,
        );
      }).toList();

      productList.addAll(moreProducts);
      filterProducts();

      /// Save updated product list to Hive
      await productBox.clear();
      await productBox.addAll(productList);

    } catch (e) {
      AppLoggerHelper.error('Error loading more products: $e');
    } finally {
      inProgress.value = false;
    }
  }
}