import firebase_admin
from firebase_admin import credentials, db

# Define a variable to store the app instance
firebase_app = None

def initialize_firebase():
    global firebase_app
    
    if firebase_app is None:
        # Replace 'path/to/your/serviceAccountKey.json' with the path to your Firebase service account key JSON file.
        cred = credentials.Certificate('key.json')
        
        # Replace 'your-firebase-project-id' with your Firebase project ID.
        firebase_app = firebase_admin.initialize_app(cred, {'databaseURL': 'https://security-audit-a5a5d-default-rtdb.asia-southeast1.firebasedatabase.app/'})
        
    # Access the Realtime Database
    db_instance = db.reference()

    return db_instance
