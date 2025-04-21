import 'package:flutter/material.dart';
import 'package:task_project/app/data/core/utils/constans/app_color.dart';
import 'package:task_project/app/data/core/utils/constans/app_sizer.dart';

import '../../../../data/core/common/widgets/custom_text.dart';
import '../../../../data/models/product_models.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
            child: SizedBox(
              height: 120.h,
              width: double.infinity,
              child: Image.network(
                product.image ?? '',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),

          // Product Details
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                CustomText(
                  text: product.title ?? 'Unknown Product',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 4.h),

                // Category
                // CustomText(
                //   text: product.category ?? '',
                //   fontSize: 12.sp,
                //   color: AppColors.textSecondary,
                //   maxLines: 1,
                //   textOverflow: TextOverflow.ellipsis,
                // ),

                SizedBox(height: 8.h),

                // Price and Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),

                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: AppColors.secondary,
                          size: 16.sp,
                        ),
                        SizedBox(width: 2.w),
                        CustomText(
                          text: '${product.rating?.rate?.toStringAsFixed(1) ?? '0.0'}',
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
