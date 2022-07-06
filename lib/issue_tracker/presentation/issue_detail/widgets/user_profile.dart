import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_issue_tracker/constants/colors.dart';
import 'package:flutter_issue_tracker/core/extension/string_extension.dart';
import 'package:flutter_issue_tracker/core/typography.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/issue_util.dart';
import 'package:flutter_issue_tracker/issue_tracker/presentation/utils/time_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.name,
    required this.profileUrl,
    required this.authorAssociation,
    required this.createdAt,
  });

  final String? name;
  final String profileUrl;
  final String authorAssociation;
  final String createdAt;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: SizedBox(
            height: 40.sp,
            width: 40.sp,
            child: CachedNetworkImage(
              imageUrl: profileUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, dynamic error) => const CircleAvatar(
                backgroundColor: AppColors.fadeGray,
                child: Icon(
                  Icons.person,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.sp),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: name?.capitalizeFirstLetter() ?? '',
                style: AppTypography.style(
                  isBold: true,
                  textType: TextType.body,
                  textSize: TextSize.small,
                ).copyWith(color: Theme.of(context).colorScheme.onSurface),
                children: [
                  TextSpan(
                    text: ' opened this '
                        '${TimeUtil.getTimeInAgoFormat(createdAt)} ago',
                    style: AppTypography.style(
                      textType: TextType.label,
                      textSize: TextSize.small,
                    ),
                  )
                ],
              ),
            ),
            Text(
              IssueUtil.getFormattedAuthorAssociation(authorAssociation),
              style: AppTypography.style(
                textType: TextType.label,
                textSize: TextSize.small,
              ).copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        )
      ],
    );
  }
}
