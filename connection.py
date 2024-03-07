import firebase_admin
from firebase_admin import credentials, db

# Define a variable to store the app instance
firebase_app = None

def initialize_firebase():
    global firebase_app
    
    if firebase_app is None:
        # Replace 'path/to/your/serviceAccountKey.json' with the path to your Firebase service account key JSON file.
        cred = credentials.Certificate({
        "FIREBASE_SERVICEACCOUTKEY.JSON_FILECONTENT"
    })
        
        # Replace 'your-firebase-project-id' with your Firebase project ID.
        firebase_app = firebase_admin.initialize_app(cred, {'databaseURL': 'YOUR_DATABSE_URL'})
        
    # Access the Realtime Database
    db_instance = db.reference()

    return db_instance
