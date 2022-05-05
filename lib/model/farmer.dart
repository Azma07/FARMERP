import 'package:farm/db/database_provider.dart';


class Farmer {
  int id;
  String name;
  String gender;
  String address;
  String area;
  String crop;
  String variety;
  String pdate;
  String age;


  Farmer({this.id, this.name, this.gender, this.address, this.area,this.crop,this.variety,this.pdate,this.age});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_GENDER: gender,
      DatabaseProvider.COLUMN_ADDRESS:address,
      DatabaseProvider.COLUMN_AREA:area,
      DatabaseProvider.COLUMN_CROP:crop,
      DatabaseProvider.COLUMN_VARIETY:variety,
      DatabaseProvider.COLUMN_P_DATE:pdate,
      DatabaseProvider.COLUMN_AGE:age

    };

    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }

    return map;
  }

  Farmer.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    gender = map[DatabaseProvider.COLUMN_GENDER];
    address = map[DatabaseProvider.COLUMN_ADDRESS];
    area = map[DatabaseProvider.COLUMN_AREA];
    crop = map[DatabaseProvider.COLUMN_CROP];
    variety = map[DatabaseProvider.COLUMN_VARIETY];
    pdate = map[DatabaseProvider.COLUMN_P_DATE];
    age = map[DatabaseProvider.COLUMN_AGE];


  }
}
