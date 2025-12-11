import 'package:boarding_house_app/modules/penghuni/features/notifier/tenant_invoice_action_notifier.dart';
import 'package:boarding_house_app/modules/penghuni/features/notifier/tenant_ticket_action_notifier.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_maintance_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final tenantTicketActionNotifier = Provider((ref) => TenantMaintanceService());

final tenantTicketActionNotifierProvider =
    StateNotifierProvider<TenantTicketActionNotifier, AsyncValue<void>>(
      (ref) => TenantTicketActionNotifier(ref.read(tenantTicketActionNotifier)),
    );
