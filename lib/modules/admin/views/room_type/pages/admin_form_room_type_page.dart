import 'package:boarding_house_app/models/room_type_model.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminFormRoomTypePage extends ConsumerStatefulWidget {
  final RoomTypeModel? roomType;
  final Function(RoomTypeModel) onSave;

  AdminFormRoomTypePage({this.roomType, required this.onSave});

  @override
  _AdminFormRoomTypePageState createState() => _AdminFormRoomTypePageState();
}

class _AdminFormRoomTypePageState extends ConsumerState<AdminFormRoomTypePage> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedPropertyId;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.roomType?.name ?? '');
    _descriptionController = TextEditingController(
      text: widget.roomType?.description ?? '',
    );
    _selectedPropertyId = widget.roomType?.propertyId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final property = RoomTypeModel(
        name: _nameController.text,
        description: _descriptionController.text,
        propertyId: _selectedPropertyId!,
      );
      widget.onSave(property);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminRoomsProvider);
    if (state.isLoadingProperty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.errorProperty != null) {
      return Scaffold(
        body: Center(child: Text('Error: ${state.errorProperty}')),
      );
    }

    _selectedPropertyId ??= state.properties.isNotEmpty
        ? state.properties.first.id
        : null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.roomType == null ? 'Tambah Properti' : 'Edit Properti',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'Nama Tipe Kamar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: _selectedPropertyId,
              items: state.properties
                  .map(
                    (property) => DropdownMenuItem<int>(
                      value: property.id,
                      child: Text(property.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPropertyId = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Pilih Properti',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Properti harus dipilih';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Nama Tipe Kamar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Contoh: Kamar besar, Kamar kecil',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tipe kamar harus diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text(
              'Alamat',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Contoh: Kamar 1, Bulanan',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deskripsi harus diisi';
                }
                return null;
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Simpan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
