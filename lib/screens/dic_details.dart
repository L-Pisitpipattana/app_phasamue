import 'dart:developer';
import 'dart:ui';

import 'package:app_phasamue/screens/dictionary.dart';
import 'package:app_phasamue/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';


class dicdetails extends StatefulWidget {
  final String arg;
  final String url;
  final String des;
  const dicdetails({Key? key, required this.arg, required this.des, required this.url}) : super(key: key);


  @override
  State<dicdetails> createState() => _dicdetailsState();
}

class _dicdetailsState extends State<dicdetails> {
  late final PodPlayerController _controllerpod;

  //ปรับตัววีดีโอกับการเปลื่ยนความชัดของวีดีโอ
  @override
  void initState(){
    super.initState();
    _controllerpod = PodPlayerController(
        playVideoFrom: PlayVideoFrom.network(widget.url),
    podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: false,
      //forcedVideoFocus: false,
      videoQualityPriority: [1080,720,360]
    )
    )..initialise();
    super.initState();
  }

  @override
  void dispose(){
    _controllerpod.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.pink.shade100,
          title: Row(
            children: [
              Expanded(child: Container()),
              Text(widget.arg, style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold, color: Colors.black)),
              Expanded(child: Container()),
              IconButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),)
                );
              }, icon: new Icon(Icons.close_rounded, color: Colors.black,)),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)
            )
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30,left: 30, right: 30),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Column(
                children: [
                  //Text(widget.arg, style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold)),
                  SizedBox(height: 20,),
                  PodVideoPlayer(
                      controller: _controllerpod),
                ],
              ),
              SizedBox(height: 30,),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                height: 220,
                width:double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30), //border corner radius
                  boxShadow:[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), //color of shadow
                      spreadRadius: 2.0, //spread radius
                      blurRadius: 7, // blur radius
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child:Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("คำอธิบายการทำท่า", style: TextStyle(fontSize:25, fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(widget.des, style: TextStyle(fontSize:20,),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
