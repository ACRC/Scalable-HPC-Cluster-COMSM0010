import requests
r = requests.get("http://130.61.35.82:8081/api/iamhere/")

print(r.text)
