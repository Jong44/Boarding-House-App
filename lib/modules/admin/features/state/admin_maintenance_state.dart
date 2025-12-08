import 'package:boarding_house_app/modules/admin/features/models/maintenance_model.dart';

class AdminMaintenanceState {
  final bool isLoading;
  final List<MaintenanceModel> maintenances;
  final List<MaintenanceModel> maintenancesFiltered;
  final String? error;

  const AdminMaintenanceState({
    this.isLoading = false,
    this.maintenances = const [],
    this.maintenancesFiltered = const [],
    this.error,
  });

  AdminMaintenanceState copyWith({
    bool? isLoading,
    List<MaintenanceModel>? maintenances,
    List<MaintenanceModel>? maintenancesFiltered,
    String? error,
  }) {
    return AdminMaintenanceState(
      isLoading: isLoading ?? this.isLoading,
      maintenances: maintenances ?? this.maintenances,
      maintenancesFiltered: maintenancesFiltered ?? this.maintenancesFiltered,
      error: error ?? this.error,
    );
  }
}
