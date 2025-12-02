import 'package:boarding_house_app/modules/admin/features/models/dashboard_contracts_model.dart';
import 'package:boarding_house_app/modules/admin/features/models/dashboard_room_model.dart';

class AdminDashboardState {
  final bool isLoadingContracts;
  final bool isLoadingRooms;
  final bool isLoadingPayments;
  final bool isLoadingMaintenance;

  final DashboardContractsModel? contracts;
  final DashboardRoomModel? rooms;
  final Map<String, dynamic>? payments;
  final Map<String, dynamic>? maintenance;

  final String? errorContracts;
  final String? errorRooms;
  final String? errorPayments;
  final String? errorMaintenance;

  const AdminDashboardState({
    this.isLoadingContracts = false,
    this.isLoadingRooms = false,
    this.contracts,
    this.rooms,
    this.errorContracts,
    this.errorRooms,
    this.isLoadingPayments = false,
    this.payments,
    this.errorPayments,
    this.isLoadingMaintenance = false,
    this.maintenance,
    this.errorMaintenance,
  });

  AdminDashboardState copyWith({
    bool? isLoadingContracts,
    bool? isLoadingRooms,
    DashboardContractsModel? contracts,
    DashboardRoomModel? rooms,
    String? errorContracts,
    String? errorRooms,
    bool? isLoadingPayments,
    Map<String, dynamic>? payments,
    String? errorPayments,
    bool? isLoadingMaintenance,
    Map<String, dynamic>? maintenance,
    String? errorMaintenance,
  }) {
    return AdminDashboardState(
      isLoadingContracts: isLoadingContracts ?? this.isLoadingContracts,
      isLoadingRooms: isLoadingRooms ?? this.isLoadingRooms,
      contracts: contracts ?? this.contracts,
      rooms: rooms ?? this.rooms,
      errorContracts: errorContracts ?? this.errorContracts,
      errorRooms: errorRooms ?? this.errorRooms,
      isLoadingPayments: isLoadingPayments ?? this.isLoadingPayments,
      payments: payments ?? this.payments,
      errorPayments: errorPayments ?? this.errorPayments,
      isLoadingMaintenance: isLoadingMaintenance ?? this.isLoadingMaintenance,
      maintenance: maintenance ?? this.maintenance,
      errorMaintenance: errorMaintenance ?? this.errorMaintenance,
    );
  }
}
