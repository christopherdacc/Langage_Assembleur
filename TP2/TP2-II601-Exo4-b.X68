*-----------------------------------------------------------
* Title      : TP2 EXO 4
* Written by : ERRARD - DACCACHE
* Date       : 13/03/24
* Description: EXO 4 b mote par mot
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program
CR EQU $0D              *retour chariot (carriage return)
LF EQU $0A              *Saut de ligne (Line Feed)
* Put program code here
        LEA MESSAGE0, A1    *chargement de message dans l'adresse de registre A1
        MOVE.B #14,D0       *Mettre 14 dans le registre D0
        TRAP #15            *Affiche le message
*------------------------------------------------------    
        MOVE.B #1,$2000     *on met 1 dans l'adresse 2000
        MOVE.B #2,$2020     *on met 2 dans l'adresse 2020

        LEA $2000,A0        *on charge le contenu de l'adresse 2000 dans A0
        LEA $2020,A2        *on charge le contenu de l'adresse 2020 dans A2
        LEA $2040,A1        *on charge le contenu de l'adresse 2040 dans A1
CYCLE   MOVE.W (A0)+,(A1)+  *on met ce qui est dans l'adresse charger dans A0 dans l'adresse charger dans A1 et on post incremente les 2 adresses        
        CMPA A0,A2          *on compare le contenu de A0 et A2
        BEQ FIN             *si c'est le meme contenu on pass au code de l'etiquette FIN
        BRA CYCLE           *si le contenu n'est pas le meme on repasse au code de l'etiquette CYCLE jusqu'a ce que le contenu soit le meme

FIN     MOVE.B #9,D0        *on met 9 dans D0
        TRAP #15            *on arrete le programme
        
        
    SIMHALT             ; halt simulator

* Put variables and constants here
MESSAGE0  DC.B '----- TP 2 EXO 4 -----',0,CR,LF

    END    START        ; last line of source

*POUR LES WORD ET LONG ON REMPLACE .B PAR .L ET .W 
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
