*-----------------------------------------------------------
* Title : EXERCICE3
* Written by : EL ALAMI et VILELA
* Date : 27/02/2023
* Description: TP1
*-----------------------------------------------------------
START: ORG 1000 ; first instruction of program
* Put program code here

BOUCLE  LEA message1, A1    *Chargement du message1 dans A1
        move.b #14,D0       *on met 14 dans D0 pour afficher une chaine de caractere
        TRAP #15            *Afficher le message1
        LEA message2,A1     *Chargement du message2 dans A1
        TRAP #15            *Afficher le messaege2
        move.b #4,D0        *on met 4 dans D0 pour lire une entree du clavier apres la touche enter
        TRAP #15            *Lecture d'un entier
        CMP.L #3,D1         *Comparaison de l'entier avec 3
        BGT SUP             *Si supérieur a 3, aller à l'étiquette SUP
        CMP.L #1,D1         *Comparaison de l'entier avec 1
        BLT INF             *Si inférieur a 1, aller à l'étiquette INF
        CMP.L #1,D1         *Comparaison de l'entier avec 1
        BEQ UN              *Si égal à 1, aller à l'étiquette UN
        CMP.L #2,D1         *Comparaison de l'entier avec 2
        BEQ DEUX            *Si égal à 2, aller à l'étiquette DEUX
        CMP.L #3,D1         *Comparaison de l'entier avec 3
        BEQ TROIS           *Si égal à 3, aller à l'étiquette TROIS
        BRA BOUCLE          *et finalement aller a l'etiquette boucle pour reprendre le programme
SUP     LEA superieur,A1    *Charger le message "k trop grand" dans A1
        move.b #14,D0       *on met 14 dans D0 pour afficher une chaine de caractere
        TRAP #15            *Afficher le message "k trop grand"
        BRA BOUCLE          *retour a l'etiquette BOUCLE
INF     LEA inferieur,A1    *Charger le message "k trop petit" dans A1
        move.b #14,D0       *on met 14 dans D0 pour afficher une chaine de caractere
        TRAP #15            *Afficher le message "k trop petit"
        BRA BOUCLE          *retour a l'etiquette boucle
UN      LEA nombre_un,A1    *Chargement de la chaince de caractere nombre_un dans A11
        move.b #14,D0       *on met 14 dans D0 pour afficher une chaine de caractere
        TRAP #15            *Afficher le message "un"
        BRA BOUCLE          *retour a l'etiquette boucle
DEUX    LEA nombre_deux,A1  *Chargement de la chaince de caractere nombre_deux dans A1
        move.b #14,D0       *on met 14 dans D0 pour afficher une chaine de caractere
        TRAP #15            *Afficher le message "deux"
        BRA BOUCLE          *retour a l'etiquette BOUCLE
TROIS   LEA nombre_trois,A1 *Chargement de la chaince de caractere nombre_trois dans A1
        move.b #14,D0       *on met 14 dans D0 pour afficher une chaine de caractere
        TRAP #15            *Afficher le message "trois"
        BRA BOUCLE          *retour a l'etiquette BOUCLE
        
        SIMHALT             ; halt simulator
        
* Put variables and constants here
CR EQU $0D
LF EQU $0A
message1 dc.b CR,LF,'--------- TP1 Exo3 ---------',CR,LF,0
message2 dc.b 'Entrer la valeur de k entre un et trois: ',0
superieur dc.b CR,LF,'k trop grand',0
inferieur dc.b CR,LF,'k trop petit',0
nombre_un dc.b CR,LF,' un ',0
nombre_deux dc.b CR,LF,'deux',0
nombre_trois dc.b CR,LF,'trois',0


    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
