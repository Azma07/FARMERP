import 'package:farm/model/farmer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

 class DatabaseProvider {
  static const String TABLE_FARMER = "farmer";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_GENDER = "gender";
  static const String COLUMN_ADDRESS = "adress";
  static const String COLUMN_AREA = "area";
  static const String COLUMN_CROP = "crop";
  static const String COLUMN_VARIETY = "variety";
  static const String COLUMN_P_DATE = "pdate";
  static const String COLUMN_AGE = "age";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'farmerDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating farmer table");

        await database.execute(
          "CREATE TABLE $TABLE_FARMER ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_NAME TEXT,"
              "$COLUMN_GENDER TEXT,"
              "$COLUMN_ADDRESS TEXT,"
              "$COLUMN_AREA INTEGER,"
              "$COLUMN_CROP TEXT,"
              "$COLUMN_VARIETY TEXT,"
              "$COLUMN_P_DATE TEXT,"
              "$COLUMN_AGE TEXT"
              ")",
        );
      },
    );
  }

  Future<List<Farmer>> getFarmers() async {
    final db = await database;

    var farmers = await db
        .query(TABLE_FARMER, columns: [COLUMN_ID, COLUMN_NAME, COLUMN_GENDER ,COLUMN_ADDRESS , COLUMN_AREA ,COLUMN_CROP ,COLUMN_VARIETY ,COLUMN_P_DATE ,COLUMN_AGE ]);

    List<Farmer> farmerList = [];
    //List<Farmer>();

    farmers.forEach((currentFarmer) {
      Farmer farmer = Farmer.fromMap(currentFarmer);

      farmerList.add(farmer);
    });

    return farmerList;
  }

  Future<Farmer> insert(Farmer farmer) async {
    final db = await database;
    farmer.id = await db.insert(TABLE_FARMER, farmer.toMap());
    return farmer;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_FARMER,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Farmer farmer) async {
    final db = await database;

    return await db.update(
      TABLE_FARMER,
      farmer.toMap(),
      where: "id = ?",
      whereArgs: [farmer.id],
    );
  }
}
