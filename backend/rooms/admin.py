from django.contrib import admin
from .models import Building, Equipment, Room

# Register your models here.

# register the building, equipment, and room models in the django admin site
admin.site.register(Building)
admin.site.register(Equipment)
admin.site.register(Room)
