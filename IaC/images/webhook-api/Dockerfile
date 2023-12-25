FROM python:alpine3.18

ENV PYTHONPATH=/webhooks

COPY src /webhooks

WORKDIR /webhooks

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r ./requirements.txt

# ENTRYPOINT ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
ENTRYPOINT [ "sleep", "infinity" ]