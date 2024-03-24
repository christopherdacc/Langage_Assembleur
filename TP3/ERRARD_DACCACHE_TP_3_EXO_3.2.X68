*-----------------------------------------------------------
* Title      :  TP3-EXO 3.2
* Written by :  ERRARD-DACCACHE
* Date       :  20/03/2024
* Description:  EXO 3.2
*-----------------------------------------------------------
    *include c:\easy68K\equvia.X68
via1 equ $f0441                     *initialisaton des equivalences
ora equ $2                          *output port A
ira equ $2                          *input port A
rpc equ $18                         *registre de controle des peripheriques
ifr equ $1A                         *registre d'interruption valide
ier equ $1C                         *registre d'indicateur d'interruption
sr equ $14                          *registre d'etat
ddra equ $6                         *status des ports A0 a A7 (entree ou sortie)

    ORG    $1000
  
START:                  ; first instruction of program

* Put program code here

        lea via1,A0                 *chargement de via1 dans l'adresse de registre A0
        move.l #inter,$70           *on choisit l'adresse d'interuption (niveau 4)
        move.b #$1,rpc(A0)          *on met a 1 le bit numero 0 de rpc qui correspond a un front montant sur CA1
        move.b #%10000010,ier(A0)   *on met ier a 1000 0010, pour authorise les interruption sur CA1
        move.w #$2300,sr            *on met les 8 bits de gauche de SR a 0010 0011, pour changer le masque d'interruption a 3 et authorisé mode superviseur
        move.b #$FF,ddra(A0)        *on met les pates de A en mode Lecture (0F0443 pour l'affichage dans hardware)
        move.b  #$03, D2            *on emet #$03 dans D2
        move.b D2, ORA(A0)          *on charge D2 dans ORA
        clr D1                      *on efface le contenu de D1
        
    
boucle  cmp #1,D1                   *on compare D1 a 1
        beq droite                  *si D1=1 on passe a programme de l'etiquette droite
        rol.b #2, D2                *sinon on on fait un decalage de 2 bit vers la gauche
gauche  bsr affiche                 *on passe ou sous programme affiche
        bra boucle                  *on relance le programme d'etiquette boucle
        
droite  ror.b #2,D2                 *on fait un deplacement de 2 bit vers la droite
        bsr affiche                 *on passe ou sous programme affiche
        bra boucle                  *on relance le programme d'etiquette boucle
affiche move.b D2, ORA(A0)          *on recharge D2 dans ORA
       
Tempo   move.l #$2FF, D3            *on met#$2FF dans D3
      
cycle1  move.l D3,D4                *on met D3 dans D4
cycle2  dbf D4, cycle2              *on commence le cycle de temporisation
        dbf D3, cycle1
        rts                         *on retourne au programme bra boucle (ligne 38 ou ligne 42) cela depand de D1
*----(programme d'interruption)-------------------------------        
inter   cmp #0,D1                   *on compare D1 a 0 losqu'on a un front montant sur CA1 (declanchement de l'interruption 4 sur le hardware)
        beq yes                     *si D1 = 0 on passe a l'etiquette yes
        bne no                      *sinon on passe a l'etiquette no
yes     add #1,D1                   *si D1 = 0 on ajoute 1 a D1
        bra out                     *on passe a l'etiquette out
no      sub #1,D1                   *si D1 n'est pas egale a 0 on soustrait 1 a D1 pour qu'il redeviet egale a 0
        bra out                     *on passe a l'etiquette out
out     bset #1,ifr(A0)             *apres avoir modifier la valeur de D1 on change le bit numeo 1 de IFR qui correspond a CA1 pour arreter l'interruption
        rte                         *on sort de l'interruption et on reprend le code d'ou on avait arreter

        
stop    move #9,D0
        trap #15
    
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
