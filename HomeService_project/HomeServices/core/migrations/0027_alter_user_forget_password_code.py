# Generated by Django 4.2.1 on 2023-06-30 20:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0026_user_forget_password_code'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='forget_password_code',
            field=models.CharField(blank=True, max_length=6, null=True),
        ),
    ]
