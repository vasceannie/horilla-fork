FROM python:3.10-slim-bullseye

ENV PYTHONUNBUFFERED 1

RUN apt-get update && apt-get install -y libcairo2-dev gcc

WORKDIR /app/

COPY . .

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN sed -i 's/\r$//g' /entrypoint.sh

RUN pip install -r requirements.txt

EXPOSE 8000

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
