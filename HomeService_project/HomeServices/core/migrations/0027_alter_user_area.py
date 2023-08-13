# Generated by Django 4.2.1 on 2023-06-27 11:00

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("services", "0035_alter_orderservice_status"),
        ("core", "0026_alter_user_area"),
    ]

    operations = [
        migrations.AlterField(
            model_name="user",
            name="area",
            field=models.ForeignKey(
                on_delete=django.db.models.deletion.CASCADE,
                related_name="user_area",
                to="services.area",
            ),
        ),
    ]