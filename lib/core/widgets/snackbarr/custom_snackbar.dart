import 'package:flutter/material.dart';
import 'package:kedai_ayam_nina/core/constant/enum.dart';

class CustomSnackbar extends SnackBar {
  final String message;
  final SnackBarState state;

  CustomSnackbar({super.key, required this.message, required this.state})
    : super(
        // Kita atur konfigurasi SnackBar-nya di sini
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        content: _SnackbarDesign(message: message, state: state),
      );
}

class _SnackbarDesign extends StatelessWidget {
  final String message;
  final SnackBarState state;

  const _SnackbarDesign({required this.message, required this.state});

  Color _getBackgroundColor() {
    switch (state) {
      case SnackBarState.success:
        return const Color.fromARGB(255, 65, 134, 67);
      case SnackBarState.error:
        return const Color.fromARGB(255, 184, 75, 67);
      case SnackBarState.info:
        return const Color.fromARGB(255, 68, 151, 219);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(_getIcon(), color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    switch (state) {
      case SnackBarState.success:
        return Icons.check_circle_outline;
      case SnackBarState.error:
        return Icons.error_outline;
      case SnackBarState.info:
        return Icons.info_outline;
    }
  }
}
