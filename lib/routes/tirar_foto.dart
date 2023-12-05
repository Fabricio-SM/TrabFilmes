// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, non_constant_identifier_names

import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/image_cache.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({super.key});

  @override
  _TakePictureState createState() {
    return _TakePictureState();
  }
}

class _TakePictureState extends State<TakePicture> {
  // late -> deixa a inicialização da váriavel pra mais tarde no código
  late ImagePathProvider imgProvider;

  late final CameraController
      _cameraController; // objeto que controlará a câmera
  // pois a chamada da camera é assíncrona
  late final Future<void> _cameraIniciada;

  @override
  void initState() {
    super.initState();
    imgProvider = Provider.of<ImagePathProvider>(context, listen: false);
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

          IconButton(
            onPressed: () async {
              // tira a foto
              final image = await _cameraController.takePicture();
              Uint8List imageBytes = await image.readAsBytes();
              // salva a foto na galeria
              ImageGallerySaver.saveImage(imageBytes);
              print(image.path);
              imgProvider.setImagePath(image.path);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Foto salva na Galeria"),
                  duration: Duration(seconds: 5),
                ),
              );
              Navigator.pop(context);
            },
            icon: const Icon(Icons.photo_camera),
          ),
        ],
      ),
    );
  }
}

// Future<void> _pickImageFromGallery() async {
//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//   if (pickedFile != null) {
//     // A imagem foi escolhida com sucesso. Agora você pode fazer o que quiser com o caminho da imagem.
//     String imagePath = pickedFile.path;

//     // Agora você pode salvar o caminho da imagem no seu provider.
//     Provider.of<ImagePathProvider>(context, listen: false)
//         .setImagePath(imagePath);
//   } else {
//     // Usuário cancelou a seleção.
//   }
// }
