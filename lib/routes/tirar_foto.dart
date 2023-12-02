// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({super.key});

  @override
  _TakePictureState createState() {
    return _TakePictureState();
  }
}

class _TakePictureState extends State<TakePicture> {
  // late -> deixa a inicialização da váriavel pra mais tarde no código
  late final CameraController
      _cameraController; // objeto que controlará a câmera
  // pois a chamada da camera é assíncrona
  late final Future<void> _cameraIniciada;
  
  late String pathToProfilePic;

  @override
  void initState() {
    super.initState();
    // // pede pro flutter utilizar os recursos nativos do android (camera,microfone...)
    // // garante o bind entre o flutter e outra linguagem q esteja sendo usada (por exemplo C#, C++)
    // WidgetsFlutterBinding.ensureInitialized();
  }

  Future<void> iniciarCamera() async {
    // transforma em objeto as descrições das câmeras presentes no dispositivo
    // comando assíncrono, EXECUTAR DEPOIS DO WIDGETSFLUTTER.....
    final cameras = await availableCameras();
    final camera = cameras.first;
    // caso tivesse mais de uma seria cameras[index]
    // widget.camera -> descrição de q câmera será usada
    // ResolutionPreset.max -> define a resolução da câmera
    _cameraController = CameraController(camera, ResolutionPreset.max);
    // comando q inicia a câmera
    await _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // constrói a janela com a imagem da câmera
          FutureBuilder(
            future: iniciarCamera(), // espera inicializar a câmera
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: CameraPreview(
                      _cameraController), // mostra o conteúdo da câmera
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),

          // botão q tira a foto
          IconButton(
            onPressed: () async {
              // tira a foto
              final image = await _cameraController.takePicture();
              Uint8List imageBytes = await image.readAsBytes();
              // salva a foto na galeria
              final imageSavedData =
                  await ImageGallerySaver.saveImage(imageBytes);
              String URL = imageSavedData["filePath"];
              this.pathToProfilePic = URL;
              print(URL);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Foto salva na Galeria"),
                  duration: Duration(seconds: 5),
                ),
              );
            },
            icon: const Icon(Icons.photo_camera),
          ),
        ],
      ),
    );
  }
}

// inserir o consumer para pegar o url



