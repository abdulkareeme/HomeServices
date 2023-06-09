# Generated by Django 4.2.1 on 2023-06-10 13:32

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0021_rename_type_inputfield_field_type'),
    ]

    operations = [
        migrations.AddField(
            model_name='inputfield',
            name='note',
            field=models.CharField(default='', max_length=100),
        ),
        migrations.AlterField(
            model_name='inputfield',
            name='field_type',
            field=models.CharField(choices=[('TEXT', 'TEXT'), ('NUMBER', 'NUMBER')], default='TEXT', max_length=50),
        ),
        migrations.AlterField(
            model_name='inputfield',
            name='title',
            field=models.CharField(max_length=100),
        ),
    ]
