FROM python:3.10-slim-buster

RUN apt-get update && apt-get install -y python3-dev libpq-dev build-essential

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirments.txt

EXPOSE 8000

ENV DJANGO_SETTINGS_MODULE=HomeServices.settings

CMD ["sh", "-c", "python manage.py runserver 0.0.0.0:8000 & python manage.py qcluster"]