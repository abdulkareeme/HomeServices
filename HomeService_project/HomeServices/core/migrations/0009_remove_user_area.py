# Generated by Django 4.2.1 on 2023-05-18 16:18

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0008_alter_user_area'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='area',
        ),
    ]
