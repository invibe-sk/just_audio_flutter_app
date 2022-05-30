import 'package:flutter/foundation.dart';

class LoginScreenState {
  final loading = ValueNotifier<bool>(false);

  void setLoading(bool value) {
    loading.value = value;
  }
}