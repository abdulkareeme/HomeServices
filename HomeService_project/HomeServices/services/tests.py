from django.test import TestCase
from .models import Category
import pytest

pytest_mark = pytest.mark.django_db
# Create your tests here.
class TestCategoryModel(TestCase):
    def test_create_category(self):
        category = Category.objects.create(name= 'bla' )
        query = Category.objects.last()
        assert category == query