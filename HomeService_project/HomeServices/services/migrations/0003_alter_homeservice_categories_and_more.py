# Generated by Django 4.2.1 on 2023-05-18 15:58

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0005_user_area'),
        ('services', '0002_alter_homeservice_seller'),
    ]

    operations = [
        migrations.AlterField(
            model_name='homeservice',
            name='categories',
            field=models.ManyToManyField(related_name='home_services_categories', to='services.category'),
        ),
        migrations.AlterField(
            model_name='homeservice',
            name='seller',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='home_services_seller', to='core.normaluser'),
        ),
        migrations.AlterField(
            model_name='homeservice',
            name='service_area',
            field=models.ManyToManyField(related_name='home_services_area_set', to='services.area'),
        ),
    ]
