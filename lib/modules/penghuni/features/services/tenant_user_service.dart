import 'package:boarding_house_app/models/app_user.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TenantUserService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<AppUser> getUserProfile() async {
    final user = await authService.getCurrentUser();
    final userId = user?.id;

    final response = await supabase
        .from('users')
        .select('*, tenant_profile(*)')
        .eq('id', userId ?? "")
        .maybeSingle();

    print('User Profile Response: $response');

    if (response == null) {
      throw Exception('User not found');
    }
    final appUser = AppUser.fromMap(response as Map<String, dynamic>);
    return appUser;
  }

  Future<void> updateUserProfile(AppUser data) async {
    final user = await authService.getCurrentUser();
    final userId = user?.id;

    final response = await supabase
        .from('users')
        .update({
          'full_name': data.fullName,
          'email': data.email,
          'phone': data.phoneNumber,
        })
        .eq('id', userId ?? "");

    await supabase
        .from('tenant_profile')
        .update({
          'address': data.tenantDetails?.address,
          'birth_date': data.tenantDetails?.birthDate?.toIso8601String(),
        })
        .eq('user_id', userId ?? "");

    if (response == null) {
      throw Exception('Failed to update user profile');
    }
  }

  Future<void> logout() async {
    await authService.signOut();
  }
}
