import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/app/data/core/common/widgets/custom_text.dart';
import 'package:task_project/app/data/core/utils/constans/app_color.dart';
import 'package:task_project/app/data/core/utils/constans/app_sizer.dart';
import 'package:task_project/app/data/core/utils/constans/icon_path.dart';
import 'package:task_project/app/modules/home/views/screen/search_screen.dart';
import 'package:task_project/app/modules/home/views/widgets/product_card.dart';
import 'package:task_project/app/modules/home/views/widgets/shimmer_loading.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height:
                    16.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.h),
                color: Colors.transparent,
                border: Border.all(width: 1,color: Color(0xffD1D5DB))
              ),
              margin: EdgeInsets.only(left: 16.w, right :16.w,top: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: InkWell(
                onTap: (){
                  Get.to(()=> SearchScreen());
                },
                child: Row(
                  children: [
                    Image.asset(IconPath.search,height: 16.h,),
            
                    SizedBox(width: 8.w),
                    CustomText(
                      text: 'Search Anythings...',
                      color:  Color(0xff9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Obx(() {
                /// Show loading indicator when fetching initial data
                if (controller.inProgress.value &&
                    controller.productList.isEmpty) {
                  return const ShimmerLoading();
                }
            
                /// Show empty state if no products are available
                if (controller.filteredProducts.isEmpty) {
                  return const Center(
                    child: Text(
                      'No products found',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  );
                }
            
                /// Show the product grid
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      controller.currentPage.value = 1;
                      controller.hasMoreData.value = true;
                      await controller.fetchProducts();
                    },
                    child: GridView.builder(
                      controller: controller.scrollController,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                      itemCount:
                          controller.filteredProducts.length +
                          (controller.inProgress.value &&
                                  controller.productList.isNotEmpty
                              ? 2
                              : 0),
                      itemBuilder: (context, index) {
                        /// Show loading at the end for pagination
                        if (index >= controller.filteredProducts.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
            
                        final product = controller.filteredProducts[index];
                        return ProductCard(product: product);
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
