import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_streaming_app/pages/home_page.dart';


class MoviePage extends StatefulWidget {

  String name;
  MoviePage({required this.name});


 // const MoviePage({Key? key}) : super(key: key);
  @override
  _MoviePageState createState() => _MoviePageState();
}

 class _MoviePageState extends State<MoviePage> {
   VideoPlayerController? _controller;
  bool _isPlaying=false;
  bool _disposed=false;
  int _isPlayingIndex=-1;
   @override
   List info = [];

   _initData() {
     DefaultAssetBundle.of(context).loadString("jsonfile/try.json").then((
         value) {
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
  @override
   void dispose(){
     _disposed=true;
     _controller?.pause();
     _controller?.dispose();
     _controller=null;
     super.dispose();
   }
   @override
   Widget build(BuildContext context) {
     return Scaffold(body:
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
                         InkWell(onTap: (){
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (context) => const HomePage()),
                           );
                         },
                             child: Icon(Icons.arrow_back, size: 20,color: Colors.white)),
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
                                Text("120 mins")
                             ],
                           ),
                         )
                       ],
                     ),
                     SizedBox(height: 10),
                     //screen

                     _playView(context),
                     _controlView(context),/*
                     Container(

                       width: MediaQuery.of(context).size.width-20,
                       height: 200,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(15),
                           color: Colors.white.withOpacity(0.5)
                       ),
                     ),*/
                   ],
                 ),
               ),
            Column(
              children: [
           SizedBox(height: 10),
           Text(
             widget.name,
             style: TextStyle(
                 fontSize: 25,
                 fontStyle: FontStyle.italic
             ),)
                   ],
                 ),

               Expanded(child:info!=null? ListView.builder(
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
                                               color: Colors.black

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
                   }):Center(child: CircularProgressIndicator()
               )
               )
       ]
           ),
         )
     );
   }
   Widget _controlView(BuildContext context){
     return Container(
       height: 120,
       width: MediaQuery.of(context).size.width,
       color: Colors.redAccent,
       child: Row(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           FlatButton(
               onPressed: ()async{
                 final index=_isPlayingIndex-1;
               },
               child: Icon(Icons.fast_rewind,
               size: 36,
               color: Colors.white,)),
           FlatButton(
               onPressed: ()async{
                 if(_isPlaying){
                   setState(() {
                     _isPlaying=false;
                   });
                   _controller?.pause();
                 }else{
                   setState(() {
                     _isPlaying=true;
                   });
                   _controller?.play();
                 }
               },
               child: Icon(_isPlaying?Icons.pause:Icons.play_arrow,
                 size: 36,
                 color: Colors.white,)),
           FlatButton(
               onPressed: ()async{

               },
               child: Icon(Icons.fast_forward,
                 size: 36,
                 color: Colors.white,))
         ],
       ),
     );
   }

  Widget _playView (BuildContext context){
     final controller=_controller;
     if(controller!=null && controller.value.isInitialized){
       return AspectRatio(
       aspectRatio: 16/9,
         child: VideoPlayer(controller),
       ) ;
     }else{
          return AspectRatio(
              aspectRatio: 16/9,
              child:Center(child: Text("Being initialized plz wait"))
          );
     }
  }

  _initializeVideo(int index){
     final controller = VideoPlayerController.network(info[index]["videourl"]);
     final old= _controller;
     _controller=controller;
     if(old!=null){
       old.removeListener(_onControllerUpdate);
       old.pause();
     }
     setState(() {

     });
     controller..initialize().then((_){
       old?.dispose();
       _isPlayingIndex=index;
       controller.addListener(_onControllerUpdate);
        controller.play();
       setState(() {

       });
     });
  }

  var _onUpdateControllerTime;
  void _onControllerUpdate () async{
     if(_disposed){
       return;
     }
     _onUpdateControllerTime=0;
     final now=DateTime.now().millisecondsSinceEpoch;
     if(_onUpdateControllerTime>now){
       return;
     }

     //_onUpdateControllerTime=now+500;

     final controller= _controller;
     if(controller==null){
       debugPrint("controller is null");
       return;
     }
     if(!controller.value.isInitialized){
       debugPrint("controller can not be initialized");
       return;
     }
     final playing=controller.value.isPlaying;
     _isPlaying=playing;
  }

  _onTap(int index){
     _initializeVideo(index);
  }
 }
