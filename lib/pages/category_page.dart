import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:video_streaming_app/pages/home_page.dart';

import 'movie_page.dart';


class CategoryPage extends StatefulWidget {
  String name;
  CategoryPage({required this.name});
  //const CategoryPage ({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List  info = [];

  _initData(){
    DefaultAssetBundle.of(context).loadString("jsonfile/try.json").then((value){
      setState(() {
        info= json.decode(value);
      });

    });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
             child: Column(
               children: [
             Expanded(child:info!=null? ListView.builder(
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
                                         MaterialPageRoute(builder: (context) =>MoviePage(name: name , duration: duration)));
                                   },
                                       child: Text(
                                         info[i]['title'],
                                         style: TextStyle(
                                           fontSize: 20,
                                           fontWeight: FontWeight.bold,
                                           color: Colors.red

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
      )

    ]

    ),
           )

    ));

  }
}
