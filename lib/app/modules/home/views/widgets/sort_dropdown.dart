import 'package:flutter/material.dart';
import 'package:task_project/app/data/core/utils/constans/app_color.dart';
import 'package:task_project/app/data/core/utils/constans/app_sizer.dart';

class SortDropdown extends StatelessWidget {
  final Function(String) onChanged;

  const SortDropdown({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: PopupMenuButton<String>(
        onSelected: onChanged,
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'featured',
            child: Text('Featured'),
          ),
          const PopupMenuItem(
            value: 'price_low_high',
            child: Text('Price: Low to High'),
          ),
          const PopupMenuItem(
            value: 'price_high_low',
            child: Text('Price: High to Low'),
          ),
          const PopupMenuItem(
            value: 'rating',
            child: Text('Rating'),
          ),
        ],
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              Icon(
                Icons.sort,
                color: AppColors.textSecondary,
                size: 20.sp,
              ),
              SizedBox(width: 4.w),
              Text(
                'Sort',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
