import 'package:dokan_koi/screens/Cart Splash/splash.dart';
import 'package:dokan_koi/screens/Notification/notificationScreen.dart';
import 'package:dokan_koi/screens/Favourite/favourite_screen.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop%20Components/all_products.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop%20Components/mostpopularshop.dart';
import 'package:dokan_koi/screens/Shopfollow/Shop%20Components/timeshop.dart';
import 'package:dokan_koi/screens/Shopfollow/shopscreen.dart';
import 'package:dokan_koi/screens/Special%20for%20you/Specialforyouscreen.dart';
import 'package:dokan_koi/screens/cart/components/cartbody.dart';
import 'package:dokan_koi/screens/complete_profile/complete_profile_screen.dart';
import 'package:dokan_koi/screens/details/details_screen.dart';
import 'package:dokan_koi/screens/forgot_password/forgot_password_screen.dart';
import 'package:dokan_koi/screens/home/components/allcatagory.dart';
import 'package:dokan_koi/screens/home/components/search.dart';
import 'package:dokan_koi/screens/home/home_screen.dart';
import 'package:dokan_koi/screens/login_success/login_success_screen.dart';
import 'package:dokan_koi/screens/mystore/components/shopallproduct.dart';
import 'package:dokan_koi/screens/mystore/mystore.dart';
import 'package:dokan_koi/screens/mystore/product%20edit.dart';
import 'package:dokan_koi/screens/newdetails/new%20product%20components/allnewshops.dart';
import 'package:dokan_koi/screens/newdetails/new%20product%20components/maptest.dart';
import 'package:dokan_koi/screens/newdetails/newproductsscreen.dart';
import 'package:dokan_koi/screens/otp/otp_screen.dart';
import 'package:dokan_koi/screens/profile/myaccount.dart';
import 'package:dokan_koi/screens/profile/profile_screen.dart';
import 'package:dokan_koi/screens/shopmodify/components/edit_form.dart';
import 'package:dokan_koi/screens/shopmodify/components/myorders.dart';
import 'package:dokan_koi/screens/shopmodify/components/myproduct.dart';
import 'package:dokan_koi/screens/shopmodify/components/print.dart';
import 'package:dokan_koi/screens/shopmodify/components/product_form.dart';
import 'package:dokan_koi/screens/shopmodify/shopedit.dart';
import 'package:dokan_koi/screens/shopmodify/shopmodify.dart';
import 'package:dokan_koi/screens/sign_in/sign_in_screen.dart';
import 'package:dokan_koi/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';
import 'helper/helpscreen.dart';
import 'screens/sign_up/sign_up_screen.dart';

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
  HelpScreen.routeName: (context) => HelpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen3.routeName: (context) => DetailsScreen3(),
  DetailsScreen2.routeName: (context) => DetailsScreen2(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  ordsuc.routeName: (context)=>ordsuc(),
  Print.routeName: (context)=>Print(),
  ProductEdit.routeName: (context)=>ProductEdit(),
  Allnewshops.routeName: (context)=>Allnewshops(),
  MapLauncherDemo.routeName: (context)=>MapLauncherDemo(),
  MyStore.routeName: (context) => MyStore(),
  ShopAllProducts.routeName: (context) => ShopAllProducts(),
  ShopEdit.routeName: (context) => ShopEdit(),
  ShopForm.routeName: (context) => ShopForm(),
  ProductForm.routeName:(context) => ProductForm(),
  AllProducts.routeName: (context)=>AllProducts(),
  MyProducts.routeName: (context)=>MyProducts(),
  AllCatagory.routeName: (context)=>AllCatagory(),
  Specialcreen.routeName: (context)=>Specialcreen(),
  Allnewshops.routeName: (context)=>Allnewshops(),
  AllPopularShop.routeName: (context)=>AllPopularShop(),
  favscreen.routeName: (context)=>favscreen(),
  MyApp.routeName: (context)=>MyApp(),
  MyAccount.routeName: (context)=>MyAccount(),
  ShopModify.routeName: (context)=>ShopModify(),
  Notify.routeName: (context)=>Notify(),
  MyOrders.routeName: (context)=>MyOrders(),
  CartItems.routeName: (context) => CartItems(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
