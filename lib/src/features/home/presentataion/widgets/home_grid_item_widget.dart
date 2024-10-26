import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tabark_innov8/src/core/extenstions/size_extention.dart';
import 'package:tabark_innov8/src/core/utils/app_values.dart';

class HomeGridItemWidget extends StatelessWidget {
  final GridItemData item;

  const HomeGridItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(AppSize.s16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(item.icon, width: 50, height: 50),
            const SizedBox(height: 8),
            Text(
              item.title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridItemData {
  final String title;
  final Color color;
  final String icon;
  final VoidCallback onTap;

  GridItemData({
    required this.title,
    required this.color,
    required this.icon,
    required this.onTap,
  });
}
