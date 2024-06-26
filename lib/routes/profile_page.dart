
// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/image_cache.dart';
import 'package:flutter_application_1/routes/tirar_foto.dart';
import 'package:flutter_application_1/providers/perfil_cache.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../services/location_service.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  _MyProfile createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  TextEditingController dateinput = TextEditingController();
  final LocationService _locationService = LocationService();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.sizeOf(context);
    return Consumer<Cache>(
      builder: (context, cache, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Meu Perfil"),
          ),
          backgroundColor: const Color(0xFFF1F3F6),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Consumer<ImagePathProvider>(
                      builder: (context, imagePathProvider, _) {
                    imagePathProvider.getImagePath();
                    return Center(
                      child: GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: imagePathProvider.imagePath != ''
                              ? Container(
                                  width: mediaQuery.width * 0.6,
                                  height: mediaQuery.width * 0.6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                  ),
                                  child: Image.file(
                                    File(imagePathProvider.imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: mediaQuery.width * 0.6,
                                  height: mediaQuery.width * 0.6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    ),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                        'lib/img/perfil.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                        ),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TakePicture(),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: cache.listPerfil[0].nome,
                            filled: true,
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color:
                                      Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: cache.listPerfil[0].email,
                            filled: true,
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color:
                                      Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _addressController,
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: _addressController.text,
                            filled: true,
                            fillColor: const Color.fromARGB(255, 255, 255, 255),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                  color:
                                      Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller:
                              dateinput, //editing controller of this TextField
                          decoration: InputDecoration(
                            labelText: cache
                                .listPerfil[0].dataNasc, //label text of field
                            icon:
                                const Icon(Icons.calendar_today), //icon of text field
                          ),
                          readOnly:
                              true, //set it true, so that user will not able to edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(
                                    2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateinput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          child: const Text("Buscar endereço"),
                          onPressed: () async {
                            Placemark? placemark =
                                await _locationService.getCurrentLocation();

                            if (placemark != null) {
                              setState(() {
                                _addressController.text =
                                    '${placemark.street}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                  content: Text(
                                      'Não foi possível obter a localização.')));
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
