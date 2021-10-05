import 'package:apipruebas/Models/artist_model.dart';
import 'package:flutter/material.dart';
import 'package:apipruebas/Services/artist_service.dart';
import 'package:flutter/services.dart';

TextEditingController idController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController ageController = TextEditingController();
TextEditingController genreController = TextEditingController();

bool response = false;

// ELECCIONES DE COLOR E ICONOS:
Icon eleccionDeIcono(int eleccion) {
  if (eleccion == 1) {
    return Icon(
      Icons.add_circle,
      color: Colors.red,
    );
  } else if (eleccion == 2) {
    return Icon(
      Icons.add_circle,
      color: Colors.green,
    );
  } else if (eleccion == 3) {
    return Icon(
      Icons.pin_drop_rounded,
      color: Colors.blue,
    );
  } else {
    return Icon(
      Icons.podcasts,
      color: Colors.yellow,
    );
  }
}

ButtonStyle eleccionButtonStyle(int eleccionButton) {
  if (eleccionButton == 1) {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
        foregroundColor: MaterialStateProperty.all(Colors.white));
  } else if (eleccionButton == 2) {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        foregroundColor: MaterialStateProperty.all(Colors.white));
  } else if (eleccionButton == 3) {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        foregroundColor: MaterialStateProperty.all(Colors.white));
  } else {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.yellow),
        foregroundColor: MaterialStateProperty.all(Colors.white));
  }
}

Color eleccionColorStyle(int eleccionColor) {
  if (eleccionColor == 1) {
    return Colors.red;
  } else if (eleccionColor == 2) {
    return Colors.green;
  } else if (eleccionColor == 3) {
    return Colors.blue;
  } else {
    return Colors.yellow;
  }
}
// DIALOGOS

AlertDialog dialogoDeRegistoCorrecto(
    String textTitulo, String textAlerta, int eleccion, BuildContext context) {
  return AlertDialog(
    title: Row(children: [
      eleccionDeIcono(eleccion),
      SizedBox(width: 5),
      Text(textTitulo),
    ]),
    shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(30))),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textAlerta),
      ],
    ),
    actions: [
      Column(
        children: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              idController.text = '';
              nameController.text = '';
              ageController.text = '';
              genreController.text = '';
            },
            child: Text('Ok'),
            style: eleccionButtonStyle(eleccion),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
      SizedBox(
        width: 10,
      )
    ],
  );
}

Widget dialogoParaLosBotonesDeAccion(
    BuildContext context, String titulo, String accion, int eleccion) {
  return AlertDialog(
    title: Row(
      children: [
        eleccionDeIcono(eleccion),
        SizedBox(
          width: 20,
        ),
        Text(accion + " " + titulo)
      ],
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        textFieldId(titulo, eleccion),
        SizedBox(
          height: 7,
        ),
        textFieldNombre(titulo, eleccion),
        SizedBox(
          height: 7,
        ),
        textFieldAge(titulo, eleccion),
        SizedBox(
          height: 7,
        ),
        textFieldGenre(titulo, eleccion)
      ],
    ),
    actions: [
      Column(
        children: [
          Row(
            children: [
              SizedBox(width: 185),
              TextButton(
                  style: eleccionButtonStyle(eleccion),
                  onPressed: () async {
                    ArtistService artistService = ArtistService();
                    if (eleccion == 2) {
                      Artist artist = Artist(
                          id: int.parse(idController.text),
                          name: nameController.text,
                          age: int.parse(ageController.text),
                          genre: genreController.text);
                      response = await artistService.putArtist(artist);

                      if (response == true) {
                        await showDialog(
                            context: context,
                            builder: (context) => dialogoDeRegistoCorrecto(
                                'Aviso',
                                'Artista registrado:\nArtista: ${artist.name}\nEdad: ${artist.age}\nGenero: ${artist.genre}',
                                eleccion,
                                context));
                      }
                    } else if (eleccion == 3) {
                      int artistId = int.parse(idController.text);
                      response = await artistService.deleteArtist(artistId);

                      if (response == true) {
                        await showDialog(
                            context: context,
                            builder: (context) => dialogoDeRegistoCorrecto(
                                'Aviso',
                                '¡Usuario Eliminado con éxito!',
                                eleccion,
                                context));
                      }
                    } else {
                      int artistId = int.parse(idController.text);
                      Artist artista =
                          await artistService.getArtistById(artistId);
                      if (artista.id == 0) {
                        await showDialog(
                            context: context,
                            builder: (context) => dialogoDeRegistoCorrecto(
                                'Aviso',
                                '¡Artista no encontrado!',
                                eleccion,
                                context));
                      } else {
                        await showDialog(
                            context: context,
                            builder: (context) => dialogoDeRegistoCorrecto(
                                'Usuario encontrado:',
                                'Nombre: ${artista.name}\nEdad: ${artista.age}\nGenero: ${artista.genre}',
                                eleccion,
                                context));
                      }
                    }

                    response = false;
                    Navigator.of(context).pop();
                  },
                  child: Text(accion)),
            ],
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    ],
  );
}

Widget textFieldId(String titulo, int eleccion) {
  return TextField(
    keyboardType: TextInputType.number,
    inputFormatters: [LengthLimitingTextInputFormatter(3)],
    controller: idController,
    decoration: InputDecoration(
        icon: Icon(Icons.person, color: eleccionColorStyle(eleccion)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: "Id " + titulo),
  );
}

Widget textFieldNombre(String titulo, int eleccion) {
  if (eleccion == 3 || eleccion == 4) {
    return SizedBox();
  }
  return TextField(
    controller: nameController,
    decoration: InputDecoration(
        icon: Icon(Icons.label, color: eleccionColorStyle(eleccion)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: "Nombre " + titulo),
  );
}

Widget textFieldAge(String titulo, int eleccion) {
  if (eleccion == 3) {
    return Text("¡Atención!");
  } else if (eleccion == 4) {
    return SizedBox();
  }
  return TextField(
    keyboardType: TextInputType.number,
    maxLines: 1,
    inputFormatters: [LengthLimitingTextInputFormatter(3)],
    controller: ageController,
    decoration: InputDecoration(
        icon: Icon(Icons.calendar_today, color: eleccionColorStyle(eleccion)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: "Edad del " + titulo),
  );
}

Widget textFieldGenre(String titulo, int eleccion) {
  if (eleccion == 3) {
    return Text("¡El artista será eliminado!");
  } else if (eleccion == 4) {
    return Text("Introduce un ID para buscar el artista.");
  }
  return TextField(
    controller: genreController,
    decoration: InputDecoration(
        icon: Icon(Icons.wc, color: eleccionColorStyle(eleccion)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        labelText: "Genero del " + titulo),
  );
}
