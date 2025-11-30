import 'package:boarding_house_app/modules/admin/shared/admin_index_page.dart';
import 'package:boarding_house_app/modules/auth/pages/login_page.dart';
import 'package:boarding_house_app/modules/owner/shared/owner_index_page.dart';
import 'package:boarding_house_app/modules/penghuni/shared/index_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // For testing: change home to OwnerIndexPage() to test owner module
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boarding House App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const OwnerIndexPage(),
    );
  }
}
