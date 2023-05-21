# Generated by Django 4.2.1 on 2023-05-21 10:36

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('services', '0007_rename_servicesprice_generalservicesprice'),
    ]

    operations = [
        migrations.CreateModel(
            name='Beneficiary',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('beneficiary_name', models.CharField(max_length=100)),
            ],
        ),
        migrations.RemoveField(
            model_name='generalservicesprice',
            name='beneficiary_name',
        ),
        migrations.AlterField(
            model_name='pendingbalance',
            name='order',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='pending_balance_order', to='services.orderservice'),
        ),
        migrations.CreateModel(
            name='Earnings',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('earnings', models.IntegerField()),
                ('beneficiary', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='services.beneficiary')),
                ('order', models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='earnings_order', to='services.orderservice')),
            ],
        ),
        migrations.AddField(
            model_name='generalservicesprice',
            name='beneficiary',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, to='services.beneficiary'),
        ),
        migrations.AddField(
            model_name='pendingbalance',
            name='beneficiary',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='pending_balance_beneficiary', to='services.beneficiary'),
        ),
    ]
