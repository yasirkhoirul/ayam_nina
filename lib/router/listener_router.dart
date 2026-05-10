import 'dart:async';

import 'package:flutter/material.dart';

class ListenerRouter extends ChangeNotifier{
  final Stream stream;
  late StreamSubscription subscription;
  ListenerRouter(this.stream){
    subscription = stream.listen((event) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}