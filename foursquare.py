import json
import requests
url = 'https://api.foursquare.com/v2/venues/explore'

params = dict(
    client_id='KIEVTZFZWVPG4MGE21GF3WM5WA4NNZMAWJXICDHVPGMQDQ22',
    client_secret='SPP1CGKI25XGRPQOQRW2SBKAGBUAQSQH0WJBBSAF1HDXMFJJ',
    v='20180323',
    ll='40.7243,-74.0018',
    query='coffee',
    limit=1
)
resp = requests.get(url=url, params=params)
data = json.loads(resp.text)
print(data)
