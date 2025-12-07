import 'package:boarding_house_app/models/contract_model.dart';

class AdminContractState {
  final bool isLoading;
  final Map<String, dynamic> contracts;
  final List<ContractModel> contractsFiltered;
  final String? error;

  const AdminContractState({
    this.isLoading = false,
    this.contracts = const {},
    this.contractsFiltered = const [],
    this.error,
  });

  AdminContractState copyWith({
    bool? isLoading,
    Map<String, dynamic>? contracts,
    List<ContractModel>? contractsFiltered,
    String? error,
  }) {
    return AdminContractState(
      isLoading: isLoading ?? this.isLoading,
      contracts: contracts ?? this.contracts,
      contractsFiltered: contractsFiltered ?? this.contractsFiltered,
      error: error ?? this.error,
    );
  }
}
