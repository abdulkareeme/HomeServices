# Generated by Django 4.2.1 on 2023-06-10 12:08

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0020_inputdata_inputfield_alter_orderservice_home_service_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='inputfield',
            old_name='type',
            new_name='field_type',
        ),
    ]
