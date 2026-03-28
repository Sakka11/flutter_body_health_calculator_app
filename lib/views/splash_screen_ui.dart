import 'package:flutter/material.dart';
import 'package:flutter_body_health_calculator_app/views/home_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenUiState();
}

class _SplashScreenUiState extends State<SplashScreenUi> {
  @override
  void initState() {
    // หน่วงเวลาหน้าจอ 3 วิ แล้วเปิดไปหน้า HomeUi แบบย้อนกลับไม่ได้

    Future.delayed(

        // เวลาที่จะหน่วง

        Duration(seconds: 3),

        // พอครบเวลาที่หน่วยแล้ว จะให้ทำอะไร

        () {
      // เปิดไปหน้า HomeUi แบบย้อนกลับไม่ได้

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeUi(),
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 130,
              height: 130,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Body Health Calculator',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              '© 2026 All rights reserved.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              'Created by: SAKKARIN BEER',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 40),
            CircularProgressIndicator(
              color: Colors.blueGrey[500],
            ),
          ],
        ),
      ),
    );
  }
}
