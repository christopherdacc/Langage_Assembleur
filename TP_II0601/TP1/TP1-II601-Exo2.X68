*-----------------------------------------------------------
* Title      : Exercice 2
* Written by : DACCACHE - ERRARD
* Date       : 06/03/24
* Description: TP1
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here

CR EQU $0D              *retour chariot (carriage return)
LF EQU $0A              *Saut de ligne (Line Feed)

LOOP    LEA MESSAGE1, A1     *chargement de message1 dans l'adresse de registre A1
        MOVE.B #14,D0        *mettre 14 dans le registre D0
        TRAP #15             *affiche du message1     
        LEA MESSAGE2, A1     *chargement de message2 dans l'adresse de registre A1
        TRAP #15             *affichage du messsage2
        
*--------------------premier entier------------------------        
        MOVE.B #4,D0          *valeur du premier entier
        TRAP #15              *affichage
        MOVE.B D1,D5          *déplacement de D1 dans D5
        LEA MESSAGE3, A1      *chargement de message3 dans l'adresse de registre A1
        MOVE.B #14,D0         *mettre 14 dans D0
        TRAP #15              *affichage du message3
        
*--------------------deuxième entier------------------------                   
        MOVE.B #4,D0           *valeur du deuxième entier
        TRAP #15               *affichage
        MOVE.B D1,D6           *déplacement de D1 dans D6
        ADD.B D5,D1            *somme de D5 et D1
        LEA MESSAGE4, A1       *chargement de message4 dans l'adresse de registre A1
        MOVE.B #14,D0          *Mettre 14 dans le registre D0
        TRAP #15               *affichage du message4
        MOVE.B D1,D7           *déplacement de D1 dans D7
        MOVE.B D5,D1           *déplacement du premier entier dans D1
        MOVE.B #3,D0           **déplacement de 3 dans D0
        TRAP #15               *affichage 
        LEA plus, A1           *chargement du charactere '=' dans l'adresse de registre A1
        MOVE.B #14, D0         *mettre 14 dans D0
        TRAP #15               *affichage du carcatère +
        MOVE.B D6,D1           *déplacement du deuxième entier dans D1
        MOVE.B #3, D0          *déplacement de 3 dans D0
        TRAP #15               *affichage du deuxième entier
        LEA egal, A1           *chargement du charactere '=' dans l'adresse de registre A1
        MOVE.B #14,D0          *mettre 14 dans  D0
        TRAP #15               *affichage du signe =
        MOVE.B D7, D1          *on met la valeur du resultat qui est dans D7 dans D1 pour l'afficher avec trap #15
        MOVE.B #3, D0          *déplacement de 3 dans D0
        TRAP #15               *affichage du résultat
        

    SIMHALT             ; halt simulator

* Put variables and constants here
MESSAGE1  DC.B '----- TP1 EXO2 ------',CR,LF,0
MESSAGE2  DC.B 'Donner le premier entier : ',0
MESSAGE3  DC.B 'Donner le deuxième entier : ',0,CR,LF
MESSAGE4  DC.B 'La somme de ',0
plus DC.B ' + ',0
egal DC.B ' = ',0

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
