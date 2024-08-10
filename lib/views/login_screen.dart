import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/parent.dart';
import '../core/primary_button.dart';
import '../core/secondry_button.dart';
import '../core/spacev.dart';
import '../core/text_field.dart';
import 'create_excersise.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Parent(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 162.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                image: const DecorationImage(
                  image: AssetImage("assets/images/auth_bg.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 46.h),
                child: Center(
                  child: Image.asset(
                    "assets/images/app_logo.png",
                    height: 56.h,
                    width: 224.w,
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 33.h),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const TextF(hintText: "Email or Phone Number"),
                  SpaceV(height: 24.h),
                  TextF(
                    hintText: "Password",
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(4.r),
                      child: SvgPicture.asset("assets/icons/eye-off.svg"),
                    ),
                  ),
                  SpaceV(height: 12.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password ?",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  SpaceV(height: 24.h),
                  PrimaryButton(
                    buttonText: "Sign In",
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>  CreateExerciseScreen(),
                      ),
                    ),
                  ),
                  const SpaceV(),
                  Text(
                    "Or Continue with",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xff212121).withOpacity(.5),
                        fontSize: 14.sp),
                  ),
                  const SpaceV(),
                  SecondryButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>  CreateExerciseScreen(),
                      ),
                    ),
                    icon: Image.asset(
                      "assets/icons/google.png",
                      height: 25.h,
                      width: 25.w,
                    ),
                    buttonText: "Google",
                  ),
                  const SpaceV(),
                  SecondryButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>  CreateExerciseScreen(),
                      ),
                    ),
                    icon: Image.asset(
                      "assets/icons/facebook.png",
                      height: 25.h,
                      width: 25.w,
                    ),
                    buttonText: "Facebook",
                  ),
                  SpaceV(height: 24.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: 'You don\'t have an account? ',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xff212121), fontSize: 14.sp),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Sign up",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          )
                        ],
                      ),
                    ),
                  ),
                  SpaceV(height: 50.h),
                  Text(
                    "By tapping continuous, Create Account or More options, I agree to Holiday Activities terms of Service\n\nOur Terms and Privacy Policy. ",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xff95989C).withOpacity(.5),
                        fontSize: 14.sp),
                  ),
                  const SpaceV()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
