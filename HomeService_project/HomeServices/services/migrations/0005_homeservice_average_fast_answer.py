# Generated by Django 4.2.1 on 2023-05-18 21:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0004_homeservice_average_ratings_orderservice_end_service'),
    ]

    operations = [
        migrations.AddField(
            model_name='homeservice',
            name='average_fast_answer',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
