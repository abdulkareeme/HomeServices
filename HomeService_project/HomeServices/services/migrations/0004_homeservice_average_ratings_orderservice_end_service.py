# Generated by Django 4.2.1 on 2023-05-18 21:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0003_alter_homeservice_categories_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='homeservice',
            name='average_ratings',
            field=models.IntegerField(default=0),
        ),
        migrations.AddField(
            model_name='orderservice',
            name='end_service',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]