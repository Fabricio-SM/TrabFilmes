import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

class LocationService {
  Future<Placemark?> getCurrentLocation() async {
    await _geolocatorPlatform.requestPermission();
    try {
      // busca a localização atual para ser inserida no campo de endereço
      Position position = await _geolocatorPlatform.getCurrentPosition();
      // aponta para o geocoding quais são os pontos de lat/long para gerar o que irá preencher o campo
      print(position.toString());
      print("${position.latitude} - ${position.longitude}");
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      return placemarks.isNotEmpty ? placemarks.first : null;
    } catch (e) {
      print('Erro ao obter a localização: $e');
      return null;
    }
  }
}
