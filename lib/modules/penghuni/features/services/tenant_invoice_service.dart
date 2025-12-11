import 'dart:io';

import 'package:boarding_house_app/models/invoice_model.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:flutter/painting.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TenantInvoiceService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  String getCategoryLabel(
    String category,
    double totalAmount,
    double paidAmount,
  ) {
    if (category == 'Full') {
      return 'paid';
    } else if (category == 'Partial') {
      if (paidAmount >= totalAmount) {
        return 'paid';
      } else {
        return 'partial';
      }
    } else {
      return 'unpaid';
    }
  }

  Future<InvoiceModel?> getLatestInvoice() async {
    final user = await authService.getCurrentUser();
    final userId = user?.id;

    final response = await supabase
        .from('invoices')
        .select('*, contracts!inner(*), payments(*)')
        .eq('contracts.tenant_id', userId ?? "")
        .order('created_at', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    final invoice = InvoiceModel.fromMap(response as Map<String, dynamic>);

    return invoice;
  }

  Future<List<InvoiceModel>> getAllInvoices() async {
    final user = await authService.getCurrentUser();
    final userId = user?.id;

    final response = await supabase
        .from('invoices')
        .select('*, contracts!inner(*), payments(*)')
        .eq('contracts.tenant_id', userId ?? "")
        .order('created_at', ascending: false);

    if (response == null) {
      return [];
    }

    final invoices = (response as List)
        .map(
          (invoiceData) =>
              InvoiceModel.fromMap(invoiceData as Map<String, dynamic>),
        )
        .toList();

    return invoices;
  }

  Future<void> createPayment(
    int invoiceId,
    Map<String, dynamic> paymentData,
  ) async {
    final totalAmountResponse = await supabase
        .from('invoices')
        .select('total_amount, payments!inner(amount)')
        .eq('id', invoiceId)
        .maybeSingle();

    final totalAmount = totalAmountResponse?['total_amount'] ?? 0;
    final payments = totalAmountResponse?['payments'] as List<dynamic>? ?? [];

    double paidAmount = 0;
    for (var payment in payments) {
      paidAmount += (payment['amount'] as num).toDouble();
    }

    final categoruLabel = getCategoryLabel(
      paymentData['category'],
      int.parse(totalAmount.toString()).toDouble(),
      paymentData['amount'] + paidAmount,
    );

    print('Updating invoice $invoiceId to status $categoruLabel');

    await supabase
        .from('invoices')
        .update({'status': categoruLabel})
        .eq('id', invoiceId);

    await supabase.from('payments').insert({
      'invoice_id': invoiceId,
      'method': paymentData['method'] == "Bank Transfer" ? 'bank' : 'cash',
      'amount': paymentData['amount'],
      'proof_document': paymentData['proof_document'],
      'payment_date': DateTime.now().toIso8601String(),
      'status': 'verified',
    });
  }

  Future<String?> uploadProofDocument(File file) async {
    final fileName = 'proof_${DateTime.now().millisecondsSinceEpoch}.png';
    try {
      await supabase.storage
          .from('payment-proofs')
          .uploadBinary(fileName, await file.readAsBytes());

      final publicUrl = supabase.storage
          .from('payment-proofs')
          .getPublicUrl(fileName);

      return publicUrl;
    } catch (e) {
      print('Exception during file upload: $e');
      return null;
    }
  }
}
