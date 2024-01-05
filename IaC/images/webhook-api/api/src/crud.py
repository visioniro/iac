from json import loads, dump, decoder
from io import UnsupportedOperation
def save_webhook(content: dict) -> None:
    with open('/data/webhook.json', 'w') as f:
        # f.seek(0)
        try:
            data: list[dict] = loads(f.read())
            data.append(content)
            f.truncate()
            dump(data, f)
        except (decoder.JSONDecodeError, UnsupportedOperation):
            data = []
            data.append(content)
            dump(data, f)
