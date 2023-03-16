import 'dart:math';
import 'package:app_phasamue/screens/camera.dart';
import 'package:app_phasamue/screens/camera2.dart';
import 'package:app_phasamue/screens/capimg.dart';
import 'package:app_phasamue/screens/category.dart';
import 'package:app_phasamue/screens/dic_details.dart';
import 'package:app_phasamue/screens/dictionary.dart';
import 'package:app_phasamue/widgets/CustomBottomNavBar.dart';
import 'package:camera/camera.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //VideoPlayerController _controller;
  final databaseReference = FirebaseDatabase.instance.ref().child('vocab');
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  List<dynamic> _data = [];
  var randomcount = 5;

  Future<void> _getData() async {
    List<int> index = [];
    List<dynamic> data = [];
    final DataSnapshot snapshot = (await _database.ref().child('vocab').get());
    setState(() {
      _data = snapshot.value as List<dynamic>;
      while(data.length<randomcount){
        int randomindex = Random().nextInt(_data.length);
        if(index.contains(randomindex)){
          continue;
        }
        if(_data[randomindex]['title']!=null && _data[randomindex]['url']!=null){
          index.add(randomindex);
          data.add(_data[randomindex]);
        }
      }
      _data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }
    /*final snapshot = await _database.ref().child('vacab').once();
    setState(() {
      _data = snapshot.value;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }*/
  /*void _getData(){
    final databaseRef = FirebaseDatabase.instance.ref().child('title');
    databaseRef.once().then((DataSnapshot snapshot) {
      setState(() {
        _items = snapshot.value;
      });
    });
  }*/
  /*void getRandomMessage() async {
    DatabaseReference messageRaf = database.ref().child('vocal');
    int randomNumber = Random().nextInt(100) + 1;

    Query randomMessageQuery = messageRaf.orderByChild('number').equalTo(
        randomNumber);
    randomMessageQuery.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic> messageMap = snapshot.value;
      String text = messageMap.values.first['title'];
      print(text);
    });
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Text('PHASA', style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.pink
            ),),
            SizedBox(width: 10,),*/
            Image.asset(
                'assets/icons/sign-language.png',
            fit: BoxFit.contain,
            height: 40,),
            /*SizedBox(width: 10,),
            Text('MUE', style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.pink
            ),)*/
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              children: [
                /*Row(
                  children: [
                    Text("PHASA MUE",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold, color:Colors.pink)),
                    Expanded(child: Container()),
                    //Text("PHASA MUE",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold, color:Colors.amber)),
                  ],
                ),*/
                //SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.centerRight,
                          /*Alignment(0.8, 1),*/
                          colors: [
                            Colors.pink.shade100.withOpacity(0.9),
                            Colors.pink.shade100.withOpacity(0.9)
                          ]
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topRight: Radius.circular(80),
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(5,10),
                            blurRadius: 20,
                            color: Colors.amber.shade50.withOpacity(0.2)
                        )
                      ]
                  ),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text(
                          "ยินดีต้อนรับเข้าสู่แอปพลิเคชัน",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "PHASA MUE",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(height: 25,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                //Icon(Icons.timer, size: 20,),
                                SizedBox(width: 10),
                                Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  /*boxShadow: [
                                    BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        offset: Offset(4,8)
                                    )
                                  ]*/
                              ),
                              child: Image.asset(
                                'assets/icons/letter-r.png',
                              height: 70, width: 80,),
                              /*Icon(
                         cd       Icons.play_circle_fill,
                                color: Colors.white, size: 60,
                              ),*/
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: InkWell(
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.redAccent,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: Offset(8,10),
                                color: Colors.black.withOpacity(0.3)
                            ),
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(-1,-5),
                                color: Colors.grey.withOpacity(0.3)
                            )
                          ]
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          //Icon(Icons.camera_alt_rounded , size: 50,),
                          Image.asset(
                            'assets/icons/image.png',
                            width: 45,
                          ),
                          SizedBox(width: 5),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'แปลภาษามือ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,fontSize: 20
                                  ),
                                  /*style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,fontSize: 20),*/
                                ),
                                Text(
                                  'แปลภาษามือเป็นภาษาไทย จากกล้องแบบทันที',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.pink.shade400,fontSize: 12
                                  ),
                                  /*style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.purpleAccent,fontSize: 10),*/
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                        Navigator.push(context,MaterialPageRoute(builder: (_) => Category()));
                      //292 error
                      /*await availableCameras().then((value) => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Camera(cameras: value))));*/
                      /*Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ,
                          )
                      );*/
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: InkWell(
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.redAccent,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                offset: Offset(8,10),
                                color: Colors.black.withOpacity(0.3)
                            ),
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(-1,-5),
                                color: Colors.grey.withOpacity(0.3)
                            )
                          ]
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          //Icon(Icons.menu_book_rounded , size: 50,),
                          Image.asset(
                            'assets/icons/dictionary-on.png',
                            width: 45 , height: 100,
                          ),
                          SizedBox(width: 5),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 15,
                              left: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'พจนานุกรมภาษามือ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,fontSize: 20
                                  ),
                                  /*style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,fontSize: 20),*/
                                ),
                                Text(
                                  'รวบรวมคำศัพท์พื้นฐานที่ใข้ในชีวิตประจำวัน',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.pink.shade400,fontSize: 12
                                  ),
                                  /*style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.purpleAccent,fontSize: 10),*/
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dictionary(),
                          )
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      "คำศัพท์ที่น่าสนใจ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                    )
                  ],
                ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _data.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 160.0,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => dicdetails(arg: _data[index]['title'],url: _data[index]['url'], des: _data[index]['description'],),
                      )
                      );
                    },
                    child: Card(
                      elevation: 4,  // Change this
                      shadowColor: Colors.grey.withOpacity(0.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Wrap(
                        children: [
                          ListTile(
                            title: Center(child: Text(_data[index]['title'])),
                          ),
                           Padding(
                             padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                                     child: Image.asset('assets/images/random.png', fit: BoxFit.cover,)
                                 ),
                           )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
                SizedBox(height: 10,)
        /*SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _data.length,
            /*gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1.0,
            ),*/
            itemBuilder: (context, index) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      child:

                    ),
                    Text(_data[index]['title']),
                  ],
                ),
              );
            },
          ),
        )*/
                /*Column(
                  children: <Widget>[
                    Expanded(child: ListView.builder(
                      itemCount: 5, //(.length.toDouble()/2).toInt()
                        itemBuilder: (_,i){

                          return Row(
                            children: [
                              Container(
                                width: 200,
                                height: 170,
                                padding: EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/christmas-wreath.png"
                                    )
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 3,
                                      offset: Offset(5,5),
                                      color: Colors.grey.withOpacity(0.1)
                                    ),
                                    BoxShadow(
                                        blurRadius: 3,
                                        offset: Offset(-5,-5),
                                        color: Colors.grey.withOpacity(0.1)
                                    ),
                                  ]
                                ),
                                child: Center(
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "Hi",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        )
                    ),
                  ],
                ),*/
              ],
            ),
          )
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
