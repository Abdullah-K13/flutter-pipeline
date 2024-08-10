import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/form_section.dart';
import '../core/parent.dart';
import '../core/primary_button.dart';
import '../core/spacev.dart';
import '../core/text_field.dart';
import 'login_screen.dart';
import '../core/theme.dart';


class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isTablet = constraints.maxWidth > 600;

      return ScreenUtilInit(
        designSize: isTablet ? const Size(768, 1024) : const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Gym-Beam',
            theme: themeLight(context),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const RegisterScreen(),
            //home: BluetoothDevicePage(),
          );
        },
      );
    });
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          centerTitle: false,
          title: Text(
            "Registration",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SpaceV(),
                Center(
                    child: Image.asset("assets/images/app_logo.png",
                        height: 56.h, width: 224.w)),
                const SpaceV(),
                Center(
                  child: Text(
                    "Sign up to enroll",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xff212121), fontSize: 14.sp),
                  ),
                ),
                const SpaceV(),
                const TextF(hintText: "User Name*"),
                const SpaceV(),
                const TextF(hintText: "Email*"),
                const FormSection(title: "Personal Info"),
                const TextF(hintText: "First Name*"),
                const SpaceV(),
                const TextF(hintText: "Last Name*"),
                const SpaceV(),
                const TextF(hintText: "Phone*"),
                const SpaceV(),
                const TextF(hintText: "Gender*"),
                const SpaceV(),
                const TextF(hintText: "Date of Birth*"),
                const FormSection(title: "Address Info"),
                const TextF(hintText: "Address1*"),
                const SpaceV(),
                const TextF(hintText: "Address2"),
                const SpaceV(),
                const TextF(hintText: "City*"),
                const SpaceV(),
                const TextF(hintText: "Postal Code*"),
                const SpaceV(),
                const TextF(hintText: "Country*"),
                const SpaceV(),
                Row(
                  children: [
                    const Text("Sports*"),
                    const Spacer(),
                    Text("Select One",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xff212121).withOpacity(.5),
                            fontSize: 14.sp))
                  ],
                ),
                const SpaceV(),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8.0, // horizontal spacing
                  runSpacing: 4.0, // vertical spacing
                  children: [
                    {"icon": "assets/icons/gym_icon.svg", "label": "Gym"},
                    {
                      "icon": "assets/icons/football_icon.svg",
                      "label": "Football"
                    },
                    {"icon": "assets/icons/tennis_icon.svg", "label": "Tennis"},
                    {
                      "icon": "assets/icons/baseball_icon.svg",
                      "label": "Baseball"
                    },
                    {
                      "icon": "assets/icons/badminton_icon.svg",
                      "label": "Badminton"
                    },
                    {
                      "icon": "assets/icons/cricket_icon.svg",
                      "label": "Cricket"
                    },
                    {"icon": "assets/icons/hockey_icon.svg", "label": "Hockey"},
                  ]
                      .map(
                        (e) => Container(
                          margin: EdgeInsets.only(bottom: 12.h),
                          child: ChoiceChip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                                width: 1.r,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 12.5.h, horizontal: 13.w),
                            avatar: e["icon"] != null
                                ? SvgPicture.asset(
                                    e["icon"]!,
                                    colorFilter: const ColorFilter.mode(
                                        Color(0xff212121), BlendMode.srcIn),
                                  )
                                : null,
                            label: Text(
                              e["label"] ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: const Color(0xff212121),
                                      fontSize: 14.sp),
                            ),
                            selected: false,
                            onSelected: (selected) {},
                          ),
                        ),
                      )
                      .toList(),
                ),
                const FormSection(
                  title: "Device Details",
                  isShowPadding: false,
                ),
                const SpaceV(),
                const TextF(hintText: "Device Usage"),
                const SpaceV(),
                const TextF(hintText: "Workout frequency per week"),
                const FormSection(title: "Preferences"),
                const TextF(hintText: "Workout types"),
                const SpaceV(),
                const TextF(hintText: "Fitness goals"),
                const FormSection(title: "Physical Attributes"),
                Row(
                  children: [
                    const Expanded(child: TextF(hintText: "Height")),
                    SizedBox(width: 16.w),
                    const Expanded(child: TextF(hintText: "Weight"))
                  ],
                ),
                const SpaceV(),
                const TextF(hintText: "Body fat Percentage"),
                const SpaceV(),
                const TextF(hintText: "Muscle Mass"),
                const FormSection(title: "Company Info"),
                const TextF(hintText: "Name"),
                const SpaceV(),
                const TextF(hintText: "Number"),
                const SpaceV(),
                const TextF(hintText: "Vat Registration. Number"),
                const FormSection(title: "Company Address"),
                const TextF(hintText: "Address1"),
                const SpaceV(),
                const TextF(hintText: "Address2"),
                const SpaceV(),
                const TextF(hintText: "City"),
                const SpaceV(),
                const TextF(hintText: "Postal Code"),
                const SpaceV(),
                const TextF(hintText: "Country"),
                const FormSection(title: "Health Metrics"),
                const TextF(hintText: "Blood Pressure"),
                const SpaceV(),
                const TextF(hintText: "Heart Rate"),
                const SpaceV(),
                const TextF(hintText: "Cholesterol"),
                SpaceV(height: 36.h),
                PrimaryButton(
                  buttonText: "Next",
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  ),
                ),
                const SpaceV(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
