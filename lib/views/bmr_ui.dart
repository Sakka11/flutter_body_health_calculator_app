import 'package:flutter/material.dart';

class BmrUi extends StatefulWidget {
  const BmrUi({super.key});

  @override
  State<BmrUi> createState() => _BmrUiState();
}

class _BmrUiState extends State<BmrUi> {
  // 1. สร้าง ScrollController เพื่อเอาไว้คุมการเลื่อนหน้าจอ
  final ScrollController _scrollController = ScrollController();

  // สร้างตัวแปรเพื่อเก็บสถานะการเลือกเพศ
  String genderStatus = 'ชาย';

  // สร้างตัวควบคุม TextField
  TextEditingController weightCtrl = TextEditingController();
  TextEditingController heightCtrl = TextEditingController();
  TextEditingController ageCtrl = TextEditingController();

  // สร้างตัวแปรเก็บค่า BMR และคำอธิบาย
  double bmrValue = 0;
  String bmrDescription = 'กรุณากรอกข้อมูลเพื่อคำนวณ';

  // อย่าลืม dispose ตัว controller คืนหน่วยความจำเมื่อปิดหน้าจอ
  @override
  void dispose() {
    _scrollController.dispose();
    weightCtrl.dispose();
    heightCtrl.dispose();
    ageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // 2. ผูก Controller เข้ากับ SingleChildScrollView
        controller: _scrollController,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 50.0, //ห่างบน ล่าง
            horizontal: 40.0, //ห่างซ้าย ขวา
          ),
          child: Center(
            child: Column(
              children: [
                Text(
                  'คำนวณหาค่าอัตราการเผาผลาญที่ร่างกายต้องการ (BMR)',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.0),
                Image.asset(
                  'assets/images/bmr.png',
                  width: 140.0,
                  height: 140.0,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 30.0),
                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text('เพศ'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            genderStatus = 'ชาย';
                          });
                        },
                        child: Text('ชาย'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8.0),
                          ),
                          backgroundColor: genderStatus == 'ชาย'
                              ? Colors.blue[200]
                              : Colors.white,
                          fixedSize: Size(double.infinity, 50.0),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            genderStatus = 'หญิง';
                          });
                        },
                        child: Text('หญิง'),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(8.0),
                            ),
                            backgroundColor: genderStatus == 'หญิง'
                                ? Colors.pink[200]
                                : Colors.white,
                            fixedSize: Size(double.infinity, 50.0)),
                      ),
                    ),
                  ],
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
                  child: Text('ส่วนสูง ( cm. )'),
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
                SizedBox(height: 15.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('อายุ ( ปี )'),
                ),
                SizedBox(height: 10.0),
                TextField(
                  controller: ageCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: 'กรุณากรอกอายุ',
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    // 3. สั่งพับคีย์บอร์ดเก็บลงไปก่อน
                    FocusScope.of(context).unfocus();

                    double? w = double.tryParse(weightCtrl.text);
                    double? h = double.tryParse(heightCtrl.text);
                    int? a = int.tryParse(ageCtrl.text);

                    if (w == null ||
                        h == null ||
                        a == null ||
                        w <= 0 ||
                        h <= 0 ||
                        a <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'กรุณาป้อนข้อมูลให้ครบและเป็นตัวเลขที่ถูกต้อง'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    double bmr = 0;

                    setState(() {
                      if (genderStatus == 'ชาย') {
                        bmr = (10 * w) + (6.25 * h) - (5 * a) + 5;
                      } else {
                        bmr = (10 * w) + (6.25 * h) - (5 * a) - 161;
                      }
                      bmrValue = bmr;
                      bmrDescription =
                          'นี่คือพลังงานขั้นต่ำที่ร่างกายต้องการในแต่ละวัน\nเพื่อรักษาระบบการทำงานพื้นฐาน (แม้จะนอนพักผ่อนเฉยๆ)';
                    });

                    // 4. หน่วงเวลาให้คีย์บอร์ดพับลงและแอปวาด UI เสร็จ แล้วค่อยเลื่อนจอลง
                    Future.delayed(Duration(milliseconds: 300), () {
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    });
                  },
                  child: Text(
                    'คํานวณ BMR',
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
                      ageCtrl.clear();
                      bmrValue = 0;
                      genderStatus = 'ชาย';
                      bmrDescription = 'กรุณากรอกข้อมูลเพื่อคำนวณ';
                    });

                    // 5. เลื่อนจอกลับไปข้างบนสุด
                    _scrollController.animateTo(
                      0.0,
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
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'BMR',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        bmrValue.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Kcal/day',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        bmrDescription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.green[800],
                          fontWeight: FontWeight.w500,
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
