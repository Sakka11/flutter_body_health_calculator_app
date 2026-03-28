import 'package:flutter/material.dart';

class BmiUi extends StatefulWidget {
  const BmiUi({super.key});

  @override
  State<BmiUi> createState() => _BmiUiState();
}

class _BmiUiState extends State<BmiUi> {
  // 1. สร้าง ScrollController เพื่อเอาไว้คุมการเลื่อนหน้าจอ
  final ScrollController _scrollController = ScrollController();

  TextEditingController weightCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();

  double bmiValue = 0;
  String bmiResult = 'การแปลผล';

  // อย่าลืม dispose ตัว controller คืนหน่วยความจำเมื่อปิดหน้าจอ
  @override
  void dispose() {
    _scrollController.dispose();
    weightCtrl.dispose();
    heightCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // 2. ผูก ScrollController เข้ากับ SingleChildScrollView
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 50.0,
            horizontal: 40.0,
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'คำนวณหาค่าดัชนีมวลกาย (BMI)',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                Image.asset(
                  'assets/images/bmi.png',
                  width: 140.0,
                  height: 140.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 30.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('น้ำหนัก (kg.)'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: weightCtrl,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'กรุณากรอกน้ำหนัก',
                  ),
                ),
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('ส่วนสูง (cm.)'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: heightCtrl,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'กรุณากรอกส่วนสูง',
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    // 3. สั่งพับคีย์บอร์ดเก็บลงไปก่อน
                    FocusScope.of(context).unfocus();

                    double? w = double.tryParse(weightCtrl.text);
                    double? h = double.tryParse(heightCtrl.text);

                    if (w == null || h == null || w <= 0 || h <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('กรุณาป้อนข้อมูลให้ครบ และต้องมากกว่า 0'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    double bmi = w / ((h / 100) * (h / 100));

                    setState(() {
                      bmiValue = bmi;
                      if (bmi < 18.5) {
                        bmiResult = 'ผอมไป';
                      } else if (bmi < 22.9) {
                        bmiResult = 'หุ่นปกติ';
                      } else if (bmi < 24.9) {
                        bmiResult = 'เริ่มอ้วน';
                      } else if (bmi < 29.9) {
                        bmiResult = 'โรคอ้วนระยะที่ 1';
                      } else if (bmi < 39.9) {
                        bmiResult = 'โรคอ้วนระยะที่ 2';
                      } else {
                        bmiResult = 'เตรียมตุย...T_T';
                      }
                    });

                    // 4. หน่วงเวลานิดนึงรอให้คีย์บอร์ดพับลงและแอปวาด UI ใหม่เสร็จ แล้วค่อยเลื่อนจอลงมาล่างสุด
                    Future.delayed(Duration(milliseconds: 300), () {
                      _scrollController.animateTo(
                        _scrollController.position
                            .maxScrollExtent, // เลื่อนไปจุดล่างสุดของหน้าจอ
                        duration: Duration(
                            milliseconds:
                                500), // ความเร็วในการเลื่อน (0.5 วินาที)
                        curve: Curves.easeOut, // รูปแบบอนิเมชันให้ดูสมูท
                      );
                    });
                  },
                  child: Text(
                    'คํานวณ BMI',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    fixedSize: Size(MediaQuery.of(context).size.width, 55.0),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      weightCtrl.clear();
                      heightCtrl.clear();
                      bmiValue = 0;
                      bmiResult = 'การแปลผล';
                    });

                    // ออปชันเสริม: กดล้างข้อมูลแล้วให้เลื่อนจอกลับไปข้างบนสุด
                    _scrollController.animateTo(
                      0.0, // เลื่อนไปบนสุด
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                  child: Text(
                    'ล้างข้อมูล',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[700],
                    fixedSize: Size(MediaQuery.of(context).size.width, 55.0),
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'BMI',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        bmiValue.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        bmiResult,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
