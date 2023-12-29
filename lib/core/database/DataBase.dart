import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<void> opendatabase() async {
    print("opening the database");
    _database = await openDatabase(join(await getDatabasesPath(), 'wisely.db'),
        onCreate: (db, version) async {
      // Run the CREATE TABLE statement on the database.
      print("creating the tables");
      db.execute(
          'CREATE TABLE category(id TEXT PRIMARY KEY , title TEXT , amount INTEGER , icon INTEGER  )');
      db.execute(
        'CREATE TABLE expenses(id TEXT PRIMARY KEY, title TEXT, amount INTEGER , date_ex TEXT  , category TEXT ,FOREIGN KEY (category) REFERENCES category(id) ON DELETE SET NULL)',
      );

      db.execute("""
          CREATE TABLE source(
            id TEXT PRIMARY KEY, 
            title TEXT,
            amount INTEGER , 
            color INT 
          )
      """);
      db.execute("""
        CREATE TABLE income (
          id TEXT PRIMARY KEY , 
          title TEXT , 
          amount INTEGER  , 
          date_inc TEXT , 
          source TEXT , 
          FOREIGN KEY (source) REFERENCES source(id) ON DELETE SET NULL 
        )
      """);

      //trigger for the insertion
      await db.execute("""
        CREATE TRIGGER insert_expense
        AFTER INSERT ON expenses
        WHEN NEW.category IS NOT NULL
        BEGIN
          -- Update the category amount when a new expense is inserted
            UPDATE category SET amount = amount + NEW.amount WHERE id = NEW.category;
        END;
      """);

      //trigger for deleting
      await db.execute("""
        CREATE TRIGGER delete_expense
        AFTER DELETE ON expenses
        WHEN OLD.category IS NOT NULL
        BEGIN
          -- Update the category amount when an expense is deleted
            UPDATE category SET amount = amount - OLD.amount WHERE id = OLD.category;
        END;
      """);

      //trigger for category delete
      await db.execute("""
        CREATE TRIGGER delete_cetegory
        AFTER DELETE ON category
        FOR EACH ROW
        BEGIN
          UPDATE expenses SET category = NULL WHERE category = OLD.id ; 
        END ; 
""");
    }, version: 1);
    print("done creating ");
  }

  static Database? get database {
    if (_database == null) {
      opendatabase();
    }
    return _database;
  }
}
