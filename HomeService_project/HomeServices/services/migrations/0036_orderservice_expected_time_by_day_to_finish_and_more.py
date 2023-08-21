# Generated by Django 4.2.1 on 2023-06-28 15:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0035_alter_orderservice_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='orderservice',
            name='expected_time_by_day_to_finish',
            field=models.PositiveIntegerField(null=True),
        ),
        migrations.AddField(
            model_name='orderservice',
            name='is_rateable',
            field=models.BooleanField(default=False),
        ),
        migrations.AlterField(
            model_name='rating',
            name='client_comment',
            field=models.CharField(max_length=1000),
        ),
    ]