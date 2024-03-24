*-----------------------------------------------------------
* Title      :  TP3-EXO 1.1
* Written by :  ERRARD-DACCACHE
* Date       :  20/03/2024
* Description:  EXO 1.1
*-----------------------------------------------------------
    *include c:\easy68K\equvia.X68
via1 equ $f0441                 *initialisaton des equivalences
ora equ $2                      *output port A
ira equ $2                      *input port A
ddra equ $6                     *status des ports A0 a A7 (entree ou sortie)

    ORG    $1000
  
START:                  ; first instruction of program

* Put program code here

        lea via1,A0             *chargement de via1 dans l'adresse de registre A0
        move.b #$FF,ddra(A0)    *initialisation des port A en sortie (1111 1111)
        move.b  #$01, D2        *on met 01 en hex dans D2
        move.b D2, ORA(A0)      *on affiche sur la pate A0 la valeur 1 (led allumé)
        clr D1                  *on effache le contenu de D1
        
boucle  rol #1, D2              *on effectue une rotation de 1 bit a gauche pour passer de (0000 0001 à 0000 0010)
        move.b D2, ORA(A0)      *maintenant la pate A1 contient la valeur 1 (led alumé)
        add #1,D1               *on ajoute 1 a D1 
        cmp #7,D1               *on compare D1 a 7
        bgt stop                *si D1 > 7 on arrete le programme (on aura allumé les led 0 a 7 une par une)
        blt boucle              *si D1<7 on remote a l'etiquette boucle et on allume la led suivante
        
stop    move #9,D0              *chargement de 9 dans D0
        trap #15                *arret de la simulation
    
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
