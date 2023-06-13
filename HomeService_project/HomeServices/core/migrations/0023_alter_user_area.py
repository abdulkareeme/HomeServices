# Generated by Django 4.2.1 on 2023-06-10 14:08

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0024_alter_homeservice_description'),
        ('core', '0022_remove_balance_withdrawable_balance'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='area',
            field=models.ForeignKey(default=1, on_delete=django.db.models.deletion.SET_DEFAULT, related_name='user_area', to='services.area'),
        ),
    ]