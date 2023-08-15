import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../data/model/universal_data.dart';
import '../data/network/api_service.dart';

class CallAddressProvider with ChangeNotifier{
  CallAddressProvider({required this.apiService});

  final ApiService apiService;

  String scrolledAddressText = '';
  String kind = "house";
  String lang = "UZ";
  MapType type = MapType.normal;

  getAddressByLatLong({required LatLng latLng}) async {
    UniversalData universalData = await apiService.getAddress(
      latLng: latLng,
      kind: kind,
      lang: lang,
    );

    if (universalData.error.isEmpty) {
      scrolledAddressText = universalData.data as String;
    } else {
      debugPrint("ERROR:${universalData.error}");
    }
    notifyListeners();
  }

  void updateKind(String newKind) {
    kind = newKind;
  }

  void updateLang(String newLang) {
    lang = newLang;
  }



  void updateType(String newType){
    if(newType=="Satellite"){
      type = MapType.satellite;
      notifyListeners();
    }else if(newType=="Terrain"){
      type = MapType.terrain;
      notifyListeners();
    }else{
      type = MapType.normal;
      notifyListeners();
    }
  }

  bool canSaveAddress() {
    if (scrolledAddressText.isEmpty) return false;
    if (scrolledAddressText == 'Aniqlanmagan Hudud') return false;

    return true;
  }
}