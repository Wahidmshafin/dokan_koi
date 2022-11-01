import 'package:dokan_koi/screens/Shopfollow/Shop%20Components/all_products.dart';
import 'package:dokan_koi/screens/Cart Splash/splash.dart';
import 'package:dokan_koi/screens/cart/cart_screen.dart';
import 'package:dokan_koi/screens/complete_profile/complete_profile_screen.dart';
import 'package:dokan_koi/screens/details/details_screen.dart';
import 'package:dokan_koi/screens/mystore/mystore.dart';
import 'package:dokan_koi/screens/newdetails/newproductsscreen.dart';
import 'package:dokan_koi/screens/forgot_password/forgot_password_screen.dart';
import 'package:dokan_koi/screens/home/home_screen.dart';
import 'package:dokan_koi/screens/login_success/login_success_screen.dart';
import 'package:dokan_koi/screens/otp/otp_screen.dart';
import 'package:dokan_koi/screens/profile/profile_screen.dart';
import 'package:dokan_koi/screens/shopmodify/components/ShopEdit.dart';
import 'package:dokan_koi/screens/shopmodify/shopmodify.dart';
import 'package:dokan_koi/screens/sign_in/sign_in_screen.dart';
import 'package:dokan_koi/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'package:dokan_koi/screens/Shopfollow/shopscreen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen3.routeName: (context) => DetailsScreen3(),
  DetailsScreen2.routeName: (context) => DetailsScreen2(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  ordsuc.routeName: (context)=>ordsuc(),
  MyStore.routeName: (context) => MyStore(),
  shopedit.routeName: (context) => shopedit(),
  AllProducts.routeName: (context)=>AllProducts(),
  ShopModify.routeName: (context)=>ShopModify(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
