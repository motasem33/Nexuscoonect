import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'features/users/viewmodels/user_viewmodel.dart';
import 'features/users/views/users_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp(
        title: 'SaaS Directory',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const UsersScreen(),
      ),
    );
  }
}
