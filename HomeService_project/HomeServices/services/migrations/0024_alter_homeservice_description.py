# Generated by Django 4.2.1 on 2023-06-10 14:04

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0023_alter_homeservice_category'),
    ]

    operations = [
        migrations.AlterField(
            model_name='homeservice',
            name='description',
            field=models.CharField(max_length=500),
        ),
    ]