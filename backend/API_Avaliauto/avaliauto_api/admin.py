from django.contrib import admin
from avaliauto_api.models import *
from django.contrib.auth.admin import UserAdmin
# Register your models here.
from django.contrib.auth.admin import UserAdmin

class CustomUserAdmin(UserAdmin):
    list_display = ('first_name','last_name','email','tel')
    ordering = ['email']

admin.site.register(Type)
admin.site.register(User,CustomUserAdmin)
admin.site.register(Consultancy)
# admin.site.register(Vehicle)