import 'package:app_phasamue/screens/home.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({Key? key, required String arg}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    final question = ['อย่างไร','เท่าไหร่','อะไร','ที่ไหน','ใคร','ทำไม'];
    final greet = ['หูหนวก','สบายดี','สนุก','โชคดี','สวัสดี','พบ','ชื่อ','ไม่เป็นไร','ไม่','หูดี','จดจำ','พบกันใหม่','ป่วย','ขอโทษ','เรียน','นามสกุล','ขอบคุณ','ไม่สบายใจ','ใช่'];
    final number = ['8 (แปด)','800 (แปดร้อย)','18 (สิบแปด)','80 (แปดสิบ)','11 (สิบเอ็ด)','15 (สิบห้า)','50 (ห้าสิบ)','5 (ห้า)','500 (ห้าร้อย)','4 (สี่)','400 (สี่ร้อย)','14 (สิบสี่)','40 (สี่สิบ)','9 (เก้า)','900 (เก้าร้อย)','19 (สิบเก้า)','90 (เก้าสิบ)','1 (หนึ่ง)','100 (หนึ่งร้อย)','100000 (หนึ่งแสน)','1000000 (หนึ่งล้าน)','1000 (หนึ่งพัน)','7 (เจ็ด)','700 (เจ็ดร้อย)','17 (สิบเจ็ด)','70 (เจ็ดสิบ)','6 (หก)','600 (หกร้อย)','16 (สิบหก)','60 (หกสิบ)','10 (ten)','10000 (หนึ่งหมื่น)','13 (สิบสาม)','30 (สามสิบ)','3 (สาม)','300 (สามร้อย)','12 (สิบสอง)','20 (ยี่สิบ)','200 (สองร้อย)'];
    final person = ['ผู้ใหญ่','เด็กทารก','เด็ก','คนชรา','เขา','ฉัน','ผู้ชาย','คน','วัยรุ่น','พวกเรา','ผู้หญิง','คุณ','หนุ่มสาว'];
    final date = ['มะรืน','เมื่อวานซืน','วัน','วันจันทร์','เดือน','วันเสาร์','วันอาทิตย์','วันอังคาร','วันนี้','พรุ่งนี้','วันพุธ','สัปดาห์','ปี','เมื่อวาน'];
    final time = ['บ่าย','ทั้งคืน','กลางวัน','ตอนเย็น','เที่ยงคืน','ตอนเช้า','กลางคืน','เวลา'];
    return Scaffold(
      body: Container(
        color: Colors.pink.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 30,left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),)
                        );
                      }, icon: new Icon(Icons.arrow_back_ios)),
                      //Icon(Icons.arrow_back_ios, size: 20,color: Colors.black),
                      Expanded(child: Container()),
                      IconButton(onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),)
                        );
                      }, icon: new Icon(Icons.close_rounded)),
                    ],
                  ),
                  Text("แปลภาษามือ",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black
                    ),),
                  Text("เลือกหมวดที่คุณต้องการแปล",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                    ),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index){
                        return ListTile(
                          onTap: () async {
                            /*await availableCameras().then((value) => {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ImgCap(cameras: value, arg: title[index])))
                            });*/
                          },
                          title: ListTile(
                            title:
                            Text(time[index]),
                          )
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
