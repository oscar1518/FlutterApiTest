import 'package:apipruebas/src/pages/artist_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variables:

  bool _isPressedArtist = false;
  bool _isPressedAlbum = false;
  bool _isPressedSong = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white30,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [buttonArtist(), buttonAlbum(), buttonSong()],
      )),
    );
  }

  Widget buttonArtist() {
    return GestureDetector(
        onTapDown: (tapDetails) => setState(() {
              _isPressedArtist = true;
            }),
        onTapUp: (tapDetails) => setState(() {
              _isPressedArtist = false;
            }),
        onTapCancel: () => setState(() {

              _isPressedArtist = false;
            }),
        onTap: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArtistPage()),
           );
        },
        child: AnimatedContainer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Menu Artistas", 
                    style: new TextStyle(fontSize: 30),),
                ],
              ),
            ),
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.all(_isPressedArtist ? 15 : 10),
            height: _isPressedArtist ? 140 : 150,
            width: 500,
            decoration: BoxDecoration(
                boxShadow: _isPressedArtist ? [] : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 1,
                            offset: Offset(10, 10),
                            blurRadius: 5)
                      ],
                color: _isPressedArtist ? Colors.yellow.shade100 : Colors.yellowAccent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)
                
              )
            )
          );
  }

 Widget buttonAlbum() {
      return GestureDetector(
        onTapDown: (tapDetails) => setState(() {
              _isPressedAlbum = true;
            }),
        onTapUp: (tapDetails) => setState(() {
              _isPressedAlbum = false;
            }),
        onTapCancel: () => setState(() {
              _isPressedAlbum = false;
            }),
        child: AnimatedContainer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Menu Albums", 
                    style: new TextStyle(fontSize: 30),),
                ],
              ),
            ),
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.all(_isPressedAlbum ? 15 : 10),
            height: _isPressedAlbum ? 140 : 150,
            width: 500,
            decoration: BoxDecoration(
                boxShadow: _isPressedAlbum ? [] : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 1,
                            offset: Offset(10, 10),
                            blurRadius: 5)
                      ],
                color: _isPressedAlbum ? Colors.lightGreenAccent.shade100 : Colors.lightGreenAccent.shade400,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)
                
              )
            )
          );
  }

 Widget buttonSong() {
    return GestureDetector(
        onTapDown: (tapDetails) => setState(() {
              _isPressedSong = true;
            }),
        onTapUp: (tapDetails) => setState(() {
              _isPressedSong = false;
            }),
        onTapCancel: () => setState(() {
              _isPressedSong = false;
            }),
        child: AnimatedContainer(
           child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Menu Canciones", 
                    style: new TextStyle(fontSize: 30),),
                ],
              ),
            ),
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.all(_isPressedSong ? 15 : 10),
            height: _isPressedSong ? 140 : 150,
            width: 500,
            decoration: BoxDecoration(
                boxShadow: _isPressedSong ? [] : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 6,
                            offset: Offset(2, 2),
                            blurRadius: 5)
                      ],
                color: _isPressedSong ? Colors.blueAccent.shade100 : Colors.blueAccent.shade200,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)
              )
            )
          );
  }
}
