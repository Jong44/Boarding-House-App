import 'package:boarding_house_app/models/properties_model.dart';
import 'package:boarding_house_app/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PropertiesService {
  final supabase = Supabase.instance.client;
  AuthService authService = AuthService();

  Future<List<PropertiesModel>> getAllProperties() async {
    final response = await supabase.from('properties').select();

    final data = (response as List)
        .map((e) => e as Map<String, dynamic>)
        .toList();

    return data.map((e) => PropertiesModel.fromJson(e)).toList();
  }

  Future<void> createProperty(PropertiesModel property) async {
    final newProperty = {
      'owner_id': 6,
      'name': property.name,
      'address': property.address,
    };
    await supabase.from('properties').insert(newProperty);
  }

  Future<void> updateProperty(PropertiesModel property, int id) async {
    final updatedProperty = {
      'name': property.name,
      'address': property.address,
    };
    final response = await supabase
        .from('properties')
        .update(updatedProperty)
        .eq('id', id);

    if (response.error != null) {
      throw Exception('Failed to update property: ${response.error!.message}');
    }
  }

  Future<void> deleteProperty(int propertyId) async {
    final response = await supabase
        .from('properties')
        .delete()
        .eq('id', propertyId);

    if (response.error != null) {
      throw Exception('Failed to delete property: ${response.error!.message}');
    }
  }
}
