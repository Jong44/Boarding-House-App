import 'package:boarding_house_app/modules/penghuni/features/models/tenant_create_ticket_request.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_invoice_service.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_maintance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class TenantTicketActionNotifier extends StateNotifier<AsyncValue<void>> {
  final TenantMaintanceService service;

  TenantTicketActionNotifier(this.service) : super(const AsyncValue.data(null));

  Future<void> createTicket({
    required TenantCreateTicketRequest request,
  }) async {
    state = const AsyncValue.loading();
    try {
      await service.createMaintenanceTicket(request: request);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print('Error creating tenant: $e');
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTicket(int ticketId) async {
    state = const AsyncValue.loading();
    try {
      await service.deleteMaintenanceTicket(ticketId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      print('Error deleting ticket: $e');
      state = AsyncValue.error(e, st);
    }
  }
}
