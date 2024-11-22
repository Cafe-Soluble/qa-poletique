# Projet de Démonstration d'Automatisation de Tests - demo.poletique.fr

Ce projet utilise **Robot Framework** pour automatiser les tests de fonctionnalités du site de démonstration [demo.poletique.fr](https://demo.poletique.fr). Ce dépôt contient une série de tests automatisés visant à valider le parcours utilisateur et certaines fonctionnalités critiques du site. Ces tests incluent la gestion des inscriptions, des connexions, et la vérification des données publiées par les utilisateurs.

## Objectifs et Fonctionnalités Testées

L'objectif est de fournir une base de tests pour démontrer des recettes fonctionnelles automatisées sur les parcours utilisateurs du site, incluant notamment :
- **Test de connexion** : Validation du Happy Path et des scénarios d’échec (KO) pour assurer une gestion robuste des accès.
- **Inscription d'un nouvel utilisateur** : Création d’un compte, suivi de la vérification d’email via IMAP pour valider le compte.
- **Suppression d’un utilisateur** : Suppression du compte créé pour éviter les doublons et garantir la propreté des données.
- **Vérification des publications** : Contrôle du nombre de posts affichés, en le comparant au nombre réel obtenu par scraping des pages du site et recherche de l’utilisateur spécifique.

Ces tests sont adaptés pour une intégration continue et une automatisation complète, permettant d’effectuer des vérifications régulières sur l’intégrité et la fonctionnalité des parcours critiques.

## Pré-requis

### 1. Environnement Python et installation de Robot Framework

Le projet utilise ***Python 3.12***. 
Installer Robot Framework ainsi que les autres dépendances nécessaires : 
```bash
pip install -r requirements.txt
```
Il est également nécessaire de disposer d'un Webdriver compatible avec votre navigateur (ex : [Gecko Webdriver](https://github.com/mozilla/geckodriver/releases) pour Firefox)
### 2. Fichier de configuration des identifiants IMAP

Pour exécuter les tests nécessitant la vérification des emails (`signup.robot` et `delete_user.robot`), un accès IMAP à un compte Gmail est requis. Les identifiants de connexion doivent être spécifiés dans le fichier `config.py`, que vous créerez à partir du modèle fourni `config_template.py`.
L'utilisation d'un compte Gmail n'est pas obligatoire mais recommandé pour la création d'email dynamique.

#### Étapes de configuration :

1. **Copiez** le fichier `Resources/config_template.py` en `Resources/config.py`.
2. **Modifiez** `config.py` en y ajoutant vos identifiants IMAP :

   ```python
   # Resources/config.py
   IMAP_ACCOUNT = "your_email@example.com"
   IMAP_PASSWORD = "your_password"
   ```

## Structure des Tests

Les tests sont structurés de manière modulaire pour simplifier leur maintenance et leur extension. Voici un aperçu des principaux fichiers et scripts :

- **Test de Connexion** (`login.robot`) : Vérifie les scénarios Happy Path et KO pour la connexion utilisateur.
- **Test d'Inscription et de Vérification d'Email** (`signup.robot`) : Crée un compte utilisateur et valide la réception de l'email en utilisant la librairie personnalisée `EmailLibrary.py`.
- **Suppression d'Utilisateur** (`delete_user.robot`) : Supprime le compte utilisateur pour garantir un environnement de test propre.
- **Vérification des Publications** (`check_posts.robot`) : Vérifie le nombre de publications utilisateur affichées en le comparant au nombre réel de publications en scrappant le site.

Les utilisateurs créés au cours des tests sont générés dynamiquement à partir de la date et l’heure d’exécution, évitant ainsi les conflits d’utilisateurs et permettant des tests répétés sans nécessiter de nettoyage manuel.

## Librairies personnalisées

Une librairie custom, **EmailLibrary.py**, a été développée pour gérer la récupération et la vérification d’emails en utilisant le protocole IMAP. Elle est stockée dans le dossier `Libraries` et est essentielle pour les tests d’inscription et de suppression d’utilisateur.

```python
*** Settings ***
Library         Libraries/EmailLibrary.py
```

## Instructions d'exécution

1. **Configurer** le fichier `config.py` avec les identifiants IMAP nécessaires.
2. **Exécuter** les tests en utilisant la commande Robot Framework :

   ```bash
   robot -d results Tests/
   ```

   Le paramètre `-d results` permet de stocker les logs et les rapports d'exécution dans le dossier `results`.

## Résultats et Reporting

Les résultats des tests sont enregistrés dans le répertoire `results`, incluant les fichiers de sortie suivants :
- `output.xml`: Rapport de l’exécution détaillée des tests.
- `log.html`: Rapport des logs d'exécution.
- `report.html`: Rapport général des tests.

Ces rapports fournissent un aperçu complet des scénarios testés et des éventuelles anomalies détectées.

---
