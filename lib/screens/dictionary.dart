import 'package:app_phasamue/screens/dic_details.dart';
import 'package:app_phasamue/screens/home.dart';
import 'package:app_phasamue/widgets/CustomBottomNavBar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class Dictionary extends StatefulWidget {
  const Dictionary({Key? key}) : super(key: key);

  @override
  State<Dictionary> createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> {
  TextEditingController _searchcontroller = TextEditingController();
  Query refQ = FirebaseDatabase.instance.ref().child('vocab');
  String search = "";
  
  @override
  void initState(){
    super.initState();
    _searchcontroller.addListener(_onSearchChanged);
  }

  @override
  void dispose(){
    _searchcontroller.removeListener(_onSearchChanged);
    _searchcontroller.dispose();
    super.dispose();
  }
  _onSearchChanged(){
    print(_searchcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pink.shade100.withOpacity(0.9),
              Colors.pink.shade100.withOpacity(0.9)
              /*Colors.pink.shade300.withOpacity(0.8),
              Colors.pink.shade100.withOpacity(0.8)*/
            ],
            begin: const FractionalOffset(0.0, 0.4),
            end: Alignment.topRight
          )
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30,left: 30, right: 30),
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),)
                        );
                      }, icon: new Icon(Icons.arrow_back_ios,size: 28,)),
                      //Icon(Icons.arrow_back_ios, size: 20,color: Colors.black),
                      Expanded(child: Container()),
                      IconButton(onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),)
                        );
                      }, icon: new Icon(Icons.close_rounded,size: 30,)),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Center(
                    child: Text("พจนานุกรมภาษามือ",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black
                    ),),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    height: 60,
                    child: TextField(
                      controller: _searchcontroller,
                      //cursorColor: Colors.pink,
                      onChanged: (value) {
                        setState(() {
                          search = value;
                        });
                      },
                      //controller: editingController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          //labelText: "ค้นหา",
                          hintText: "ค้นหา",
                          prefixIcon: Icon(Icons.search),
                          //suffixIcon: Icon(Icons.park),
                          //enabledBorder: InputBorder.none,
                          //focusedBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.pink.shade50,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                          /*border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              borderSide:  BorderSide(color: Colors.white ),)*/),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: FirebaseAnimatedList(
                  query: refQ,
                  itemBuilder: (context, snapshot,animation,index){
                    Map title = snapshot.value as Map;
                    if(!title['title'].toString().toLowerCase().contains(search.toLowerCase())){
                      return SizedBox.shrink();
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(5.0),
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index){
                        return ListTile(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => dicdetails(arg: title['title'],des: title['description'], url: title['url']),
                            )
                            );
                          },
                          title: ListTile(
                            title: Text(title['title']),
                            trailing: const Icon(Icons.keyboard_arrow_right),
                          ),
                        );
                      /*return new Card(
                        child: new InkWell(
                          onTap: (){
                            //กดไปหน้าคำศัพท์
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => dicdetails(arg: title['title'],url: title['url'],),
                                /*settings: RouteSettings(
                                  arguments: title['title']
                                )*/
                              )
                            );
                          },
                        child: new ListTile(
                          title: new Text(title['title']),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                        ),
                      );*/
                    });
                    /*return Padding(
                        padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /*ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                  placeholder: "",
                                  image: title['url']),
                            ),*/
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(title['title']),)
                          ],
                        ),
                      ),
                    );*/
                  }
                ),
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.favourite),
    );
  }
  Widget showDic({required Map title}){
    return Column(
      children: [
        Text(title['title']),
        Text(title['description']),
        Text(title['url']),
      ],
    );
  }
}
