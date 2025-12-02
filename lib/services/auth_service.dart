import 'package:boarding_house_app/models/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<AuthResponse> signUp(String email, String password) async {
    final AuthResponse res = await supabase.auth.signUp(
      email: email,
      password: password,
    );
    final User? user = res.user;

    await supabase.from('users').insert({'email': user?.email});

    return res;
  }

  Future<AuthResponse> signIn(String email, String password) async {
    final AuthResponse res = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final User? user = res.user;

    final response = await supabase
        .from('users')
        .select()
        .eq('email', user?.email ?? "")
        .maybeSingle();
    if (response == null) {
      throw Exception('User data not found in database');
    }

    return res;
  }

  Future<void> signOut() => supabase.auth.signOut();

  Session? getSession() => supabase.auth.currentSession;

  Future<AppUser?> getCurrentUser() async {
    final email = supabase.auth.currentUser?.email;
    if (email == null) return null;

    final response = await supabase
        .from('users')
        .select()
        .eq('email', email)
        .maybeSingle();

    if (response == null) return null;

    return AppUser.fromMap(response);
  }

  Stream<AuthState> get authChanges => supabase.auth.onAuthStateChange;
}
