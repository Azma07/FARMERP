import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'AddData.dart';
import 'package:farm/db/database_provider.dart';
import 'farmerDetail.dart';
import 'bloc/farmer_bloc.dart';
import 'event/set_farmer.dart';
import 'model/farmer.dart';


class FarmerList extends StatefulWidget {
  const FarmerList({Key key}) : super(key: key);

  @override
  _FarmerListState createState() => _FarmerListState();
}

class _FarmerListState extends State<FarmerList> {
  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getFarmers().then(
          (farmerList) {
        BlocProvider.of<FarmerBloc>(context).add(SetFarmers(farmerList));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire food list scaffold");
    return Scaffold(
      appBar: AppBar(
        title: Text("FARMER LIST"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(8),
        color: Colors.grey,
        child: BlocConsumer<FarmerBloc, List<Farmer>>(
          builder: (context, farmerList) {
            return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                print("farmerList: $farmerList");

                Farmer farmer = farmerList[index];
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(farmer.name, style: TextStyle(fontSize: 26)),
                    //subtitle: Text(farmer.address, style: TextStyle(fontSize: 26)),
                        //showFoodDialog(context, farmer, index),
                    onTap: (){
                      var route= new MaterialPageRoute(builder: (BuildContext contex)=>
                      FarmerDetail(value:farmer.address),);
                      Navigator.of(context).push(route);
                    },
                  ),
                );
              }
            );
          },
          listener: (BuildContext context, farmerList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => AddData()),
        ),
      ),
    );
  }
}
