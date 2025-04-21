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
        color: Color(0xffdbdee5),
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
          Container(
            height: 120.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
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
          ),

          // Product Details
          Padding(
            padding: EdgeInsets.only(left:2.w,right:8.w,top: 8.h,bottom: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                CustomText(
                  text: product.title ?? 'Unknown Product',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 8.h),
                CustomText(
                  text: '\$${product.price?.toStringAsFixed(2) ?? '0.00'}',
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 8.h),
                // Price and Rating
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.star,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Row(
                      children: [
                        CustomText(
                          text: product.rating?.rate?.toStringAsFixed(1) ?? '0.0',
                          fontSize: 14.sp,
                          color: AppColors.textPrimary,
                        ),
                        SizedBox(width: 4.w),
                        CustomText(
                          text: '(${(product.rating?.count.toString()) ?? '0'})',
                          fontSize: 14.sp,
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
