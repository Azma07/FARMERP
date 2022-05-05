import 'package:farm/event/add_farmer.dart';
import 'package:farm/event/farmer_event.dart';
import 'package:farm/event/set_farmer.dart';
import 'package:farm/model/farmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FarmerBloc extends Bloc<FarmerEvent, List<Farmer>> {
  //FarmerBloc(List<Farmer> initialState) : super(initialState);

  //FarmerBloc(List<Farmer> initialState) : super(initialState);

  //SetFarmers(List<Farmer> farmers) {
//constructed created
  @override
  List<Farmer> get initialState => List<Farmer>();

  @override
  Stream<List<Farmer>> mapEventToState(FarmerEvent event) async* {
    if (event is SetFarmers) {
      yield event.farmerList;
    } else if (event is AddFarmer) {
      List<Farmer> newState = List.from(state);
      if (event.newFarmer != null) {
        newState.add(event.newFarmer);
      }
      yield newState;
    }
  }
}

