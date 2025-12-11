import 'package:boarding_house_app/modules/penghuni/features/notifier/tenant_user_action_notifier.dart';
import 'package:boarding_house_app/modules/penghuni/features/services/tenant_user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final tenantUserServiceProvider = Provider((ref) => TenantUserService());

final tenantUserActionNotifierProvider =
    StateNotifierProvider<TenantUserActionNotifier, AsyncValue<void>>(
      (ref) => TenantUserActionNotifier(ref.read(tenantUserServiceProvider)),
    );
