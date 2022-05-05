import 'package:farm/model/farmer.dart';
import 'farmer_event.dart';

class AddFarmer extends FarmerEvent {
  Farmer newFarmer;

  AddFarmer(Farmer farmer) {
    newFarmer = farmer;
  }
}
