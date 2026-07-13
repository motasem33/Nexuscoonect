import 'package:flutter/material.dart';
import '../../../core/api/api_service.dart';
import '../models/user_model.dart';

enum ViewState { initial, loading, loaded, error }

class UserViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<User> _users = [];
  List<User> get users => _users;

  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchUsers() async {
    _state = ViewState.loading;
    notifyListeners();

    try {
      final List<dynamic> data = await _apiService.get('/users');
      _users = data.map((json) => User.fromJson(json)).toList();
      _state = ViewState.loaded;
    } catch (e) {
      _errorMessage = e.toString();
      _state = ViewState.error;
    } finally {
      notifyListeners();
    }
  }
}
