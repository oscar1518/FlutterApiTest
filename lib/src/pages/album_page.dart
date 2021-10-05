import 'package:flutter/material.dart';

class AlbumPage extends StatefulWidget {


  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
         child: Column(
           children: [
             Text("Albums"),
             FloatingActionButton(onPressed: null)
             
           ],
         ),
       ),

    );
  }
}