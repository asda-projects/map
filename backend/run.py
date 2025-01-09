
import os
import sys


sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), 'app')))



from app import create_app

app = create_app()
if __name__ == '__main__':
    
    app.run(host='192.168.2.42', port=5000)
