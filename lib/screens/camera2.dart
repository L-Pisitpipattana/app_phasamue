import 'dart:async';
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:app_phasamue/screens/home.dart';
import 'package:app_phasamue/screens/preview_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Cameracap extends StatefulWidget {
  const Cameracap({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription>? cameras;

  @override
  State<Cameracap> createState() => _CameracapState();
}

class _CameracapState extends State<Cameracap> {
  late CameraController _cameraController;
  bool _isRearCameraSelected = true;
  bool isCapturing = false;
  bool _showContainer = false;
  Timer? _timer;
  late IO.Socket socket;


  @override
  void dispose() {
    _cameraController.dispose();
    _timer?.cancel();
    socket.disconnect();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initCamera(widget.cameras![0]);
    socket = IO.io('http://4de6-58-11-1-38.ngrok.io',<String,dynamic>{
      'extraHeaders': {'Access-Control-Allow-Origin':'*'}
    });
    socket.connect();
    socket.onConnect((_) {
      print('Connection established');
    });
    socket.on('result', (data) {
      print(data);
    });
  }

  Future takePicture() async {
    if (!_cameraController.value.isInitialized) {
      return null;
    }
    if (_cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      XFile image = await _cameraController.takePicture();
      final path = image.path;
      List<int> bytes = await image.readAsBytes();
      String base64Image = base64Encode(bytes);
      socket.emit('image', base64Image);
      print('SEND');
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
              children: [
                (_cameraController.value.isInitialized)
                    ? CameraPreview(_cameraController)
                    : Container(
                    color: Colors.black,
                    child: const Center(child: CircularProgressIndicator())),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                          color: Colors.black),
                      child:
                      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Expanded(
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 30,
                              icon: Icon(
                                  _isRearCameraSelected
                                      ? CupertinoIcons.switch_camera
                                      : CupertinoIcons.switch_camera_solid,
                                  color: Colors.white),
                              onPressed: () {
                                setState(
                                        () => _isRearCameraSelected = !_isRearCameraSelected);
                                initCamera(widget.cameras![_isRearCameraSelected ? 0 : 1]);
                              },
                            )),
                        Expanded(
                            child: IconButton(
                              onPressed: (){
                                if (_timer == null) {
                                var count = 0;
                                // Start capturing photos every 100 milliseconds
                                _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                                  takePicture();
                                count++;
                                if(count%30==0){}
                                setState(() {
                                  _showContainer = true;
                                });
                                });
                              } else {
                                // Stop capturing photos
                                _timer?.cancel();
                                _timer = null;
                                setState(() {
                                  _showContainer = false;
                                });
                              }
                              },
                              iconSize: 60,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Icon(Icons.circle, color: _timer == null ? Colors.white : Colors.red),
                            )),
                        const Spacer(),
                      ]),
                    )),
                if (_showContainer==true)
                  Positioned(
                    bottom: 150,
                    left: 16,
                    right: 16,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(20),
                        //width: 500,
                        //color: Colors.white,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Hello',
                            style: TextStyle(color: Colors.black, fontSize: 24),
                          ),
                        ),
                      ),
                    ),
                  ),

                Positioned(
                    top: 2,
                    left: 5,
                    child: IconButton(
                      icon: Icon(Icons.close_rounded, size: 40,color: Colors.white,),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),)
                        );
                      },
                    ))
              ]),
        ));
  }
}
