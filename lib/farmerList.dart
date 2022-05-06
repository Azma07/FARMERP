import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'AddData.dart';
import 'package:farm/db/database_provider.dart';
import 'bloc/farmer_bloc.dart';
import 'event/set_farmer.dart';
import 'model/farmer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


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

  showFoodDialog(BuildContext context, Farmer farmer, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(farmer.name),
        content:Column(
          children: <Widget>[
            Text("Gender:   ${farmer.gender}"),
            Text("Address:   ${farmer.address}"),
            Text("Plot Area:   ${farmer.area}"),
            Text("Crop :   ${farmer.crop}"),
            Text("Varity:   ${farmer.variety}"),
            Text("Planting date :   ${farmer.pdate}"),
            Text("Age of crop:   ${farmer.age}"),


          ],
        ),

    ),
        //Text("ID ${food.id}"),

    //     ],
    //   ),
     );
  }

  void getData()
 async {
    http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=20fc9a5f5eb3c17be643768c388fa815');
if(response.statusCode==200){
  String data =response.body;

  var decodedData=jsonDecode(data);

  var temprature= decodedData['main']['temp'];
  var condition= decodedData['weather'][0]['id'];
  var cityName=decodedData['name'];
  print(temprature);
  print(condition);
  print(cityName);

}
else{
  print(response.statusCode);
}
  }
  @override
  Widget build(BuildContext context) {
    print("Building entire farmer list scaffold");
    getData();

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
                    onTap: () => showFoodDialog(context, farmer, index),

                  ),
                );
              },
              itemCount: farmerList.length,

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
