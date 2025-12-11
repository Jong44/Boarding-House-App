import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/models/room_type_model.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_room_action_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_room_type_action_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_rooms_provider.dart';
import 'package:boarding_house_app/modules/admin/views/room_type/pages/admin_form_room_type_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Property List Page
class AdminRoomTypePage extends ConsumerStatefulWidget {
  @override
  _AdminRoomTypePageState createState() => _AdminRoomTypePageState();
}

class _AdminRoomTypePageState extends ConsumerState<AdminRoomTypePage> {
  final TextEditingController _searchController = TextEditingController();
  void _onSearchChanged() {
    setState(() {
      // Implement search filtering logic if needed
    });
  }

  void _addProperty() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminFormRoomTypePage(
          onSave: (newRoom) async {
            await ref
                .read(AdminRoomTypeActionNotifierProvider.notifier)
                .createRoom(newRoom);
            await ref.read(adminRoomsProvider.notifier).refreshAll();
          },
        ),
      ),
    );
  }

  void _editProperty(RoomTypeModel property, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminFormRoomTypePage(
          roomType: property,
          onSave: (updatedProperty) async {
            await ref
                .read(AdminRoomTypeActionNotifierProvider.notifier)
                .updateRoom(id, updatedProperty);
            await ref.read(adminRoomsProvider.notifier).refreshAll();
          },
        ),
      ),
    );
  }

  void _deleteProperty(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Tipe Kamar'),
        content: Text('Apakah Anda yakin ingin menghapus tipe kamar ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(AdminRoomTypeActionNotifierProvider.notifier)
                  .deleteRoomType(id);
              await ref.read(adminRoomsProvider.notifier).refreshAll();
              Navigator.pop(context);
            },
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(adminRoomsProvider);

    if (state.isLoadingRoomType) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.errorRoomType != null) {
      return Scaffold(
        body: Center(
          child: Text(
            'Error: ${state.errorRoomType}',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    final filteredRoomTypes = state.roomTypes.where((roomType) {
      final query = _searchController.text.toLowerCase();
      return roomType.name.toLowerCase().contains(query) ||
          roomType.description.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) => _onSearchChanged(),
                        decoration: const InputDecoration(
                          hintText: 'Cari Tipe Kamar...',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Color(0xFF9CA3AF),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: filteredRoomTypes.length,
                itemBuilder: (context, index) {
                  final roomTypes = filteredRoomTypes[index];
                  return Card(
                    elevation: 0,
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: const Color(0xFFFF6B35).withOpacity(0.4),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                roomTypes.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    roomTypes.description,
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.orange.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.orange,
                                    size: 20,
                                  ),
                                  onPressed: () => _editProperty(
                                    roomTypes,
                                    roomTypes.id ?? 0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 20,
                                  ),
                                  onPressed: () =>
                                      _deleteProperty(roomTypes.id ?? 0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProperty,
        backgroundColor: const Color(0xFFFF6B35),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Property Form Page
