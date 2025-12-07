import 'package:boarding_house_app/modules/admin/features/models/create_tenant_request_model.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_contract_action_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_dashboard_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_tenants_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminCreateTenantPage extends ConsumerStatefulWidget {
  const AdminCreateTenantPage({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminCreateTenantPage> createState() =>
      _AdminCreateTenantPageState();
}

class _AdminCreateTenantPageState extends ConsumerState<AdminCreateTenantPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _contractNumberController = TextEditingController();
  final _notesController = TextEditingController();
  final _priceController = TextEditingController();

  String? _selectedPropertyType;
  String? _selectedRoom;
  String? _selectedContractDuration;
  String? _selectedRoomType;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _contractNumberController.dispose();
    _notesController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFF6B35),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _refreshData() async {
    await ref.read(adminTenantsProvider.notifier).refreshContracts();
    await ref.read(dashboardProvider.notifier).refreshAll();
  }

  Future<void> _submitForm(
    BuildContext context,
    AsyncValue<void> submitState,
  ) async {
    if (_formKey.currentState!.validate()) {
      if (submitState.isLoading) {
        return;
      }

      final request = CreateTenantRequestModel(
        fullName: _nameController.text,
        phoneNumber: _phoneController.text,
        email: _emailController.text,
        address: _addressController.text,
        categoryContract: _selectedContractDuration ?? 'monthly',
        startDate: _startDate ?? DateTime.now(),
        price: double.tryParse(_priceController.text) ?? 0.0,
      );

      if (!request.validate()) {
        // Show error messages
        final errorMessages = request.errors.values.join('\n');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessages)));
        return;
      }

      ref
          .read(adminTenantActionNotifierProvider.notifier)
          .createTenant(request.toMap())
          .then((_) async {
            await _refreshData();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Tenant berhasil dibuat.')),
            );
          })
          .catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal membuat tenant: $error')),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(dashboardProvider);
    final submitState = ref.watch(adminTenantActionNotifierProvider);

    if (state.isLoadingProperties) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorProperties != null) {
      return Center(child: Text(state.errorProperties!));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Tambah Penyewa',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('Identitas Penyewa'),
            const SizedBox(height: 12),
            _buildWhiteCard([
              _buildTextField(
                controller: _nameController,
                label: 'Nama Lengkap',
                hint: 'Masukkan nama lengkap',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _phoneController,
                label: 'Nomor HP',
                hint: '08xxxxxxxxxx',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nomor HP wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'email@example.com',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _addressController,
                label: 'Alamat (Opsional)',
                hint: 'Alamat lengkap',
                icon: Icons.home_outlined,
                maxLines: 2,
              ),
            ]),

            const SizedBox(height: 24),
            _buildSectionTitle('Informasi Kamar'),
            const SizedBox(height: 12),
            _buildWhiteCard([
              _buildDropdown(
                label: 'Properti',
                value: _selectedPropertyType,
                items:
                    state.properties?.map((e) => e.name).toSet().toList() ?? [],
                hint: 'Pilih properti',
                icon: Icons.apartment_outlined,
                onChanged: (value) {
                  setState(() {
                    _selectedPropertyType = value;
                    _selectedRoom = null; // Reset room selection
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: 'Nomor Kamar',
                value: _selectedRoom,
                items:
                    state.properties
                        ?.firstWhere(
                          (prop) => prop.name == _selectedPropertyType,
                          orElse: () => state.properties!.first,
                        )
                        ?.rooms
                        ?.map((e) => e.id.toString())
                        .toList() ??
                    [],
                hint: 'Pilih nomor kamar',
                icon: Icons.meeting_room_outlined,
                onChanged: (value) {
                  setState(() {
                    _selectedRoom = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdown(
                label: 'Tipe Kamar',
                value: _selectedRoomType,
                items:
                    state.properties
                        ?.firstWhere(
                          (prop) => prop.id.toString() == _selectedPropertyType,
                          orElse: () => state.properties!.first,
                        )
                        ?.roomTypes
                        ?.map((e) => e.name)
                        .toList() ??
                    [],

                hint: 'Pilih tipe kamar',
                icon: Icons.meeting_room_outlined,
                onChanged: (value) {
                  setState(() {
                    _selectedRoomType = value;
                  });
                },
              ),
            ]),

            const SizedBox(height: 24),
            _buildSectionTitle('Informasi Kontrak'),
            const SizedBox(height: 12),
            _buildWhiteCard([
              _buildDropdown(
                label: 'Category Kontrak',
                value: _selectedContractDuration,
                items: ['monthly', 'yearly'],
                hint: 'Pilih durasi',
                icon: Icons.calendar_today_outlined,
                onChanged: (value) {
                  setState(() {
                    _selectedContractDuration = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Tanggal Mulai',
                date: _startDate,
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _priceController,
                label: 'Harga',
                hint: 'Masukkan harga',
                icon: Icons.attach_money_outlined,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga wajib diisi';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Harga harus berupa angka';
                  }
                  return null;
                },
              ),
            ]),

            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Color(0xFFFF6B35)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Batal',
                      style: TextStyle(
                        color: Color(0xFFFF6B35),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle submit
                        if (submitState.isLoading) return;

                        _submitForm(context, submitState);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B35),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Simpan Penyewa',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildWhiteCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            prefixIcon: Icon(icon, color: const Color(0xFFFF6B35), size: 20),
            filled: true,
            fillColor: const Color(0xFFF8F8F8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFFF6B35), width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required String hint,
    required IconData icon,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFFFF6B35), size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Color(0xFFFF6B35),
                  width: 1,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
            ),
            hint: Text(
              hint,
              style: TextStyle(color: Colors.grey[400], fontSize: 14),
            ),
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFFFF6B35),
                  size: 20,
                ),
                const SizedBox(width: 12),
                Text(
                  date != null
                      ? '${date.day}/${date.month}/${date.year}'
                      : 'Pilih tanggal',
                  style: TextStyle(
                    color: date != null ? Colors.black87 : Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
