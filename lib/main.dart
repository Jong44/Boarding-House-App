import 'package:boarding_house_app/models/app_user.dart';
import 'package:boarding_house_app/modules/admin/shared/admin_index_page.dart';
import 'package:boarding_house_app/modules/auth/pages/login_page.dart';
import 'package:boarding_house_app/modules/owner/shared/owner_index_page.dart';
import 'package:boarding_house_app/modules/penghuni/shared/index_page.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://srlbmpmsnmtuookatahs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNybGJtcG1zbm10dW9va2F0YWhzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ0MjY0NzAsImV4cCI6MjA4MDAwMjQ3MH0.mR_r5Pv_kavOp6n4dnoK1eFZ-tE_8nVvuXtj0bJUZvU',
  );

  await Supabase.instance.client.auth.onAuthStateChange.first;

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  late Future<AppUser?> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = _authService.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boarding House App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FutureBuilder<AppUser?>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            final role = user.role ?? 'tenant';

            if (role == 'admin') {
              return const AdminIndexPage();
            } else {
              return const IndexPage();
            }
          }

          return const LoginPage();
        },
      ),
    );
  }
}
