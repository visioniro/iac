from typing import Union
import uvicorn
from fastapi import FastAPI, Request
from json import dump

app = FastAPI()

@app.post("/webhook")
async def github_webhook(request: Request):
    # Read the raw body of the HTTP request
    body = await request.json()
    with open('webhook.json', 'a+') as f:
        dump(body, f, indent=4)
    # Optional: Convert the body to a string if you want to see it in the logs
    # body_str = body.decode('utf-8')
    print("Webhook event received")

    # Always return a response to GitHub
    return {"message": "Webhook received"}

if __name__ == "__main__":
    uvicorn.run('main:app', host="0.0.0.0", port=8000, reload=True)