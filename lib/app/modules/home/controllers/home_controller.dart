import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/api_end_point.dart';

import '../../../../services/newtwork_caller.dart';
import '../../../data/core/utils/logging/logger.dart';
import '../../../data/models/product_models.dart';

class HomeController extends GetxController {
  final RxList<Product> productList = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxBool inProgress = false.obs;
  final RxInt currentPage = 1.obs;
  final RxBool hasMoreData = true.obs;
  final RxString searchQuery = ''.obs;
  final RxString sortOption = 'featured'.obs;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    setupScrollListener();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
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

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    filterProducts();
  }

  void updateSortOption(String option) {
    sortOption.value = option;
    filterProducts();
  }

  void filterProducts() {
    if (searchQuery.isEmpty) {
      filteredProducts.value = List.from(productList);
    } else {
      filteredProducts.value = productList
          .where((product) =>
      product.title?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
          .toList();
    }

    // Apply sorting
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
      // Default sorting (featured or none)
        break;
    }
  }

  Future<void> fetchProducts() async {
    inProgress.value = true;
    try {
      final response = await NetworkCaller().getRequest(AppUrls.product);

      if (response.isSuccess) {
        List<Product> products;
        // Check the type of response data
        if (response.responseData is String) {
          products = productFromJson(response.responseData);
        } else if (response.responseData is List) {
          // If the response is already a parsed List<dynamic>
          products = (response.responseData as List)
              .map((json) => Product.fromJson(json))
              .toList();
        } else {
          throw Exception("Unexpected response format: ${response.responseData.runtimeType}");
        }

        productList.value = products;
        filterProducts();
      } else {
        Get.snackbar(
          'Error',
          'Failed to load products: ${response.statusCode}',
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
  /// Load more products (pagination)
  Future<void> loadMoreProducts() async {
    if (currentPage.value >= 2) {
      // For demo purposes, we'll simulate no more data after page 2
      hasMoreData.value = false;
      return;
    }

    inProgress.value = true;
    currentPage.value++;

    try {
      // In a real app, you would fetch the next page from API
      // For this demo, we'll just duplicate existing products with modified IDs
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

      final List<Product> moreProducts = productList.map((product) {
        return Product(
          id: product.id! + 100, // Add 100 to make IDs unique
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

    } catch (e) {
      AppLoggerHelper.error('Error loading more products: $e');
    } finally {
      inProgress.value = false;
    }
  }
}
