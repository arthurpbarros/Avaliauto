FROM python:latest

# The enviroment variable ensures that the python output is set straight
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1
RUN mkdir -p /avaliauto
# Get the Real World example app
COPY /API_Avaliauto /avaliauto

# Set the working directory to /drf
# NOTE: all the directives that follow in the Dockerfile will be executed in
# that directory.
WORKDIR /avaliauto

run ls .
# Install any needed packages specified in requirements.txt
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

VOLUME /avaliauto

EXPOSE 4000

CMD python manage.py makemigrations && python manage.py migrate && python manage.py runserver 0.0.0.0:4000
# CMD ["%%CMD%%"]
