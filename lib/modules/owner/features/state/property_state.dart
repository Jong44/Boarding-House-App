import 'package:boarding_house_app/modules/owner/features/models/property_model.dart';

class PropertyState {
  final bool isLoading;
  final List<PropertyModel> properties;
  final String? error;

  const PropertyState({
    this.isLoading = false,
    this.properties = const [],
    this.error,
  });

  PropertyState copyWith({
    bool? isLoading,
    List<PropertyModel>? properties,
    String? error,
  }) {
    return PropertyState(
      isLoading: isLoading ?? this.isLoading,
      properties: properties ?? this.properties,
      error: error ?? this.error,
    );
  }
}
