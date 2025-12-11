import 'package:boarding_house_app/models/app_user.dart';
import 'package:boarding_house_app/models/contract_model.dart';
import 'package:boarding_house_app/models/invoice_model.dart';
import 'package:boarding_house_app/models/properties_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/dashboard_contracts_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/dashboard_room_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/maintenance_model.dart';

class TenantDashboardTenantsState {
  final bool isLoadingContract;
  final bool isLoadingInvoice;
  final bool isLoadingMaintenance;
  final bool isLoadingProfile;

  final ContractModel? contract;
  final InvoiceModel? invoice;
  final List<MaintenanceModel>? maintenance;
  final AppUser? userProfile;

  final String? errorContract;
  final String? errorInvoice;
  final String? errorMaintenance;
  final String? errorProfile;

  const TenantDashboardTenantsState({
    this.isLoadingContract = false,
    this.isLoadingInvoice = false,
    this.isLoadingMaintenance = false,
    this.isLoadingProfile = false,
    this.maintenance,
    this.contract,
    this.invoice,
    this.userProfile,
    this.errorContract,
    this.errorInvoice,
    this.errorMaintenance,
    this.errorProfile,
  });

  TenantDashboardTenantsState copyWith({
    bool? isLoadingContract,
    bool? isLoadingInvoice,
    bool? isLoadingMaintenance,
    bool? isLoadingProfile,
    ContractModel? contract,
    InvoiceModel? invoice,
    List<MaintenanceModel>? maintenance,
    AppUser? userProfile,
    String? errorContract,
    String? errorInvoice,
    String? errorMaintenance,
    String? errorProfile,
  }) {
    return TenantDashboardTenantsState(
      isLoadingContract: isLoadingContract ?? this.isLoadingContract,
      isLoadingInvoice: isLoadingInvoice ?? this.isLoadingInvoice,
      isLoadingMaintenance: isLoadingMaintenance ?? this.isLoadingMaintenance,
      isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
      contract: contract ?? this.contract,
      invoice: invoice ?? this.invoice,
      maintenance: maintenance ?? this.maintenance,
      userProfile: userProfile ?? this.userProfile,
      errorContract: errorContract ?? this.errorContract,
      errorInvoice: errorInvoice ?? this.errorInvoice,
      errorMaintenance: errorMaintenance ?? this.errorMaintenance,
      errorProfile: errorProfile ?? this.errorProfile,
    );
  }
}
