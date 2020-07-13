from http.server import HTTPServer, SimpleHTTPRequestHandler

# Web-server
with HTTPServer(('', 8080), SimpleHTTPRequestHandler) as httpd:
    httpd.serve_forever()
