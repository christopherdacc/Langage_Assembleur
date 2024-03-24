*-----------------------------------------------------------
* Title      :  TP3-EXO 3.1
* Written by :  ERRARD-DACCACHE
* Date       :  20/03/2024
* Description:  EXO 3.1
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
        move.b #$FF,ddra(A0)    *on met les pates de A en mode Lecture (0F0443 pour l'affichage dans hardware)
        move.b  #$03, D2        *on emet #$03 dans D2
        move.b D2, ORA(A0)      *on charge D2 dans ORA
        clr D1                  *on efface le contenu de D1
    
boucle  rol.b #2, D2            *on effectue un décalage de 2 bits vers la gauche
        move.b D2, ORA(A0)      *on recharge D2 dans ORA
        add #1,D1               *on incremente D1
        cmp #7,D1               *on compare D1 a 7
        bgt stop                *si D1>7 on arrete la simulation
        blt boucle              *si D1<7 on relance la boucle
        
stop    move #9,D0
        trap #15
    
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
