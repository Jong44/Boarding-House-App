
class AdminContractState {
  final bool isLoading;
  final Map<String, dynamic> contracts;
  final String? error;

  const AdminContractState({
    this.isLoading = false,
    this.contracts = const {},
    this.error,
  });

  AdminContractState copyWith({
    bool? isLoading,
    Map<String, dynamic>? contracts,
    String? error,
  }) {
    return AdminContractState(
      isLoading: isLoading ?? this.isLoading,
      contracts: contracts ?? this.contracts,
      error: error ?? this.error,
    );
  }
}
