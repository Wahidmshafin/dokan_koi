import 'package:flutter/material.dart';
import 'components/Body.dart';
class Specialcreen extends StatelessWidget {
  static String routeName = "/specialscreen";
  @override
  Widget build(BuildContext context) {
    final Storetypeargument agrs =
    ModalRoute.of(context)?.settings.arguments as Storetypeargument;
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white.withOpacity(0.85),
      body: Body(Type: agrs.type,),
    ));
  }
}

class Storetypeargument {
  final String type;
  Storetypeargument({required this.type});
}
