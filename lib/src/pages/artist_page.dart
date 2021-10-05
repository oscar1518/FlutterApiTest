import 'package:apipruebas/Models/artist_model.dart';
import 'package:apipruebas/Services/artist_service.dart';
import 'package:apipruebas/Widgets/AlertDialog_widget.dart';
import 'package:apipruebas/Widgets/LoadingCircle_widget.dart';
import 'package:flutter/material.dart';

class ArtistPage extends StatefulWidget {
  final ArtistService artistService = ArtistService();

  @override
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  List<Artist> artists = [];

  bool post = false;

  double height = 0;
  double margin = 200;

  final artistNameController = TextEditingController();
  final artistAgeController = TextEditingController();
  final artistGenreController = TextEditingController();

  String artistName = '';
  String artistAge = '';
  String artistGenre = '';

  bool _isLoading = false;
  // AnimationController contoladorLoading = AnimationController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: Row(
          children: [
            SizedBox(
              width: 450,
            ),
            FloatingActionButton(
                //------- GET BUTTON -------
                heroTag: "GET",
                backgroundColor: Colors.amber,
                child: Text(
                  "GET",
                ),
                onPressed: () async {
                  setState(() {
                    height = 0;
                    margin = 330;
                    artists.clear();
                    _isLoading = true;
                  });

                  await Future.delayed(Duration(seconds: 1));

                  List<Artist> artistFromApi =
                      await widget.artistService.getAllArtists();
                  artists.addAll(artistFromApi);
                  setState(() {
                    _isLoading = false;
                    height = 1100;
                    margin = 0;
                  });
                }),
            // onPressed: () {
            // widget.artistService.fetchNotes().then((artistsList) {
            //   setState(() {
            //     artists.addAll(artistsList);
            //   });
            // });
            // }),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
                //------- GET BUTTON -------
                heroTag: "GETID",
                backgroundColor: Colors.amber,
                child: Text(
                  "GET ID",
                ),
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => dialogoParaLosBotonesDeAccion(
                          context, "Artista", 'Buscar', 4));
                  setState(() {});
                }),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
                heroTag: "Post",
                backgroundColor: Colors.red,
                child: Text(
                  "POST",
                ),
                onPressed: () async {
                  showDialog(
                      context: context, builder: (context) => postDialog());
                  setState(() {
                    artists.clear();
                  });
                }),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
                heroTag: "btn3",
                backgroundColor: Colors.green,
                child: Text(
                  "PUT",
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => dialogoParaLosBotonesDeAccion(
                          context, "Artista", 'Put', 2));
                }),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
                heroTag: "Delete",
                backgroundColor: Colors.blue,
                child: Text(
                  "DROP",
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => dialogoParaLosBotonesDeAccion(
                          context, "Artista", 'Delete', 3));
                  setState(() {});
                }),
          ],
        ),
        body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://i.pinimg.com/originals/3c/02/c0/3c02c07c231fd281808c734e26a6aacb.jpg'))
                )
                child: ,
              ),
            SingleChildScrollView(
          child: Center(
            child: Stack(children: [

              estadoDeCargaDePantalla(_isLoading),
              Column(
                children: [
                  containerGet(),
                ],
              ),
            ]),
          ),
      ),] 
        ),
    );
  }

  Widget containerGet() {
    return AnimatedContainer(
        duration: Duration(milliseconds: 1500),
        curve: Curves.easeOutQuart,
        child: listviewGET(),
        margin: EdgeInsets.all(40),
        height: height,
        width: 700,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 1,
                  offset: Offset(10, 10),
                  blurRadius: 5)
            ],
            color: Color.fromRGBO(250, 240, 10, 0.5),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black)));
  }

  Widget listviewGET() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 1000),
      // margin: EdgeInsets.,
      padding: EdgeInsets.all(20),
      child: ListView.builder(
          itemBuilder: (context, index) => listViewItem(context, index),
          itemCount: artists.length,
          padding: EdgeInsets.all(0)),
    );
  }

  Widget listViewItem(BuildContext context, int index) {
    return AnimatedContainer(
      margin: EdgeInsets.all(margin),
      duration: Duration(seconds: 3),
      width: 1,
      child: Card(
        child: Column(
          children: [
            Text(
              artists[index].id.toString(),
              style: TextStyle(fontStyle: FontStyle.italic, fontSize: 30),
            ),
            Text(
              artists[index].name,
              style: TextStyle(fontSize: 25),
            ),
            Text(
              artists[index].age.toString(),
              style: TextStyle(fontSize: 25),
            ),
            Text(
              artists[index].genre ?? '',
              style: TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }

  Widget postDialog() {
    return AlertDialog(
        title: Text('  Crear un nuevo Artista'),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: artistNameController,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: Colors.red,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Nombre del Artista'),
            ),
            SizedBox(
              height: 4,
            ),
            TextField(
                controller: artistAgeController,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: Colors.red,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  labelText: 'Edad del Artista',
                )),
            SizedBox(
              height: 4,
            ),
            TextField(
                controller: artistGenreController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.wc,
                      color: Colors.red,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    labelText: 'Genero del Artista'))
          ],
        ),
        actions: [
          TextButton(
              onPressed: () async {
                print(artistName);
                Artist artist = Artist(
                    name: artistNameController.text,
                    age: int.parse(artistAgeController.text),
                    genre: artistGenreController.text);
                // artistName = artistNameController.text;
                // artistAge = artistAgeController.text;
                // artistGenre = artistGenreController.text;

                Navigator.of(context).pop();
                post = await widget.artistService.createArtist(artist);
                setState(() {
                  if (post == true) {
                    showDialog(
                        context: context,
                        builder: (context) => dialogoDeRegistoCorrecto(
                            'Aviso', 'Usuario nuevo registrado', 1, context));
                  }
                });
              },
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.red)),
              child: Text("Post")),
        ]);
  }
}
