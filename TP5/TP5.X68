*-----------------------------------------------------------
* Title      :  TP5
* Written by :  ERRARd et DACCACHE
* Date       :  10/04/2024
* Description:  TP5
*-----------------------------------------------------------
via1 equ $f0441                     *initialisaton des equivalences
ifr equ $1A                         *registre d'interruption valide
ier equ $1C                         *registre d'indicateur d'interruption
pcr equ $18                         *registre de controle des peripheriques
SR equ $14                          *registre d'etat
CR EQU $0D                          *retour chariot (carriage return)
LF EQU $0A                          *Saut de ligne (Line Feed)
  
  
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
        lea  via1,A0                *chargement de via1 dans A0
        move.l #inter1,$70          *on precise la localisation de l'interruption (inter1) dans l'adresse 70 niveau 4
        move.b #$01,pcr(A0)         *on met le pcr a 01 pour activer CA1 en front montant
        move.b #$82,ier(A0)         *on active l'interruption en activant le CA1
        move.w #$2300,SR            *on met 2300 le registre d'etat pour metre le masque d'interruption a 3
        
        
        
        
Debut   clr.w $E00000               *On efface les case 1 de l'afficheur (eteinte)
        clr.w $E00002               *On efface les case 2 de l'afficheur (eteinte)
        clr.w $E00004               *On efface les case 3 de l'afficheur (eteinte)
        clr.w $E00006               *On efface les case 4 de l'afficheur (eteinte)
        clr.w $E00008               *On efface les case 5 de l'afficheur (eteinte)
        clr.w $E0000A               *On efface les case 6 de l'afficheur (eteinte)
        clr.w $E0000C               *On efface les case 7 de l'afficheur (eteinte)
        clr.w $E0000E               *On efface les case 8 de l'afficheur (eteinte)
        
Aff     lea message1,A1             *on charge le message1 dans A1
        move #14,D0                 *on met 14 dans D0
        TRAP #15                    *on execute et on affiche le message1
suite   lea message2,A1             *on charge le message2 dans A2
        move #14,D0                 *on met 14 dans D0
        TRAP #15                    *on execute et on affiche le message2
        move #5,D0                  *on met 5 dans D0
        TRAP #15                    *on execute et on attend l'entree d'un charactere        
suite1  cmp #$41,D1                 *on compare la valeur du charactere entree a 41 (correspond a a dans le code ASCII)
        beq ON                      *si c'est egale on passe au code de l'etiauette ON
        cmp #$61,D1                 *on compare la valeur du charactere entree a 61 (correspond a A dans le code ASCII)
        beq ON                      *si c'est egale on passe au code de l'etiauette ON
        
        cmp #$45,D1                 *on compare la valeur du charactere entree a 45 (correspond a e dans le code ASCII)
        beq OFF                     *si c'est egale on passe au code de l'etiauette OFF
        cmp #$65,D1                 *on compare la valeur du charactere entree a 65 (correspond a E dans le code ASCII)
        beq OFF                     *si c'est egale on passe au code de l'etiauette OFF
        
        cmp #$43,D1                 *on compare la valeur du charactere entree a 43 (correspond a c dans le code ASCII)
        beq FLIC                    *si c'est egale on passe au code de l'etiauette FLIC
        cmp #$63,D1                 *on compare la valeur du charactere entree a 63 (correspond a C dans le code ASCII)
        beq FLIC                    *si c'est egale on passe au code de l'etiauette FLIC
        bne ERR                     *sinon on passe au code de l'etiquette ERR pour afficher un message d'erreur
        
        
        bra end
        


ON      move.b let_I,$E00004        *on afficher I sur la case 3 de gauche 
        move.b let_E,$E00006        *on afficher E sur la case 4 de gauche
        move.b let_S,$E00008        *on afficher S sur la case 5 de gauche
        cmp #$41,D1                 *on compare D1 a 41 
        beq ON                      *si c'est egale on relancele code de l'etiauette ON
        cmp #$61,D1                 *on compare D1 a 61
        beq ON                      *si c'est egale on relancele code de l'etiauette ON
        bra suite1                  *sinon on passe au code de l'etiquette suite1 pour relancer la comparison apres l'interruption

OFF     clr.b $E00004               *on eteint la case 3 de gauche
        clr.b $E00006               *on eteint la case 4 de gauche
        clr.b $E00008               *on eteint la case 5 de gauche
        cmp #$45,D1                 *on compare D1 a 45
        beq OFF                     *si c'est egale on relancele code de l'etiauette OFF
        cmp #$65,D1                 *on compare D1 a 65
        beq OFF                     *si c'est egale on relancele code de l'etiauette OFF
        bra suite1                  *sinon on passe au code de l'etiquette suite1 pour relancer la comparison apres l'interruption
        

FLIC    bsr timer                   *on passe au code de l'etiquette du timer pour faire une tempo de 2s
        move.b let_I,$E00004        *on afficher I sur la case 3 de gauche 
        move.b let_E,$E00006        *on afficher E sur la case 4 de gauche
        move.b let_S,$E00008        *on afficher S sur la case 5 de gauche
        bsr timer                   *on relance la tempo de 2s
        clr.b $E00004               *on eteint la case 3 de gauche
        clr.b $E00006               *on eteint la case 4 de gauche
        clr.b $E00008               *on eteint la case 5 de gauche
        cmp #$43,D1                 *on compare D1 a 43
        beq FLIC                    *si c'est egale on relancele code de l'etiauette FLIC
        cmp #$63,D1                 *on compare D1 a 63
        beq FLIC                    *si c'est egale on relancele code de l'etiauette FLIC
                
        bra suite1                  *sinon on passe au code de l'etiquette suite1 pour relancer la comparison apres l'interruption
        



ERR     lea message3,A1             *on charge message3 dans A1 (message d'erreur)
        move #14,D0                 *on let 14 dans D0
        TRAP #15                    *on execute on affiche le message
        bra suite                   *on passe au code de l'etiquettte suite
        
timer   move.b #50,d2               *code de la temporisation de 2s en utilisant la methode de 2 boucles emboitees
cycle1  move.l #3000,d3 
cycle2  sub #1,d3
        cmp.l #0,d3 
        bgt cycle2 
        sub.b #1,d2 
        cmp.b #0,d2 
        bgt cycle1 
        rts
        
*------Code de l'interruption
inter1  lea message2,A1             *on charge le message2 dans A1
        move #14,D0                 *on met 14 dans D0
        TRAP #15                    *on execute et affiche le message2
        move #5,D0                  *on let 5 dans D0
        TRAP #15                    *on execute et on attend l'entree d'un charactere
        rte                         *on retourne au code ou on a fait l'interruption

end     move #9,D0
        TRAP #15

    SIMHALT             ; halt simulator

* Put variables and constants here
message1 dc.b '--------- TP5 ---------',0
message2 dc.b CR,LF,'Entrer "A" pour allumer, "E" pour eteindre et "C" pour clignoter: ',0
retligne dc.b CR,LF
message3 dc.b CR,LF,'Entrez "A", "E" ou "C" seulement!!',CR,LF,0
let_I   dc.b  $30
let_E   dc.b  $79
let_S   dc.b  $6D

    END    START        ; last line of source
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
