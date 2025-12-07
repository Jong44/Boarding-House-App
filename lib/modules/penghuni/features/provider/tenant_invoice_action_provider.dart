import 'package:boarding_house_app/modules/penghuni/features/notifier/tenant_invoice_action_notifier.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_invoice_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final tenantInvoiceActionNotifier = Provider((ref) => TenantInvoiceService());

final tenantInvoiceActionNotifierProvider =
    StateNotifierProvider<TenantInvoiceActionNotifier, AsyncValue<void>>(
      (ref) =>
          TenantInvoiceActionNotifier(ref.read(tenantInvoiceActionNotifier)),
    );
