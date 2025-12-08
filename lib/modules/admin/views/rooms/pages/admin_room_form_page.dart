import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_room_action_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_rooms_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminRoomFormPage extends ConsumerStatefulWidget {
  final RoomModel? room;
  final Function(RoomModel) onSave;

  AdminRoomFormPage({this.room, required this.onSave});

  @override
  _AdminRoomFormPageState createState() => _AdminRoomFormPageState();
}

class _AdminRoomFormPageState extends ConsumerState<AdminRoomFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _descriptionController;
  int? _selectedPropertyId;
  int? _selectedRoomTypeId;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(
      text: widget.room?.description ?? '',
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _save(AsyncValue<void> stateAction) {
    if (_formKey.currentState!.validate()) {
      final room = RoomModel(
        propertyId: _selectedPropertyId ?? widget.room?.propertyId,
        roomTypeId: _selectedRoomTypeId ?? widget.room?.roomTypeId,
        status: widget.room?.status ?? 'available',
        description: _descriptionController.text,
      );
      widget.onSave(room);
      if (!stateAction.isLoading) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminRoomsProvider);
    final stateAction = ref.watch(AdminRoomActionNotifierProvider);
    if (state.isLoadingProperty || state.isLoadingRoomType) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (state.errorProperty != null || state.errorRoomType != null) {
      return Scaffold(
        body: Center(child: Text('Gagal memuat data. Silakan coba lagi.')),
      );
    }
    if (stateAction.isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    _selectedPropertyId ??=
        widget.room?.propertyId ??
        (state.properties.isNotEmpty ? state.properties.first.id : null);

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
          widget.room == null ? 'Tambah Kamar' : 'Edit Kamar',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Text(
              'Properti',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: _selectedPropertyId ?? widget.room?.propertyId,
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
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Silakan pilih properti';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text(
              'Tipe Kamar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: _selectedRoomTypeId ?? widget.room?.roomTypeId,
              items: state.roomTypes
                  .map(
                    (roomType) => DropdownMenuItem<int>(
                      value: roomType.id,
                      child: Text(roomType.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedRoomTypeId = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return 'Silakan pilih tipe kamar';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            Text(
              'Deskripsi',
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
                hintText: 'Contoh: Kamar dengan pemandangan laut',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Deskripsi tidak boleh kosong';
                }
                return null;
              },
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => _save(stateAction),
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
