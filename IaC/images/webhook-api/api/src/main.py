from fastapi import FastAPI, Request, HTTPException, Header
from typing import Optional
import hmac
import hashlib
from json import dump, loads, decoder
import uvicorn
from os import getenv
app = FastAPI()

WEBHOOK_SECRET = getenv('WEBHOOK_SECRET')

def verify_signature(body, signature):
    # GitHub provides the signature in the form of 'sha256=xxxx'
    expected_signature = hmac.new(
        WEBHOOK_SECRET.encode(), body, hashlib.sha256
    ).hexdigest()

    # Compare the signatures in a secure way to prevent timing attacks
    if not hmac.compare_digest(f'sha256={expected_signature}', signature):
        raise HTTPException(status_code=400, detail='Invalid signature')


@app.post("/webhook")
async def github_webhook(request: Request, x_hub_signature_256: Optional[str] = Header(None)):
    # Read the raw body of the HTTP request
    content = await request.json()
    body = await request.body()

    if x_hub_signature_256:
        verify_signature(body, x_hub_signature_256)
    else:
        raise HTTPException(status_code=400, detail='Missing X-Hub-Signature-256 header')
    with open('/data/webhook.json', 'a+') as f:
        try:
            data = loads(f.read())
            print()
        except decoder.JSONDecodeError as e:
            data = []
            data.append(content)
            dump(data, f)
            raise e
    # Optional: Convert the body to a string if you want to see it in the logs
    # body_str = body.decode('utf-8')
    print("Webhook event received")

    # Always return a response to GitHub
    return {"message": "Webhook received"}

if __name__ == "__main__":
    uvicorn.run('main:app', host="0.0.0.0", port=8000, reload=True)