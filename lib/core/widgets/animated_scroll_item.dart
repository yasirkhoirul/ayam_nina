import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimatedScrollItem extends StatefulWidget {
  final Widget child;
  final String id;
  final Duration duration;
  final Offset startOffset;

  const AnimatedScrollItem({
    super.key,
    required this.child,
    required this.id,
    this.duration = const Duration(milliseconds: 1000), // "jangan terlalu cepat"
    this.startOffset = const Offset(0, 50),
  });

  @override
  State<AnimatedScrollItem> createState() => _AnimatedScrollItemState();
}

class _AnimatedScrollItemState extends State<AnimatedScrollItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(begin: widget.startOffset, end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.id),
      onVisibilityChanged: (info) {
        // Anggap terlihat jika minimal 10% widget masuk ke viewport
        if (info.visibleFraction > 0.1 && !_isVisible) {
          if (mounted) {
            setState(() {
              _isVisible = true;
            });
            _controller.forward();
          }
        } 
        // Reset animasi jika benar-benar keluar layar (0%) agar mengulang saat masuk lagi
        else if (info.visibleFraction == 0.0 && _isVisible) {
          if (mounted) {
            setState(() {
              _isVisible = false;
            });
            _controller.reset();
          }
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.translate(
              offset: _slideAnimation.value,
              child: widget.child,
            ),
          );
        },
      ),
    );
  }
}
