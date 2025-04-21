import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_project/app/data/core/utils/constans/app_sizer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: GridView.builder(
        physics:
        const NeverScrollableScrollPhysics(), // Disable scrolling for shimmer
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 4, // Show 4 shimmer placeholders
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image placeholder
                  Container(
                    height: 120.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                  ),
                  // Details placeholder
                  Padding(
                    padding: EdgeInsets.only(
                        left: 2.w, right: 8.w, top: 8.h, bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title placeholder
                        Container(
                          height: 14.sp,
                          width: double.infinity,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 8.h),
                        // Price placeholder
                        Container(
                          height: 14.sp,
                          width: 60.w,
                          color: Colors.grey[300],
                        ),
                        SizedBox(height: 8.h),
                        // Rating placeholder
                        Row(
                          children: [
                            Container(
                              height: 16.sp,
                              width: 16.sp,
                              color: Colors.grey[300],
                            ),
                            SizedBox(width: 4.w),
                            Container(
                              height: 14.sp,
                              width: 40.w,
                              color: Colors.grey[300],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}