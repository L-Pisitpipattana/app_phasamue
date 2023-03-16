import 'dart:async';
import 'dart:convert';
import 'package:app_phasamue/screens/category.dart';
import 'package:app_phasamue/screens/home.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

//กล้องเต็มจอ ไม่error ไม่เจอ null

class ImgCap extends StatefulWidget {
  final String arg;
  const ImgCap({Key? key, required this.cameras, required this.arg}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<ImgCap> createState() => _ImgCapState();
}

class _ImgCapState extends State<ImgCap> {
  late CameraController _controller;
  bool _isRearCameraSelected = true;
  late final String arg;
  bool isCapturing = false;
  bool _showContainer = false;
  Timer? _timer;
  late IO.Socket socket;
  var result = "";
  var imagecount = 0;
  var apiHost = "http://511b-58-11-1-38.ngrok.io";
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);

    socket = IO.io('http://localhost:5000',<String,dynamic>{
      'extraHeaders': {'Access-Control-Allow-Origin':'*'}
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
    arg = widget.arg;
    socket.on('result', (data) {
      result = data;
      imagecount = 0;
      print(data);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    socket.disconnect();
    super.dispose();
  }

  void _captureImage() async {
    if (!_controller.value.isInitialized) {
      return null;
    }
    if (_controller.value.isTakingPicture) {
      return null;
    }
    try {
      XFile image = await _controller.takePicture();
      final path = image.path;
      List<int> bytes = await image.readAsBytes();
      String base64Image = base64Encode(bytes);
      if(arg=="คำถาม"){
        socket.emit('question', base64Image);
        print('รูปที่$imagecount');
      }else if(arg=="การทักทาย"){
        socket.emit('greet', base64Image);
        print('รูปที่$imagecount');
      }
      else if(arg=="นับเลข"){
        socket.emit('number', base64Image);
        print('รูปที่$imagecount');
      }
      else if(arg=="บุคคล"){
        socket.emit('person', base64Image);
        print('รูปที่$imagecount');
      }
      else if(arg=="วัน เดือน ปี"){
        socket.emit('date', base64Image);
        print('รูปที่$imagecount');
      }
      else if(arg=="เวลา"){
        socket.emit('time', base64Image);
        print('รูปที่$imagecount');
      }
    } catch (e) {
      print('Error capturing image: $e');
      return null;
    }
  }

  void _predictImage() async {
    try {
      socket.emit('predicts', 'predict');
    } catch (e) {
      print('Error capturing image: $e');
    }
  }


  Future initCamera(CameraDescription cameraDescription) async {
    _controller =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _controller.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            (_controller.value.isInitialized)
                ? Container( height: (MediaQuery.of(context).size.height),
            width: (MediaQuery.of(context).size.width),child: CameraPreview(_controller))
                : Center(child: CircularProgressIndicator()),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  if (_timer == null) {
                    // Start capturing photos every 100 milliseconds
                    _timer = Timer.periodic(Duration(milliseconds: 500), (timer) {
                      setState(() {
                        imagecount++;
                        _showContainer = true;
                        _isloading = imagecount > 30;
                      });
                      if (imagecount <= 30) {
                        _captureImage();
                      }
                    });
                  } else {
                    // Stop capturing photos
                    _timer?.cancel();
                    _timer = null;
                    setState(() {
                      _showContainer = false;
                      imagecount = 0;
                      //socket.disconnect();
                      // Tooltip(
                      //   message: 'กดปุ่มนี้เพื่อแปลภาษามือ',
                      //   preferBelow: false,
                      // );
                    });
                  }
                },
                icon: Icon(Icons.circle , color: _timer == null ? Colors.white : Colors.red, size: 80,),
              ),
            ),
            if (_showContainer==true)
              Positioned(
                bottom: 110,
                left: 16,
                right: 16,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    //width: 500,
                    //color: Colors.white,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: _isloading? CircularProgressIndicator() :Text(
                        result,
                        style: GoogleFonts.sarabun(textStyle: TextStyle(color: Colors.black, fontSize: 26)),
                      ),
                    ),
                  ),
                ),
              ),

            Positioned(
              bottom: 50,
              left: 15,
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 30,
                icon: Icon(
                    _isRearCameraSelected
                        ? CupertinoIcons.switch_camera
                        : CupertinoIcons.switch_camera_solid,
                    color: Colors.white),
                onPressed: () {
                  setState(() => _isRearCameraSelected = !_isRearCameraSelected);
                  initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                },
              ),
            ),
            Positioned(
                top: 22,
                right: 15,
                child: IconButton(
                  icon: Icon(Icons.close_rounded, size: 30,color: Colors.white,),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),)
                    );
                  },
                )),
            Positioned(
                top: 22,
                left: 15,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios, size: 30,color: Colors.white,),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Category(),)
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
