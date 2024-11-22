from datetime import datetime
# variables.py
try:
    from config import IMAP_ACCOUNT, IMAP_PASSWORD
except ImportError:
    raise ImportError("Please copy 'config_template.py' to 'config.py' and add your credentials.")

# Vérification que l'adresse e-mail est une addresse gmail
if not IMAP_ACCOUNT.endswith("@gmail.com"):
    print(f"Attention : l'adresse e-mail configurée ({IMAP_ACCOUNT}) n'est pas une adresse Gmail. Cela peut occasionner des dysfonctionnements pour ce POC. Adaptez les scripts en conséquence si nécessaire.")

# Variables statiques
BROWSER = "firefox"
URL = "https://demo.poletique.fr"
LOGIN_URL = f"{URL}/users/signup"
TITLE = "Polétique Démo"

# Variables d'IMAP
IMAP_ACCOUNT = IMAP_ACCOUNT
IMAP_PASSWORD = IMAP_PASSWORD
IMAP = "imap.gmail.com"
SENDER = "no-reply@poletique.fr"


# Variables fixes : User et Admin
USER_NAME = 'Utilisateur'
USER_EMAIL = 'utilisateur@poletique.fr'
ADMIN_NAME = 'Administrateur'
ADMIN_EMAIL = 'administrateur@poletique.fr'
USER_PASSWORD = 'Poletique123'
ADMIN_PASSWORD = 'Poletique123'
PASSWORD = 'Test-QA-123'


# Génération dynamique de l'email utilisateur
now = datetime.now()
IMAP_LOCAL_PART, IMAP_DOMAIN = IMAP_ACCOUNT.split('@')
RANDOM_EMAIL = f"{IMAP_LOCAL_PART}+{now.strftime('%d%H%M%S')}@{IMAP_DOMAIN}" # On split pour utiliser les emails dynamiques de gmail avec le "+"
RANDOM_USERNAME = f"QA_User_{now.strftime('%d%H%M%S')}"
