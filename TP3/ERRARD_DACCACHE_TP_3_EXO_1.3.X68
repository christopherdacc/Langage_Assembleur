*-----------------------------------------------------------
* Title      :  TP3-EXO 1.3 1.4
* Written by :  ERRARD-DACCACHE
* Date       :  20/03/2024
* Description:  EXO 1.3 et 1.4
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
    
decale  rol.b #1, D2            *on effectue une rotation de 1 bit a gauche pour passer de (0000 0001 à 0000 0010)
        bsr affiche             *on execute le code de la sub routine affiche
        bra decale              *on reexecute le code de l'etiquette decale
        
        
affiche move.b D2, ORA(A0)      *on charge D2 dans ORA pour allume la led de la pate A correspondante au bit egale a 1
       
Tempo   move.l #$2FF, D3        *on met #$2FF(0010 1111 1111 = 767) dans D3
        
cycle1  move.l D3,D4            *on met le contenue de D3 dans D4
cycle2  dbf D4, cycle2          *cette boucle de tempo va itérer 295296 fois (768+767+766+765+...+0)
        dbf D3, cycle1          *cette boucle cree une temporiation d'environ 0.5s
        rts                     *on retourn a bra boucle (ligne 27)


        
stop    move #9,D0
        trap #15
    
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
