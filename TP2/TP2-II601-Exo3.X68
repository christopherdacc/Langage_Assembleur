*-----------------------------------------------------------
* Title      :  EXO 3 TP 2
* Written by :  ERRARD - DACCACHE
* Date       :  13/03/24
* Description:  EXO 3
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
CR EQU $0D                  *retour chariot (carriage return)
LF EQU $0A                  *Saut de ligne (Line Feed)
* Put program code here
        LEA MESSAGE0, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *Affiche le message  
*-------------------------------------------    
        LEA MESSAGE1, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *Affiche MESSAGE1  
        MOVE.B #4,D0        *Mettre 4 dans le registre D0
        TRAP #15            *demande a l'utilisateur d'insere un nombre  
        DIVS #2,D1          *on divise le nombre contenu dans D1 par 2
        SWAP D1             *on echange les bites 1 a 4 avec les bites de 5 a 8 
        CMP #0,D1           *on compare 0 avec les bits du reste de la division effectue
        BEQ PAIRE           *si le reste est egale a 0 on passe au code de l'etiquette paire (donc le nombre est paire)
        BNE IMPAIRE         *si le reste n'est pas egale a 0 on passe au code de l'etiquette impaire (donc le nombre est impaire)
PAIRE   LEA MESSAGE2, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *Affiche MESSAGE2  
        MOVE.B #9,D0        *Mettre 14 dans le registre D0
        TRAP #15            *arret du programme
IMPAIRE LEA MESSAGE3, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *Affiche le message
        MOVE.B #9,D0        *Mettre 14 dans le registre D0
        TRAP #15            *arret du programme

    SIMHALT             ; halt simulator

* Put variables and constants here
MESSAGE0  DC.B '----- TP 2 EXO 3 -----',0,CR,LF
MESSAGE1  DC.B CR,LF,'Saisir un nombre: ',0
MESSAGE2  DC.B 'Le nombre est pair!',0
MESSAGE3  DC.B 'Le nombre est impaire!',0


    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
