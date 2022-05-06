import 'package:farm/db/database_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'bloc/farmer_bloc.dart';
import 'model/farmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:farm/event/add_farmer.dart';
import 'package:farm/model/farmer.dart';


class AddData extends StatefulWidget {

  final Farmer farmer;
  final int farmerIndex;

  AddData({this.farmer, this.farmerIndex});

  @override
  _AddDataState createState() => _AddDataState();

}

class _AddDataState extends State<AddData> {
  String selectedValue;
  String item = 'Wheat';
  final items=['Wheat', 'Rice', 'Jowar', 'Ragi','Pulses'];
  DateTime date=DateTime.now();
  String _name;
  String _gender;
  String _address;
  String _area;
  String _crop;
  String _variety;
  String _pdate;
  String _age='0';



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  var age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

  @override
  void initState() {
    super.initState();
    if (widget.farmer != null) {
      _name = widget.farmer.name;
      _gender = widget.farmer.gender;
      _address = widget.farmer.address;
      _area = widget.farmer.area;
      _crop = widget.farmer.crop;
      _variety = widget.farmer.variety;
      _pdate = widget.farmer.pdate;
      _age = widget.farmer.age;

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Add New Farmer',style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500,  fontFamily: 'Poppins-Regular.ttf'),
          textAlign: TextAlign.center,
       ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
           key: _formKey,

        child: Container(
          margin: EdgeInsets.only(left: 20,right: 20,top: 30),
          child: Column(
            children: <Widget>[

              //NAME
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusColor: Colors.green,
                    fillColor: Colors.green,
                    labelText: 'Full Name', labelStyle: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular.ttf',)
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Name is Required';
                  }

                  return null;
                },
                onSaved: (String value) {
                  _name = value;
                },
              ),
              SizedBox(height: 10),

              //GENDER
              Container(
                padding: EdgeInsets.only(right:365, top: 10),
                  child: Text('Gender',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16, fontFamily: 'Poppins-Regular.ttf'),)),
              Row(
                children: <Widget>[
                  Radio<String>(
                    value: 'male',
                    groupValue: _gender,
                    onChanged:(value)=>
                        setState(() =>_gender=value,
                        ),
                  ),
                  Text('male'),
                  Radio<String>(
                    value: 'female',
                    groupValue: _gender,
                    onChanged:(value)=>
                        setState(() =>_gender=value,
                        ),
                  ),
                  Text('female'),
                ],
              ),
             // SizedBox(height: 10),


              //ADRESS
              TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),

                labelText: 'Adress', labelStyle: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular.ttf')
            ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Address is Required';
                  }

                  return null;
                },
                onSaved: (String value) {
                  _address=value;
                },
              ),

              SizedBox(height: 10),

              //AREA
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  labelText: 'Plot Area',
                    labelStyle: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular.ttf'),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'area is Required';
                  }

                  return null;
                },
                onSaved: (String value) {
                  _area = value;
                },
              ),
              SizedBox(height: 10),


              //CROP
              Center(
                child: Container(
                  height: 60,
                  padding: EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0,color: Colors.grey),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: item,
                      icon: const Icon(Icons.keyboard_arrow_down,color: Colors.green,
                          //textDirection: TextDirection.ltr
                        ),
                      iconSize: 24,
                      elevation: 16,
                      isExpanded: true,
                      style: const TextStyle(
                          color: Colors.black
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          item = newValue;
                          _crop=item;
                        });
                      },
                      items:items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                          .toList(),
                    ),
                  ),

                ),
              ),

              SizedBox(height: 10),

              //VARIETY
              TextFormField(

                decoration: InputDecoration(
                  border: OutlineInputBorder(),

                  labelText: 'Variety',
                  labelStyle: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular.ttf'),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Variety is Required';
                  }

                  return null;
                },
                onSaved: (String value) {
                  _variety = value;
                },
              ),
              SizedBox(height: 10),

      //planting DATE
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      'Planting Date:',
                    style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular.ttf',fontWeight: FontWeight.w400),
                  ),

                  //SizedBox(width: 10),
                  Text('${date.year}-${date.month}-${date.day}',
                  style:TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular.ttf',fontWeight: FontWeight.w400,color: Colors.green)),

                  //SizedBox(width: 120),

                  ElevatedButton( child: Text('Select Date'),
                    onPressed: ()async{
                      DateTime newDate= await showDatePicker(context: context,
                        initialDate: date,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2023),
                      );
                      //if cancel =>null
                      if(newDate == null) return;
                      //if ok dateTime
                      setState(() {
                        date=newDate;
                        _pdate=DateFormat('yyyy-mm-dd').format(date);
                        int a=calculateAge(date);
                        _age=a.toString();
                       // _age=DateFormat('yyyy-mm-dd').format(calculateAge(date));

                       // _age = DateFormat('yyyy-mm-dd').format(date.add(Duration(days: 90)));


                      }

                      );

                    },
                  )
                ],
              ),




            SizedBox(height: 10),


              Row(
                mainAxisAlignment: MainAxisAlignment.start,


                children: <Widget>[
                  Text('Age of crop',style: TextStyle(fontSize: 16,
                      fontFamily: 'Poppins-Regular.ttf',
                      fontWeight: FontWeight.w400)),
                  SizedBox(width: 100),
                  Text('$_age',style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular.ttf',
                      fontWeight: FontWeight.w400,
                  color: Colors.green)),

                ],
              ),
              //AGE OF CROP
            // Text('Age of crop:   $_age',style: TextStyle(fontSize: 16, fontFamily: 'Poppins-Regular.ttf',fontWeight: FontWeight.w400),),

               SizedBox(height: 30,),


        TextButton(onPressed: (){
        if (!_formKey.currentState.validate()) {
          return;
        }

        _formKey.currentState.save();

        Farmer farmer = Farmer(
          name: _name,
          gender: _gender,
          address: _address,
          area: _area,
          crop: _crop,
          variety: _variety,
          pdate: _pdate,
          age: _age,

        );

        DatabaseProvider.db.insert(farmer).then(
              (storedFarmer) =>
              BlocProvider.of<FarmerBloc>(context).add(
                AddFarmer(storedFarmer),
              ),
        );

        Navigator.pop(context);
        },
         style:   TextButton.styleFrom(backgroundColor: Colors.green,
            padding: EdgeInsets.symmetric(horizontal: 130)),
          child: Text('Add Data', style: TextStyle(color:Colors.white),
            textAlign: TextAlign.start,
          ),
         ),


            ],

          ),
        ),
    ),
      ),
    );

  }
}


