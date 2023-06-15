import 'package:intl/intl.dart';

class Shape{
  static String toYenFormat(int money){
    final yenFormatter = NumberFormat("#,###");
    String result = yenFormatter.format(money);

    return result;
  }
}