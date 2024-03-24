*-----------------------------------------------------------
* Title      :  TP2 EXO 2
* Written by :  ERRARD - DACCACHE
* Date       : 13/03/24
* Description: EXO 2
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
CR EQU $0D              *retour chariot (carriage return)
LF EQU $0A              *Saut de ligne (Line Feed)
* Put program code here
        LEA MESSAGE0, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *Affiche le message  
*-------------------------------------------------------        
        LEA MESSAGE1, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *affichage de MESSAGE1
        MOVE.B #2,D0        *on met 2 dans D0
        TRAP #15            *on demande a l'utilisateur d'entrer une donner sur le clavier
        MOVE.L A1,D2        *on met la donne sauvegarder dans A1 dans le registre de donne D2
        LEA MESSAGE2, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *on affiche MESSAGE2
        MOVE.B #2,D0        *on met 2 dans D0
        TRAP #15            *on demande a l'utilisateur d'entrer une donner sur le clavier
        MOVE.L A1,D3        *on met la donne sauvegarder dans A1 dans le registre de donne D3
        LEA MESSAGE3, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *on affiche MESSAGE3
        MOVE.B #4,D0        *on met 4 dans D0
        TRAP #15            *on demande a l'utilisateur d'entrer un nombre sur le clavier
        MOVE.L D1,D4        *on met la donne sauvegarder dans D1 dans le registre de donne D4
        LEA MESSAGE4, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *on affiche MESSAGE4
        MOVE.L D2,A1        *on met la donné qui est dans D2 dans A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *on afficher ce qui dans A1 (le Nom)
        LEA MESSAGE7, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *on affiche MESSAGE7
        MOVE.L D3,A1        *on met la donné qui est dans D3 dans A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *on afficher le contenu de A1 (le Prenom)
        LEA MESSAGE5, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *on affiche MESSAGE5
        MOVE.L #2024,D5     *on met 2024 dans D5
        SUB.L D4,D5         *on soustrait D5 (2024) par D4 (la date de naissance donner par l'utilisateur)
        MOVE.L D5,D1        *on met le contenu de D5 dans D1
        MOVE.B #3,D0        *Mettre 14 dans le registre D0
        TRAP #15            *on afficher le contenu de D1 (le resultat de la soustraction qui est l'age)
        LEA MESSAGE6, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *on affiche MESSAGE6
    SIMHALT             ; halt simulator

* Put variables and constants here
MESSAGE0  DC.B '----- TP 2 EXO 2 -----',0,CR,LF
MESSAGE1 DC.B  CR,LF,'Entrer votre nom: ',0
MESSAGE2 DC.B  CR,LF,'Entrer votre prenom: ',0
MESSAGE3 DC.B  CR,LF,'Entrer votre annee de naissance: ',0
MESSAGE4 DC.B  CR,LF,'Bonjour ',0
MESSAGE5 DC.B  '. Vous avez: ',0
MESSAGE6 DC.B  ' ans!',0
MESSAGE7  DC.B ' ',0

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
