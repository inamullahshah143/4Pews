import 'package:four_pews_admin/responsive.dart';
import 'package:four_pews_admin/screens/dashboard/components/my_fields.dart';
import 'package:four_pews_admin/screens/dashboard/components/recent_files.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import 'components/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: SafeArea(
        child: Column(
          children: [
            const Header(),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const MyFiles(),
                      const SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
              ],
            ),
            const Expanded(child: RecentFiles()),
          ],
        ),
      ),
    );
  }
}
