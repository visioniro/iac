FROM python:alpine3.18

COPY src /my_py

WORKDIR /my_py

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

ENV GITHUB_WEBHOOK_SECRET=blah-blah

ENTRYPOINT [ "sleep", "infinity"  ]
# CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]