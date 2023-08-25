import '../entities/BudgetCateg.dart';

abstract class BcatRepository {
  //add category
  Future<bool?> add_Bcat(BudgetCateg);
  //delete category
  Future<BudgetCateg> delete_Bcat(BudgetCateg);
  //edit category amount
  Future<bool> edit_Bcat_amount(double deferent);
  //edit category title
  Future<bool> edit_Bcat_title(String title); 
}
