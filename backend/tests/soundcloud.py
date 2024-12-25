from flask import json
import requests as req

my_client_id = "AsIBxSC4kw4QXdGp0vufY0YztIlkRMUc"
redirect_url = "https://api.soundcloud.com/tracks?jesus"
identifier = "q=projectsofasda@gmail.com"


def auth_old():
    params = {
        "client_id": my_client_id,
        "response_type": "code",
        "scope": "",
        "state": "undefined",
        "redirect_uri": redirect_url
    }

    url = "https://api.soundcloud.com/connect"
    resp = req.get(url, params=params)

    print(f"\n{resp.url}\n\nStatus: {resp.status_code}\n\n{resp.text}")


def auth_new():
    params = {
        "client_id": my_client_id,
        # "redirect_uri": redirect_url,
        "response_type": "code",
        "state": "undefined"
    }

    url = "https://secure.soundcloud.com/authorize"
    resp = req.get(url, params=params)

    print(f"\n{resp.url}\n\nStatus: {resp.status_code}\n\n{resp.text}")

def auth_catched():

    params ={
        "identifier": identifier,
        "client_id": my_client_id,
    }

    url = "https://api-auth.soundcloud.com/web-auth/"

    resp = req.get(url, params=params)

    print(f"\n{resp.url}\n\nStatus: {resp.status_code}\n\n{resp.text}")


def auth_api_v2():

    params ={
        "client_id": my_client_id,
        "stage": "undefined",
    }

    url = "https://api-v2.soundcloud.com/me"

    resp = req.get(url, params=params)

    print(f"\n{resp.url}\n\nStatus: {resp.status_code}\n\n{resp.text}")

def auth_tracks():

    params ={
        "client_id": my_client_id,

    }

    url = "https://api.soundcloud.com/search/tracks"

    resp = req.get(url, params=params)

    print(f"\n{resp.url}\n\nStatus: {resp.status_code}\n\n{resp.text}")

def auth_sign_in():

    url = f"https://api-auth.soundcloud.com/sign-in?client_id={my_client_id}"

    data = {
        "credentials":
        {
            "kind":"password",
        "body":{
            "identifier":"projectsofasda@gmail.com","password":"@1V3g7b20_soundcloud"}},
        "vk": {
        "cp":"6Lf_t_wUAAAAACyAReaZlQzxI0fxbxhNCwrngjp6","cr": None,
        "sg":"8:17-1-21624-236-1296000-1283-6-5:5a824f:2",
        "dd":"","ag":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Safari/605.1.15",
        "cd":"AsIBxSC4kw4QXdGp0vufY0YztIlkRMUc",
        "kd":"password"
        }
    }

    
    resp = req.post(url, json=json.dumps(data))

    print(f"\n{resp.url}\n\nStatus: {resp.status_code}\n\n{resp.text}")

def auth_me():

    url = f"https://api-v2.soundcloud.com/me?client_id={my_client_id}"

    data = {"batch":[{"timestamp":"2024-12-17T09:36:18.601Z","integrations":{"All":False,"Segment.io":True},"context":{"protocols":{"event_version":1},"page":{"path":"/authorize","referrer":"","search":f"?client_id={my_client_id}&response_type=code&state=undefined","title":"SoundCloud – Listen Hello Cloud","url":f"https://secure.soundcloud.com/authorize?client_id={my_client_id}&response_type=code&state=undefined"},"sc":{"browser_tab_id":"867812","client_application_id":306487,"anonymous_id":"221407-588377-18528-23428","user_id":None,"part_of_variants":None,"analytics_id":None,"session_id":"146B2942-1A23-4EFF-A725-D90A25AC8815"},"userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.6.1 Safari/605.1.15","locale":"en-CA","library":{"name":"analytics.js"},"campaign":{}},"properties":{"method":"email","client_id":306487,"signin_or_signup":"signin","error_type":"identifier:unknown_error:Password Dialog Viewed"},"event":"Authentication Error Displayed","messageId":"ajs-e6f724eae740a878c53fd90185808673","anonymousId":"b20a061b-18ab-4b48-9b4c-585ec6dccb33","type":"track","writeKey":"","userId":"soundcloud:users:1478671159","_metadata":{"bundled":["Segment.io"],"unbundled":[],"bundledIds":[]}}],"sentAt":"2024-12-17T09:36:18.622Z"}

    resp = req.post(url, json=json.dumps(data))

    print(f"\n{resp.url}\n\nStatus: {resp.status_code}\n\n{resp.text}")

def auth_tracks_v2():

    query = "jesus hillsong"
    limit=1

    
    url = "https://api-v2.soundcloud.com/search/tracks"
    params = {
        "client_id": my_client_id,
        "q": query,
        "limit": limit
    }


        # Make the API request
    resp = req.get(url, params=params)
    print(f"\n{resp.url}\n\nStatus: {resp.status_code}\n\n{resp.text}")

if __name__ == "__main__":
    auth_tracks_v2()