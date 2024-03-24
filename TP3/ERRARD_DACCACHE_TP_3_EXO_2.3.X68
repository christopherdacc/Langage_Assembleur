*-----------------------------------------------------------
* Title      :  TP3-EXO 2.3
* Written by :  ERRARD-DACCACHE
* Date       :  20/03/2024
* Description:  EXO 2.3
*-----------------------------------------------------------
    *include c:\easy68K\equvia.X68
via1 equ $f0441                 *initialisaton des equivalences
orb equ $0                      *output port B
irb equ $0                      *input port B
ora equ $2                      *output port A
ira equ $2                      *input port A
ddra equ $6                     *status des ports A0 a A7 (entree ou sortie)
ddrb equ $4                     *status des ports B0 a B7 (entree ou sortie)

    ORG    $1000
  
START:                  ; first instruction of program

* Put program code here

        lea via1,A0             *chargement de via1 dans l'adresse de registre A0
        move.b #$FF,ddra(A0)    *on met les pates de A en mode Lecture (0F0443 pour l'affichage dans hardware)
        move.b #$FF,ddrb(A0)    *on met les ports de B en mode Lecture (0F0441 pour les bouton dans hardwar)
        clr D1                  *on efface le contenu de D1
        clr D2                  *on efface le contenu de D2
        clr D6                  *on efface le contenu de D6
        move.b  #$01, D2        *on emet #$01 dans D2
        move.b D2, ora(A0)      *on charge D2 dans ORA
        move.b #$00,irb(A0)     *on charge #$00 dans IRB
        add #$100,D6            *on ajout 100 a D6 pour que la vitesse ne soit pas tres rapide au tout debut
        
        
decale  cmp #$80,D7             *on compare le bit numero 7 au contenu de D7
        beq droite              *si c'est egale on execute le code de l'etiquette droite
        rol.b #1,D2             *sinon on fait un decalage de bit vers la gauche
suite   bsr lecture             *on lance le sous programme lecture
        bsr affiche             *on lance le sous programme affiche
        bra decale              *on relance le code de l'etiquette decale
    
droite  ror.b #1,D2
        bra suite

        
lecture move.b irb(A0),D5       *on met irb dans D5
        move.b D5,D6            *on met le contenu de D5 dans D6
        and #$F7F,D6            *on fait une operation logique and entre #$F7F et D6 et le resultat sera sauvegarder dans D6
        move.b D5,D7            *on met le contenu de D5 dans D7
        and #$80,D7             *on fait une operation logique and entre #$80 et D7 et le resultat sera sauvegarder dans D7
                                *apres ces operations logique, si on met le bit 7 des ports B a 1 le sens d'allumage des led se fera de gauche a droite
                                *et si on change les bits 6 a 0 des ports B la vitesse change 
        rts                     *on retourne a bsr affiche (ligne 38)
affiche move.b D2, ORA(A0)      *on charge D2 dans ORA pour allume la led de la pate A correspondante au bit egale a 1


       
Tempo   move.l D6, D3           *on met D6 dans D3
         
cycle1  move.l D3,D4            *on met D3 dans D4
cycle2  dbf D4, cycle2          *on commence l'iteration par rapport au nombre de bit et position de bits mis a 1
        dbf D3, cycle1          *exemple si on active les boutons 7,6,5 et 4 cela donne 1 1111 0000 en binaire donc une iteration de 8388608 fois 
        rts                     *on retourne a bra decale (ligne 39)

stop    move #9,D0
        trap #15
    
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source
















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
