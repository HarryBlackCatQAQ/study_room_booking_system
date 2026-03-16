from rest_framework import serializers
from .models import Building, Equipment, Room

# serializer for building data shown in room responses
class BuildingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Building
        fields = ['id', 'name', 'campus_area', 'opening_hours']


# serializer for equipment data shown in room responses
class EquipmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Equipment
        fields = ['id', 'name', 'status']

# serializer for read-only room responses with nested building and equipment data
class RoomSerializer(serializers.ModelSerializer):
    building = BuildingSerializer(read_only=True)
    equipment = EquipmentSerializer(read_only=True, many=True)

    class Meta:
        model = Room
        fields = ['id', 'name', 'capacity', 'location', 'is_active', 'building', 'equipment']





# serializer for admin create and update requests
class RoomCreateUpdateSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = ['id', 'name', 'capacity', 'location', 'is_active', 'building', 'equipment']
