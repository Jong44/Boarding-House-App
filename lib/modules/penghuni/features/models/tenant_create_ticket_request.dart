class TenantCreateTicketRequest {
  final int roomId;
  final String description;

  final Map<String, String> errors = {};

  TenantCreateTicketRequest({required this.roomId, required this.description});

  bool validate() {
    errors.clear();

    // roomId validation
    if (roomId == 0) {
      errors['roomId'] = 'ID kamar harus diisi.';
    }

    // description validation
    if (description.isEmpty) {
      errors['description'] = 'Deskripsi masalah harus diisi.';
    }

    return errors.isEmpty;
  }

  Map<String, dynamic> toJson() {
    return {'roomId': roomId, 'description': description};
  }
}
