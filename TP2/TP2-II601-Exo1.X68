*-----------------------------------------------------------
* Title      : TP 2 EXO 1
* Written by : ERRARD - DACCACHE
* Date       : 13/03/24
* Description: TP 2
*-----------------------------------------------------------
    ORG    $1000
START:                      ; first instruction of program
CR EQU $0D                  *retour chariot (carriage return)
LF EQU $0A                  *Saut de ligne (Line Feed)
* Put program code here
        LEA MESSAGE, A1     *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *Affichage de MESSAGE
        MOVE.B #1, D3       *One met 1 dans le registre de donne D3
*-----------------------------------------        
BOUCLE    LEA MESSAGE2, A1  *chargement de MESSAGE2 dans le registre d'adress A1
          MOVE.B #14,D0     *Mettre 14 dans le registre D0
          TRAP #15          *Affichage de MESSAGE2
          MOVE.B #3,D0      *on met 3 dans D0
          MOVE.B D3,D1      *on met le contenue de D3 dans D1
          TRAP #15          *on afficher le nombre contenu dans D1
          ADD #1,D3         *on ajoute 1 a la valeur contenu dans D3
          CMP.L #11,D3      *on compare 11 a D3
          BGT ENDER         *si D3 est plus grand que 11 le code passe au code contenue dans l'etiquette ENDER
          BLT BOUCLE        *si D3 est plus petit que 11 on recommance le code de l'etiquette BOUCLE

ENDER     MOVE.B #9,D0      *on met 9 dans D)
          TRAP #15          *on arrete le programme
    SIMHALT             ; halt simulator

* Put variables and constants here
MESSAGE  DC.B '----- TP2 EXO 1 -----',CR,LF,0
MESSAGE2 DC.B CR,LF,'Bonjour ',0

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
