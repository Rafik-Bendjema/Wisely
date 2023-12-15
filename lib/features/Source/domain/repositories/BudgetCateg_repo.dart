import '../entities/Source.dart';

abstract class BcatRepository {
  //add category
  Future<bool?> add_Bcat(Source);
  //delete category
  Future<Source> delete_Bcat(Source);
  //edit category amount
  Future<bool> edit_Bcat_amount(double deferent);
  //edit category title
  Future<bool> edit_Bcat_title(String title);
}
