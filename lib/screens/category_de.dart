import 'package:app_phasamue/screens/category_details.dart';
import 'package:app_phasamue/screens/home.dart';
import 'package:flutter/material.dart';

class CategoryDe extends StatefulWidget {
  const CategoryDe({Key? key}) : super(key: key);

  @override
  State<CategoryDe> createState() => _CategoryDeState();
}

class _CategoryDeState extends State<CategoryDe> {
  final title = ['คำถาม','การทักทาย','นับเลข','บุคคล','วัน เดือน ปี','เวลา'];
  final icons = [Icons.question_mark_rounded,Icons.handshake_outlined
    ,Icons.looks_one_outlined,Icons.people_alt_outlined,Icons.calendar_today_outlined,Icons.watch_later_outlined];
  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 30),
                  child: GridView.builder(
                      physics: ClampingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: .9,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          mainAxisExtent: 160
                      ),
                      itemCount: title.length,
                      itemBuilder: (context, index){
                        return GestureDetector(
                          onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetails(arg: title[index])));
                          },
                          child: Card(
                            elevation: 10,
                            child: Container(
                              height: 100,
                              margin: EdgeInsets.all(10),
                              padding: EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                          child: Icon(icons[index] , size: 50)),
                                      Text(title[index],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
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
