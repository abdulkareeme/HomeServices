# Generated by Django 4.2.1 on 2023-06-26 13:17

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0033_alter_homeservice_average_ratings'),
    ]

    operations = [
        migrations.AlterField(
            model_name='orderservice',
            name='status',
            field=models.CharField(choices=[('Underway', 'Underway'), ('Expire', 'Expire'), ('Pending', 'Pending'), ('Rejected', 'Rejected'), ('under review', 'Under review')], default='Pending', max_length=50),
        ),
    ]
