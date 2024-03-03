import firebase_admin
from firebase_admin import credentials, db

# Define a variable to store the app instance
firebase_app = None

def initialize_firebase():
    global firebase_app
    
    if firebase_app is None:
        # Replace 'path/to/your/serviceAccountKey.json' with the path to your Firebase service account key JSON file.
        cred = credentials.Certificate({
        "type": "service_account",
        "project_id": "security-audit-a5a5d",
        "private_key_id": "82afc470bc0b43353b06cff896cd906c58861c40",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDJ7LOQ7YAAn3cW\nYFmWBBw3jMGH3+OYRLMqFTbLmnJaz7sdvdwJbnCS35dHSOX12AcY+sx8kL/WAFvv\nyStot4lPkSqEeuU0yjaZvZc7Xc9lkGBmor/nMLvEaBVqGG6iREG9bPwvS951ygcW\nBoQVlHt2MOd4VA4PNmxrVlSS3ZtpZbdXEe3nLpPuKU+X4hXPYTxjcfTDnvaCFT+v\nbSYThwEbl26PgSUyNn749GBks/5piqYaZP+s8w30v9d1jyi+7vNZ5sxctQjK7K6l\nWeQnRoibSR/EaXliQuYIKaqX/OTxGPHYCqcnch2W6AA2QqjEc6JGEZ6opTsXcibW\nFxG6IQWpAgMBAAECggEADsTm32dXsPP4+GSEuPHFBJUhhKguE/GWbzINB3hc++Js\ny8Cayv/OcRe0j2y4ETLDViLl+Qh3V5ZAIzpCGA8wlmbGRtlcUW+m7bjNynRSmpmk\nS22E/sp0OWnpgxCVav32Fv5VNbplY5UqzoQcfh2VqC/shkMToi43YOR4HCPkXaGH\nABEntoOsDAL8D9hk3XJHnbpd8TZvYODXgoW3NOXzn0bhmc08WXGv8NsSkNdFJWy3\n6fY612nw8jrRu7jdIGrBCJMcBIRpaZWle0zXASkWTFv+tX41PbEsTeGT36C3M1MA\n1eill0UpuZi0LQTrzwJ5LXzYpfLNXwyHr/AEvjWaeQKBgQD+Bpr5M1zZLaw7Fh7c\nHVGoPoc94c6BpWAAE8aR2tS7BDtpZFUwev/6IcPV8Vy+TvgUjtTgDPaWjXzgpR5g\nZ6C1WWo1pH+dJTD4JTwqEHQFNoC7TfoVm2nIqr7khQfgTwEQXE1lmWtb+2kTkJhO\naRzYD+0SPg1Q5pXDLnFIBSk15QKBgQDLfnBKutkmTRPJdE6F1XYIunQeN8Ai3iNg\nfIelF3FihH5krMTtqBIMisPx0mKL4ELDLRSpANlVPcclJDO/fMassbt+5NU2xqea\nJRiA6xraeXY5ZEFC8AdIujc5QlK6PKpB1PRRO9kl6oNlW9OyuFtK69PYZZpGN30M\nLZrNrGeUdQKBgGPPCJkdez/B2Egm+t0Vj/4BA3ZnAJKj/cJKAt1QFAGfOhDA4U/5\nJBaNqbqn6P7FXGgHbtDRhxnEYeqKNhM+5EAc78Q/6/w8nq8BQlBswolBzvbJPpe6\nxqeXnwV+14dkw1BAVBC1ZR9w+uo7B/zXBARIzac7RlQhJXrZBp17maOZAoGBAL5C\nooUMfBl2eWiiyQQS2ABDLGxQXeF75oHBDSZLa+Tb0j0Y2CsIOI/nclr4BNGZRXKt\nBKMbOxia4UaVuZhw9mTi7FYxaDSFupDB3E41A29/nwz78pS+TWEvUpDDtQuRyvIw\nRJprJZVw1ZeAKsfv3NOI+RJbtMmv+cfYH+PrLRE9AoGBANQNj2l0pY4g0eKtU4lb\nknTxvQ5JbjdkDJPjR+wtijiMLcUdoXnOt9PhDQxCylOMefKXh7iwb+cDLnB29XX1\n4VX7yWxcdk7eeAEthE6w/T4QT4xxOfbMT2suArqIruWXqrBZ1LL1ewLAIHZy8PLQ\ngqamhj/lJqYy9i1JGEgeABb5\n-----END PRIVATE KEY-----\n",
        "client_email": "firebase-adminsdk-clcok@security-audit-a5a5d.iam.gserviceaccount.com",
        "client_id": "104590268664105803741",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-clcok%40security-audit-a5a5d.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
    })
        
        # Replace 'your-firebase-project-id' with your Firebase project ID.
        firebase_app = firebase_admin.initialize_app(cred, {'databaseURL': 'https://security-audit-a5a5d-default-rtdb.asia-southeast1.firebasedatabase.app/'})
        
    # Access the Realtime Database
    db_instance = db.reference()

    return db_instance
