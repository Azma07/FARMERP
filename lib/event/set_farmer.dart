import 'package:farm/model/farmer.dart';
import 'farmer_event.dart';

class SetFarmers extends FarmerEvent {
  List<Farmer> farmerList;


  SetFarmers(List<Farmer> farmers) {
    farmerList = farmers;
  }
}
