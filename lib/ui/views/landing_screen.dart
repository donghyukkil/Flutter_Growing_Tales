import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/custom_theme_extension.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/social_login_button.dart';
import '../../core/widgets/circular_back_button.dart';
import '../../ui/view_models/users_view_model.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: AppConstants.designSize,
      builder: (context, child) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          home: Scaffold(
            appBar: AppBar(
              title: Text(
                'GrowingTales',
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: CircularBackButton(
                  iconSize: 20.0.w,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            body: Consumer<UsersViewModel>(
              builder: (context, userViewModel, child) {
                return Container(
                  color: AppColors.followButtonColor,
                  child: Padding(
                    padding: Theme.of(context).paddingHorizontal20Vertical10,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 230.h,
                          child: Image(
                              image: AssetImage('assets/big-image-2.png')),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(25.w),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                20.r,
                              ),
                              border: Border(
                                top: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                left: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 7,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Login',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'Log in to make \nyour parenting story unforgettable.',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SocialLoginButton(
                                  assetPath: 'assets/appleid_button@2x.png',
                                  text: 'Sign in with Apple',
                                  backgroundColor: Colors.black,
                                  onPressed: () {},
                                  imageFit: BoxFit.cover,
                                ),
                                SizedBox(height: 10.h),
                                SocialLoginButton(
                                  assetPath: 'assets/ios_light_rd_na@1x.png',
                                  text: 'Sign in with Google',
                                  backgroundColor: AppColors.googleButtonColor,
                                  onPressed: () async {
                                    final userViewModel =
                                        context.read<UsersViewModel>();
                                    await userViewModel.loginWithGoogle();

                                    if (userViewModel.currentUser != null) {
                                      final snackBar = SnackBar(
                                        content: Text('Logged in successfully'),
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar)
                                          .closed
                                          .then((reason) {
                                        //todo: BlackScreen issue occur. (Navigator, Go router study).
                                        //ref: When you navigate using the Router or a declarative routing package, each route on the Navigator is page-backed, meaning it was created from a Page using the pages argument on the Navigator constructor. Conversely, any Route created by calling Navigator.push or showDialog will add a pageless route to the Navigator. If you are using a routing package, Routes that are page-backed are always deep-linkable, whereas pageless routes are not.
                                        // Navigator.of(context).pop();
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Login failed'),
                                        ),
                                      );
                                    }
                                  },
                                  imageFit: BoxFit.cover,
                                ),
                                SizedBox(height: 15.h),
                                SocialLoginButton(
                                  assetPath:
                                      'assets/kakaotalk_sharing_btn_medium.png',
                                  text: 'Login with Kakao',
                                  backgroundColor: AppColors.kakaoButtonColor,
                                  onPressed: () {},
                                  imageFit: BoxFit.contain,
                                  textStyle: AppConstants.googleStyle
                                      .copyWith(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
