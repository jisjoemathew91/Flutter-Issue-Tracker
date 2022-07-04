import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/theme/presentation/typography.dart';

class FilterListItem extends StatelessWidget {
  const FilterListItem({
    super.key,
    required this.text,
    required this.onTap,
    this.isSelected = true,
  });

  final String text;
  final GestureTapCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        dense: true,
        tileColor: isSelected ? AppColors.fadeGray : Colors.transparent,
        trailing: isSelected
            ? const Icon(
                Icons.check,
                color: AppColors.green,
              )
            : null,
        title: Text(
          text,
          style: AppTypography.style(
            isBold: true,
            textType: TextType.body,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
