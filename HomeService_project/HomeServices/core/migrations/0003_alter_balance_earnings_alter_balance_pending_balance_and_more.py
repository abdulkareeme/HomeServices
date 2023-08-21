# Generated by Django 4.2.1 on 2023-05-16 22:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_alter_user_gender_alter_user_photo_normaluser_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='balance',
            name='earnings',
            field=models.PositiveIntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='balance',
            name='pending_balance',
            field=models.PositiveIntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='balance',
            name='total_balance',
            field=models.PositiveIntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='balance',
            name='withdrawable_balance',
            field=models.PositiveIntegerField(default=0),
        ),
    ]