*-----------------------------------------------------------
* Title      : Exercice 1
* Written by : DACCACHE - ERRARD
* Date       : 06/03/24
* Description: T1
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

*-----------------code for output---------------------------

LOOP    LEA MESSAGE, A1     *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *Affiche le message     

*-----------------code for input----------------------------
        MOVE.B #4,D0       
        TRAP #15            *Lecture d'un nombre du clavier vers D1.L
        CMP.L #20,D1        *Comparer la valeur entréée à 20
        BGT LOOP            *Si supérieur, on retourne à l'entrée
        CMP.L #1,D1         *Comparer la valeur entrée à 1
        BLT LOOP            *Si inférieur, on retourne à l'entrée
        LEA MESSAGE2, A1    *Affiche message2 si valeur entre 1 et 20 
        MOVE.B #14,D0       *il faut avoir 14 dans D0 pour afficher la chaine de charactere contenu dans A1
        TRAP #15            *execution de l'affichage du message
        
DONE    MOVE.B #9,D0        *il faut avoir 0 dans D0 pour arreter le programme 
        TRAP #15            *execution de l'arret du programme
                  

CR EQU $0D              *retour chariot (carriage return)
LF EQU $0A              *Saut de ligne (Line Feed)

MESSAGE  DC.B 'Entrer une valeur :',0
MESSAGE2 DC.B 'valeur comprise entre 1 et 20',0

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
