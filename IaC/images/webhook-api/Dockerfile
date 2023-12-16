FROM python:alpine3.18

COPY src /my_py

WORKDIR /my_py

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt


CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]