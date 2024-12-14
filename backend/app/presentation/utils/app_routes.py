


from app.presentation.utils.http_response import MyJson


def list_routes(app):

    routes = []
    for rule in app.url_map.iter_rules():
        routes.append({
            'endpoint': rule.endpoint,
            'methods': list(rule.methods),
            'route': str(rule)
        })
    return MyJson(error = "No Error", status_code=200, message="search sucessfull.", data=routes)