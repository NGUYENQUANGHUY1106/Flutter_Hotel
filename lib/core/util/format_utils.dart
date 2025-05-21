import 'package:intl/intl.dart';

String formatCurrency(dynamic price) {
  final format = NumberFormat.currency(locale: 'vi_VN', symbol:'VNĐ', decimalDigits: 0);
  return format.format(price);
}
