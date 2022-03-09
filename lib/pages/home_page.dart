import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:video_streaming_app/MovieDataModel.dart';
import 'package:video_streaming_app/pages/category_page.dart';
import 'package:get/get.dart';
import 'package:video_streaming_app/main.dart';
import 'package:video_streaming_app/pages/movie_page.dart';
/*
class _videoInfoState extends State<VideoInfo>{
  List videoInfo=[];
  _initData(){
    DefaultAssetBundle.of(context).loadString('json/videos.json').then((value) => videoInfo= json.decode(value));
  }
}
*/
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List info=[];
  _initData(){
    DefaultAssetBundle.of(context).loadString("jsonfile/try.json").then((value){
      info= json.decode(value);
    });
  }
@override
  void initState() {
    // TODO: implement initState
  _initData();
  }
  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;

    return Scaffold(
          body:Container(
            child:
            Column(children: [
            Row(
              children: [
              Container(
                height: h*0.3,
                width: w,
                decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("assets/header.jpg"),
                    fit: BoxFit.cover
                    )
                ),
              ),

              ],
            ),
            Row(
                children: [
                  FlatButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CategoryPage()),
                      );
                    }
                    , child: Text (
                    "Categories",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                    color: Colors.black87,
                    minWidth: w,
                    height: 50,

                  ),
                ],
              ),
            SizedBox(height: 10),

              Expanded(child: ListView.builder(
                itemCount: info.length,
                  itemBuilder: (_,i){
                    String? url=info[i]['img'];
                    String name=info[i]['movie'];
                    return Row(
                      children: [

                        Container(
                          margin: const EdgeInsets.only(top: 10, left: 15),
                          height: 170,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),

                              image:  DecorationImage(

                                  image: NetworkImage(url!),
                                    fit: BoxFit.cover),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: Offset(5,5),
                                color: Colors.red.withOpacity(0.2)
                              )
                            ]

                          ),
                    ),
                          SizedBox(width: 20),

                          Container(

                            padding: EdgeInsets.only(bottom: 5),
                            child:
                            Center(
                              child: Align(

                              child:
                                  Row(
                              children: [
                                FlatButton(onPressed: (){
                                    Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>MoviePage(name: name)));
                                    },
                                    child: Text(
                                  info[i]['title'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,

                                  ),

                                ))
                              ],
                              ),

                              )
                            ),
                          ),
                        SizedBox(height: 10)
                      ],

                    );



                  })
              )
            ]
          ),
    ),
    );

  }

}
