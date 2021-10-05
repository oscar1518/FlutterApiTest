import 'dart:convert';
import 'package:apipruebas/Models/artist_model.dart';
import 'package:http/http.dart' as http;

class ArtistService {
  //VARIABLES:

  // MÉTODO GET ALL ARTISTS
  Future<List<Artist>> getAllArtists() async {
    List<Artist> artist = [];

    Uri url = Uri.parse('http://10.1.15.14:8050/apiPrueba/Artist/GetAll');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var artistsJson = json.decode(response.body);
      for (var artistJson in artistsJson) {
        artist.add(Artist.fromJson(artistJson));
      }
    } else {
      print("ERROR DE CONEXIÓN");
    }
    return artist;
  }

  Future<Artist> getArtistById(int artistId) async {
    Uri url =
        Uri.parse('http://10.1.15.14:8050/apiPrueba/Artist/GetById/$artistId');
    var response = await http.get(url);

    Artist artist = Artist(
      id: 0,
      name: '',
      age: 0,
      genre: ''
    );

    if (response.statusCode == 200) {
      var artistJson = json.decode(response.body);
      artist = (Artist.fromJson(artistJson));
      return artist;
    } else {
      print("ERROR DE CONEXIÓN");
    }
    return artist;
  }

  //METODO POST ARTIST
  Future<bool> createArtist(Artist artist) async {
    // Future createArtist(String nameA, String ageA, String genreA) async {
    final response =
        await http.post(Uri.parse('http://10.1.15.14:8050/apiPrueba/Artist'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            // body: jsonEncode(new Artist(
            //   name: nameA,
            //   age: int.parse(ageA),
            //   genre: genreA
            // )
            body: jsonEncode(artist.toJson()));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  //METODO PUT ARTIST
  Future<bool> putArtist(Artist artist) async {
    // Future createArtist(String nameA, String ageA, String genreA) async {
    final response =
        await http.put(Uri.parse('http://10.1.15.14:8050/apiPrueba/Artist'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(artist.toJson()));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> deleteArtist(int idArtist) async {
    // Future createArtist(String nameA, String ageA, String genreA) async {
    final response = await http
        .delete(Uri.parse('http://10.1.15.14:8050/apiPrueba/Artist/$idArtist'));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
