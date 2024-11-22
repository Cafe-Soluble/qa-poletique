import time
import re
from imap_tools import MailBox, AND, A
from robot.api import logger


class EmailLibrary:
    def wait_for_email(self, imap, account, password, sender, recipient, timeout=300, delete_email=False):
        """
        Attend la réception d'un email d'un expéditeur spécifique dans un délai donné.
        
        Arguments:
        - sender: L'expéditeur du mail
        - recipient: Le destinataire du mail
        - timeout: Le délai maximal d'attente en secondes (défaut à 300 secondes)
        - delete: Supprime le mail lu et reçu (défaut False)
        
        Retourne:
        - Le lien trouvé dans le mail, ou False si aucun mail correspondant n'est reçu.
        """
        start_time = time.time()
        with MailBox(imap).login(account, password) as mailbox:    
            # Rechercher un email provenant de l'expéditeur spécifié, non lu, et adressé au destinataire
            messages = mailbox.fetch(criteria=AND(from_=sender, to=recipient, seen=False))
            
            for msg in messages:
                # Stocker la date de réception du mail
                reception_date = msg.date
                
                # Récupérer le contenu HTML et rechercher le lien
                html_content = msg.html or msg.text
                link_match = re.search(r'(https?://[^\s"\'<>]+)', html_content)
                
                if link_match:
                    link = link_match.group(0)
                    print(f"Lien trouvé: {link}")
                    
                    if delete_email:
                        # Supprimer le mail
                        mailbox.delete(msg.uid)
                    
                    # Retourner le lien
                    return link
                
            # Si pas de mail correspondant :
            start_time = time.time() # On prend l'heure de départ
            count_mail = 0 # Stocker le nombre de mail reçu mais non pertinent pendant l'attente
            while time.time() - start_time < timeout: # Tant qu'on a pas atteint l'attente demandé : timeout (ex: 300 secondes) dans l'éventualité où on reçoit un autre mail qui n'a aucun rapport
                responses = mailbox.idle.wait(timeout=timeout - int((time.time() - start_time))) # On enlève le temps déjà passé à attendre pour éviter de re attendre 300 secondes
                if responses:
                    for msg in mailbox.fetch(criteria=AND(from_=sender, to=recipient, seen=False)):
                        print(msg.date, msg.subject)
                        # Récupérer le contenu HTML et rechercher le lien
                        html_content = msg.html or msg.text
                        link_match = re.search(r'(https?://[^\s"\'<>]+)', html_content)
                        
                        if link_match:
                            link = link_match.group(0)
                            print(f"Lien trouvé: {link}")
                            
                            if delete_email:
                                # Supprimer le mail
                                mailbox.delete(msg.uid)
                            
                            # Retourner le lien
                            return link
                    else:
                        print("Mail reçu ne correspond par aux critères.")
                        count_mail += 1
                else:
                    print(f'No updates in {timeout} sec')
                
            
            
            if count_mail == 0: # Si aucun email n'est trouvé dans le délai imparti
                raise Exception(f"Aucun email n'a été reçu dans le délai imparti ({timeout} secondes).")
            elif count_mail > 0:
                raise Exception(f"Mail(s) reçu(s) : {count_mail} ne correspondant pas aux critères. (Timeout: {timeout} secondes).")
            else:
                raise Exception(f"Une erreur s'est produite pendant l'IDLE ({timeout} secondes).")
                
    