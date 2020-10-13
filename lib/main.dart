import 'package:flutter/material.dart';
import 'package:newseventsapp/page_view.dart';

import 'NewsTabs.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'News',
    theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
    home: new IntroPageView(),
    initialRoute: '/',
    routes: {
      '/IntroPageView': (context) => IntroPageView(),
      '/NewsTab': (context) => new NewsTabs(),

    },
  ));
}




