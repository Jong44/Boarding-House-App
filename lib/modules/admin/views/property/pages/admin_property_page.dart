import 'package:boarding_house_app/models/properties_model.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_property_action_provider.dart';
import 'package:boarding_house_app/modules/admin/features/provider/admin_rooms_provider.dart';
import 'package:boarding_house_app/modules/admin/views/property/pages/admin_property_form_page.dart';
import 'package:boarding_house_app/modules/owner/features/models/property_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Property List Page
class AdminPropertyPage extends ConsumerStatefulWidget {
  @override
  _AdminPropertyPageState createState() => _AdminPropertyPageState();
}

class _AdminPropertyPageState extends ConsumerState<AdminPropertyPage> {
  final TextEditingController _searchController = TextEditingController();
  void _onSearchChanged() {
    setState(() {});
  }

  void _addProperty() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyFormPage(
          onSave: (property) async {
            await ref
                .read(AdminPropertyActionNotifierProvider.notifier)
                .createProperty(property);
            await ref.read(adminRoomsProvider.notifier).refreshAll();
          },
        ),
      ),
    );
  }

  void _editProperty(PropertiesModel property) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PropertyFormPage(
          property: property,
          onSave: (updatedProperty) async {
            await ref
                .read(AdminPropertyActionNotifierProvider.notifier)
                .updateProperty(updatedProperty, property.id ?? 0);
            await ref.read(adminRoomsProvider.notifier).refreshAll();
          },
        ),
      ),
    );
  }

  void _deleteProperty(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Properti'),
        content: Text('Apakah Anda yakin ingin menghapus properti ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref
                  .read(AdminPropertyActionNotifierProvider.notifier)
                  .deleteProperty(index);
              ref.read(adminRoomsProvider.notifier).refreshAll();
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

    if (state.isLoadingProperty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.errorProperty != null) {
      return Scaffold(
        body: Center(child: Text('Error: ${state.errorProperty}')),
      );
    }

    final properties = state.properties.where((property) {
      final query = _searchController.text.toLowerCase();
      return property.name.toLowerCase().contains(query);
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
                          hintText: 'Cari Nama Properti...',
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
                itemCount: properties.length,
                itemBuilder: (context, index) {
                  final property = properties[index];
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
                                property.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    property.address,
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
                                  onPressed: () => _editProperty(property),
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
                                      _deleteProperty(property.id ?? 0),
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
