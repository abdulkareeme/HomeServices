from hypothesis.extra.django import TestCase
import pytest
from hypothesis import strategies , given
from mixer.backend.django import mixer
from core.models import User,NormalUser , Balance

pytest_mark = pytest.mark.django_db

class TestUserModel(TestCase):
    def setUp(self) -> None:

        return super().setUp()

    @given(strategies.characters(blacklist_characters="/?#", blacklist_categories=("Cs",)))
    def test_create_user(self , username):
        user = mixer.blend(User , username= username)
        response = User.objects.last()
        assert response.username == user.username
    
    def test_photo(self):
        mixer.blend(User , gender = 'Male')
        response_male = User.objects.last()

        mixer.blend(User, gender = 'Female')
        response_female = User.objects.last()

        assert response_male.photo.url == '/media/profile/Male.jpg'
        assert response_female.photo.url == '/media/profile/Female.jpg'