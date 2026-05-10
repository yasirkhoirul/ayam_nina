/// Formats a number into Indonesian Rupiah format
/// Example: 1000000 -> "Rp 1.000.000"
String formatRupiah(num amount) {
  final absAmount = amount.abs().toStringAsFixed(0);
  final reversed = absAmount.split('').reversed.join();
  
  final groups = <String>[];
  for (int i = 0; i < reversed.length; i += 3) {
    final end = (i + 3 > reversed.length) ? reversed.length : i + 3;
    groups.add(reversed.substring(i, end));
  }
  
  final formatted = groups.join('.').split('').reversed.join();
  return 'Rp $formatted';
}

/// Formats a number with thousands separator (dot)
/// Example: 1000000 -> "1.000.000"
String formatNumber(num amount) {
  final absAmount = amount.abs().toStringAsFixed(0);
  final reversed = absAmount.split('').reversed.join();
  
  final groups = <String>[];
  for (int i = 0; i < reversed.length; i += 3) {
    final end = (i + 3 > reversed.length) ? reversed.length : i + 3;
    groups.add(reversed.substring(i, end));
  }
  
  return groups.join('.').split('').reversed.join();
}
