import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_streaming_app/pages/home_page.dart';


class MoviePage extends StatefulWidget {

  String name;
  MoviePage({required this.name});

 // const MoviePage({Key? key}) : super(key: key);
  @override
  _MoviePageState createState() => _MoviePageState();
}

 class _MoviePageState extends State<MoviePage> {


   @override
   List info = [];
/*
   _initData() {
     DefaultAssetBundle.of(context).loadString("jsonfile/try.json").then((
         value) {
       info = json.decode(value);
     });
   }

   @override
   void initState() {
     // TODO: implement initState
     _initData();
   }

 */


   @override
   Widget build(BuildContext context) {
     return Scaffold(

         body:
         /*
      Center(
        child: Text(
          widget.name
        ),
      ),
      */
         Container(
           decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: [
                   Colors.red,
                   Colors.red.shade800
                 ],
                 begin: const FractionalOffset(0.0, 0.4),
                 end: Alignment.topRight,
               )
           ),
           child: Column(
             children: [
               Container(
                 padding: const EdgeInsets.only(top: 20),
                 width: MediaQuery
                     .of(context)
                     .size
                     .width,
                 height: 300,
                 child: Column(
                   children: [
                     Row(
                       children: [
                         SizedBox(width: 20,),
                         Icon(Icons.arrow_back),
                         Expanded(child: Container()),
                         Icon(
                           Icons.info_outline, size: 20, color: Colors.white,),
                         SizedBox(width: 20,)
                       ],
                     ),
                     SizedBox(height: 10,),
                     Row(

                       children: [
                         SizedBox(width: 20,),
                         Container(width: 90,
                           height: 30,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(10),
                               gradient: LinearGradient(
                                   colors: [
                                     Colors.redAccent,
                                     Colors.red.withOpacity(0.5)
                                   ]
                               )
                           ),
                           child: Row(
                             children: [
                               Icon(Icons.timer,
                                   size: 20,
                                   color: Colors.white),
                               SizedBox(width: 5,),
                               // Text( )
                             ],
                           ),
                         )
                       ],
                     )
                   ],
                 ),
               )
             ],
           ),
         )
     );
   }
 }
