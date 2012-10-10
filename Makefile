clean:
	@find . -name "*.pyc" -delete

deps:
	@pip install -r requirements.txt

test: deps clean
	@python manage.py test

setup: deps
	@python manage.py syncdb
	@python manage.py migrate
	@python manage.py loaddata core/fixtures/site_fixture.json

run:
	@python manage.py runserver 0.0.0.0:8000

heroku:
	@git push heroku master
	@heroku run python manage.py syncdb --noinput
	@heroku run python manage.py migrate
	@heroku run python manage.py collectstatic

help:
	grep '^[^#[:space:]].*:' Makefile | awk -F ":" '{print $$1}'
