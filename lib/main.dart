import 'dart:async';
import 'package:flutter/material.dart';
import 'package:incomeandexpansesapp/page/Provider/financeProvider.dart';
import 'package:incomeandexpansesapp/page/addtopicpage.dart';
import 'package:provider/provider.dart';
import 'package:incomeandexpansesapp/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return FinanceProvider();
        })
      ],
      child: MaterialApp(
        theme: ThemeData(
            // primarySwatch: Colors.green, // Set the app's primary theme color
            ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => InitState();
}

class InitState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, homepageRoute);
  }

  homepageRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AddTopicPage()));
  }

  Widget build(BuildContext context) {
    return initWidget();
  }

  Widget initWidget() {
    double Hscreen = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: ([AppColors.strongping, AppColors.strongyellow]),
          ),
        ),
      ),
      Center(
        child: Container(
          //color: Colors.amber,
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/splassscreen.png"))),
        ),
      )
    ]));
  }
}
