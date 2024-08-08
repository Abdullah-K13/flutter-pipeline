import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_beam/core/parent.dart';
import 'package:gym_beam/core/spacev.dart';
import 'package:gym_beam/views/profile/widgets/address_info.dart';
import 'package:gym_beam/views/profile/widgets/company_address.dart';
import 'package:gym_beam/views/profile/widgets/device_details.dart';
import 'package:gym_beam/views/profile/widgets/physical_attributes.dart';
import 'package:gym_beam/views/profile/widgets/preferences.dart';

import '../widgets/profile_info_widget.dart';
import '../widgets/user_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            "Profile",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 18.sp),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset("assets/icons/settings.svg"),
            )
          ],
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const UserInfoWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const Column(
                children: [
                  SpaceV(),
                  ProfileInfoWidget(),
                  SpaceV(),
                  AddressInfoWidget(),
                  SpaceV(),
                  CompanyAddressWidget(),
                  SpaceV(),
                  DeviceDetailsWidget(),
                  SpaceV(),
                  PreferencesWidget(),
                  SpaceV(),
                  PhysicalAttributesWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
