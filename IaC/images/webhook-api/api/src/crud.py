from json import load, dump, decoder

def save_webhook(content: dict) -> None:
    with open('/data/webhook.json', 'a+') as f:
        f.seek(0)
        try:
            data: list[dict] = load(f)
            print(f'{len(data)} loaded')
            data.append(content)
            print(f'{len(data)} after')
            f.truncate(0)
            dump(data, f)
        except decoder.JSONDecodeError:
            data = []
            data.append(content)
            dump(data, f)
