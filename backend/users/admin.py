from django.contrib import admin
from .models import User

# Register your models here.

# register the custom user model in the django admin site
admin.site.register(User)
