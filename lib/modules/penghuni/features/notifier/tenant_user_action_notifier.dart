import 'package:boarding_house_app/models/app_user.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_invoice_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TenantUserActionNotifier extends StateNotifier<AsyncValue<void>> {
  final TenantUserService service;

  TenantUserActionNotifier(this.service) : super(const AsyncValue.data(null));

  Future<void> updateUserProfile(int invoiceId, AppUser paymentData) async {
    state = const AsyncValue.loading();
    try {
      await service.updateUserProfile(paymentData);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print('Error updating user profile: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await service.logout();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print('Error during logout: $e');
      state = AsyncValue.error(e, st);
    }
  }
}
