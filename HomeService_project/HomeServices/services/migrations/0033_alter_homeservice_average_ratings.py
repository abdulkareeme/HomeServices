# Generated by Django 4.2.1 on 2023-06-26 12:00

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0032_alter_earnings_created_date'),
    ]

    operations = [
        migrations.AlterField(
            model_name='homeservice',
            name='average_ratings',
            field=models.FloatField(default=0),
        ),
    ]
