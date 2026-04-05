import 'package:flutter/material.dart';

class NavigationManager {
  static goTo(BuildContext context, Widget widget){
      Navigator.push(context, MaterialPageRoute(builder: (context) => widget)); 
  }

  static goWithReplace(BuildContext context, Widget widget){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget)); 
  }
}