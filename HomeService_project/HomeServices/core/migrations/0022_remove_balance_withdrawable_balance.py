# Generated by Django 4.2.1 on 2023-06-10 11:49

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0021_remove_balance_pending_balance'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='balance',
            name='withdrawable_balance',
        ),
    ]
