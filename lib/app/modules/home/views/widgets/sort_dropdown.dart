import 'package:flutter/material.dart';
import 'package:task_project/app/data/core/common/widgets/custom_text.dart';
import 'package:task_project/app/data/core/utils/constans/app_color.dart';
import 'package:task_project/app/data/core/utils/constans/app_sizer.dart';
import 'package:task_project/app/data/core/utils/constans/icon_path.dart';

class SortDropdown extends StatelessWidget {
  final Function(String) onChanged;

  const SortDropdown({
    super.key,
    required this.onChanged,
  });

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: 'Sort By',   fontSize: 18.sp,
                     ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        size: 24.sp,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Divider(height: 1.h, color: AppColors.textSecondary.withOpacity(0.2)),
              SizedBox(height: 8.h),
              // Sort Options
              //_buildSortOption(context, 'Featured', 'featured'),
              _buildSortOption(context, 'Price: High to Low', 'price_high_low'),
              _buildSortOption(context, 'Price: Low to High', 'price_low_high'),
              _buildSortOption(context, 'Rating', 'rating'),
              SizedBox(height: 16.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(BuildContext context, String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w400,
        ),
      ),
      onTap: () {
        onChanged(value); // Trigger the callback with the selected value
        Navigator.pop(context); // Close the bottom sheet
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showSortBottomSheet(context),
      child: Container(
        padding: EdgeInsets.only(top: 8.h),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Image.asset(
            IconPath.filer,
            height: 36.h,
          ),
        ),
      ),
    );
  }
}