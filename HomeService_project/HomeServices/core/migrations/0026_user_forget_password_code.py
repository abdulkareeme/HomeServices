# Generated by Django 4.2.1 on 2023-06-30 20:10

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0025_alter_user_area'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='forget_password_code',
            field=models.CharField(max_length=6, null=True),
        ),
    ]