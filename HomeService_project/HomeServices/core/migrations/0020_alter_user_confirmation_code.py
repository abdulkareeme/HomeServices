# Generated by Django 4.2.1 on 2023-05-28 16:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0019_rename_confirmation_code_sent_at_user_next_confirmation_code_sent'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='confirmation_code',
            field=models.CharField(blank=True, max_length=6, null=True),
        ),
    ]
