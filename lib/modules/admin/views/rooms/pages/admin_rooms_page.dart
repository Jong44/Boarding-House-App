import 'package:boarding_house_app/models/room_model.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_room_action_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_rooms_provider.dart';
import 'package:boarding_house_app/modules/admin/views/rooms/pages/admin_room_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// room List Page
class AdminRoomsPage extends ConsumerStatefulWidget {
  @override
  _AdminRoomsPageState createState() => _AdminRoomsPageState();
}

class _AdminRoomsPageState extends ConsumerState<AdminRoomsPage> {
  final TextEditingController _searchController = TextEditingController();
  void _onSearchChanged() {
    setState(() {
      // Implement search filtering logic if needed
    });
  }

  void _addroom() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminRoomFormPage(
          onSave: (newRoom) async {
            await ref
                .read(AdminRoomActionNotifierProvider.notifier)
                .createRoom(newRoom);
            await ref.read(adminRoomsProvider.notifier).refreshAll();
            // snackbar or feedback can be added here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Kamar berhasil ditambahkan')),
            );
          },
        ),
      ),
    );
  }

  void _editroom(RoomModel room, int id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminRoomFormPage(
          room: room,
          onSave: (updatedRoom) async {
            await ref
                .read(AdminRoomActionNotifierProvider.notifier)
                .updateRoom(id, updatedRoom);
            await ref.read(adminRoomsProvider.notifier).refreshAll();
            // snackbar or feedback can be added here
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Kamar berhasil diperbarui')),
            );
          },
        ),
      ),
    );
  }

  void _deleteroom(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Kamar'),
        content: Text('Apakah Anda yakin ingin menghapus kamar ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(AdminRoomActionNotifierProvider.notifier)
                  .deleteRoom(id);
              await ref.read(adminRoomsProvider.notifier).refreshAll();
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text('Kamar berhasil dihapus')));
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
    if (state.isLoadingRoom) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (state.rooms.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'Tidak ada properti tersedia.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addroom,
          backgroundColor: const Color(0xFFFF6B35),
          child: Icon(Icons.add, color: Colors.white),
        ),
      );
    }
    if (state.errorRoom != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'Error: ${state.errorRoom}',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
        ),
      );
    }

    final filteredRooms = state.rooms.where((room) {
      final query = _searchController.text.toLowerCase();
      return room.id.toString().toLowerCase().contains(query) ||
          room.description!.toLowerCase().contains(query);
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
                          hintText: 'Cari No Kamar...',
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
                itemCount: filteredRooms.length,
                itemBuilder: (context, index) {
                  final room = filteredRooms[index];
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
                                "Kamar ${room.id}",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text(
                                    room.description ??
                                        'Deskripsi tidak tersedia',
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
                                  onPressed: () =>
                                      _editroom(room, room.id ?? 0),
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
                                  onPressed: () => _deleteroom(room.id ?? 0),
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
        onPressed: _addroom,
        backgroundColor: const Color(0xFFFF6B35),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// room Form Page
