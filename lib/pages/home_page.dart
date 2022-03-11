import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:video_streaming_app/MovieDataModel.dart';
import 'package:video_streaming_app/pages/category_page.dart';
import 'package:get/get.dart';
import 'package:video_streaming_app/main.dart';
import 'package:video_streaming_app/pages/movie_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List data=[];
 Future<List<MovieDataModel>>ReadJsonData() async {

    final jsondata = await rootBundle.rootBundle.loadString('jsonfile/videos.json');

    setState(() {
      data= json.decode(jsondata) as List<dynamic>;
    });


    return data.map((e) => MovieDataModel.fromJson(e)).toList();

    print(data);

  }

  _initState(){
      ReadJsonData();
  }


  //reading data from json file
/*
  List info=[];
  _initData(){
    DefaultAssetBundle.of(context).loadString("jsonfile/try.json").then((value){
      setState((){
        info = json.decode(value);
      });

    });
  }
@override
  void initState() {
    // TODO: implement initState
  _initData();
  }
*/
  //
  @override
  Widget build(BuildContext context) {

    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
ReadJsonData();
    return Scaffold(
          body:
          Container(
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

            SizedBox(height: 10),

        FutureBuilder(
          future: ReadJsonData(),
          builder: (context,data){
            var items = data.data as List<MovieDataModel>;
            return
            Expanded(
                child: data!=null? ListView.builder(
                    itemCount: items == null ? 0 : items.length,
                    itemBuilder: (context, index) {
                      String? url = items[index].preview.toString();
                      String name = items[index].name.toString();
                      return Row(
                        children: [

                          Container(
                            margin: const EdgeInsets.only(
                                top: 10, left: 15),
                            height: 170,
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),

                                image: DecorationImage(

                                    image: NetworkImage(url),
                                    fit: BoxFit.cover),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 3,
                                      offset: Offset(5, 5),
                                      color: Colors.red.withOpacity(0.2)
                                  )
                                ]

                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      );
                    }):Center(child: CircularProgressIndicator())
            );
          }

        )


/*
              Expanded(
                child:info!=null? ListView.builder(
                  itemCount: info.length,
                    itemBuilder: (_,i){
                      String? url=info[i]['img'];
                      String name=info[i]['movie'];
                      String duration=info[i]['duration'];
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
                                        MaterialPageRoute(builder: (context) =>MoviePage(name: name, duration: duration)));
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
                    }):Center(child: CircularProgressIndicator())
)*/
            ]
          ),
    ),

    );



  }
}
