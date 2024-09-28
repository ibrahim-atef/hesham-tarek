import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hesham_tarek/core/text_styles.dart';
import 'package:hesham_tarek/features/packages/presentation/views/packages_view.dart';
import 'package:hesham_tarek/generated/l10n.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class PackagesAndSeeAll extends StatelessWidget {
  const PackagesAndSeeAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Packages",
              style: TextStyles.semiNormalBlack17,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  elevation: WidgetStatePropertyAll(0),
                  backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const PackageView(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
              },
              child: Row(
                children: [
                  Text(
                    "${S.of(context).See} ${S.of(context).All}",
                    style: TextStyles.mediumBlue17,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.tertiary,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
