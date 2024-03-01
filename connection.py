import firebase_admin
from firebase_admin import credentials, db

def initialize_firebase():
    # Replace 'path/to/your/serviceAccountKey.json' with the path to your Firebase service account key JSON file.
    cred = credentials.Certificate('key.json')
    
    # Replace 'your-firebase-project-id' with your Firebase project ID.
    firebase_admin.initialize_app(cred, {'databaseURL': 'https://security-audit-a5a5d-default-rtdb.asia-southeast1.firebasedatabase.app/'})
    
    # Access the Realtime Database
    db_instance = db.reference()

    return db_instance
