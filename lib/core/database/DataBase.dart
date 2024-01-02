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
      await db.execute(
          'CREATE TABLE category(id TEXT PRIMARY KEY , title TEXT , amount INTEGER , icon INTEGER  )');
      await db.execute("""
          CREATE TABLE source(
            id TEXT , 
            title TEXT,
            amount INTEGER DEFAULT 0, 
            PRIMARY KEY ( id , title) 
          )
      """);
      await db.execute(
        """
        CREATE TABLE expenses(
          id TEXT PRIMARY KEY,
          title TEXT,
          amount INTEGER ,
          date_ex TEXT  ,
          category TEXT ,
          source TEXT ,
          FOREIGN KEY (category) REFERENCES category(id) ON DELETE SET NULL ,
          FOREIGN KEY (source) REFERENCES source(id) ON DELETE SET NULL)
        """,
      );

      await db.execute("""
          CREATE TABLE goal (id INTEGER PRIMARY KEY , goal REAL)
""");
      await db.execute("""
        INSERT INTO goal (id , goal ) VALUES (0 , 0) ; 
""");

      await db.execute("""
        INSERT INTO source (id , title) VALUES (0 , "main") ; 
      """);
      await db.execute("""
        CREATE TABLE income (
          id TEXT PRIMARY KEY , 
          title TEXT , 
          amount INTEGER  , 
          date_inc TEXT , 
          source TEXT , 
          FOREIGN KEY (source) REFERENCES source(id) ON DELETE SET NULL 
        )
      """);

      await db.execute("""
          CREATE TRIGGER InsertIncome
          AFTER INSERT ON income
          FOR EACH ROW
          BEGIN
              UPDATE source SET amount = amount + NEW.amount WHERE id = NEW.source;
          END;
      """);
      await db.execute("""
        CREATE TRIGGER edit_income
        AFTER UPDATE on income 
        FOR EACH ROW 
        BEGIN 
          UPDATE source SET amount = amount - OLD.amount where id = OLD.source; 
          UPDATE source SET amount = amount + NEW.amount where id = NEW.source ; 
        end ; 
""");

      await db.execute("""
          CREATE TRIGGER DeleteIncome
          AFTER DELETE ON income
          FOR EACH ROW
          BEGIN
              UPDATE source SET amount = amount - OLD.amount WHERE id = OLD.source;
          END;
      """);

      //trigger for the insertion
      await db.execute("""
        CREATE TRIGGER insert_expense
        AFTER INSERT ON expenses
        BEGIN
          -- Update the category amount when a new expense is inserted
            UPDATE category SET amount = amount + NEW.amount WHERE id = NEW.category;
          -- UPDATE THE SOURCE 
            UPDATE source SET amount = amount - NEW.amount WHERE id = NEW.source ; 
        END;
      """);
      //edit expense
      await db.execute("""
      CREATE TRIGGER edit_expense
      AFTER UPDATE on expenses 
      FOR EACH ROW 
      BEGIN 
        UPDATE category SET amount = amount - OLD.amount where id = OLD.category; 
        UPDATE source SET amount = amount + OLD.amount where id = OLD.amount ; 
        UPDATE category SET amount = amount + NEW.amount where id = NEW.category ; 
        UPDATE source SET amount = amount - NEW.amount where id = NEW.amount ; 
      end ; 
""");
      //trigger for deleting
      await db.execute("""
        CREATE TRIGGER delete_expense
        AFTER DELETE ON expenses
        BEGIN 
          -- Update the category amount when an expense is deleted
            UPDATE category SET amount = amount - OLD.amount WHERE id = OLD.category;
            UPDATE source SET amount = amount + OLD.amount where id = OLD.source ; 
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
