import 'package:boarding_house_app/modules/admin/features/notifier/admin_invoice_action_notifier.dart';
import 'package:boarding_house_app/modules/admin/features/service/contract_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final adminInvoiceActionNotifier = Provider((ref) => ContractService());

final adminInvoiceActionNotifierProvider =
    StateNotifierProvider<AdminInvoiceActionNotifier, AsyncValue<void>>(
      (ref) => AdminInvoiceActionNotifier(ref.read(adminInvoiceActionNotifier)),
    );
