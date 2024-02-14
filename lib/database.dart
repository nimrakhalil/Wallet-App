import 'package:hive/hive.dart';

class Database {
  int totalAmount = 0;
  List expenselist = [];
  //String _date = '';

  final box = Hive.box('mybox');

  void load() {
    totalAmount = box.get('balance');
    expenselist = box.get('list');
    // _date = box.get("date");
  }

  void save() {
    box.put('list', expenselist);
    box.put('balance', totalAmount);
    // box.put("date", _date);
  }
}
