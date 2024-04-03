*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
via1 equ $f0441                     *initialisaton des equivalences
ora equ $1E                          *output port A
ira equ $1E                          *input port A
rpc equ $18                         *registre de controle des peripheriques
ifr equ $1A                         *registre d'interruption valide
ier equ $1C                         *registre d'indicateur d'interruption
sr equ $14                          *registre d'etat
ddra equ $6                         *status des ports A0 a A7 (entree ou sortie)
orb equ $0
ddrb equ $4
    
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
        
        lea via1,A0                 *chargement de via1 dans l'adresse de registre A0
        move.l pin,D1
        move.l #inter,$70           *on choisit l'adresse d'interuption (niveau 4)
        move.b #$11,rpc(A0)         *on met a 1 le bit numero 0 de rpc qui correspond a un front montant sur CA1
        move.b #%10010010,ier(A0)   *on met ier a 1000 0010, pour authorise les interruption sur CA1
        move.w #$2300,sr            *on met les 8 bits de gauche de SR a 0010 0011, pour changer le masque d'interruption a 3 et authorisé mode superviseur
        move.b #$00,ddra(A0)        *on met les pates de A en mode Lecture (0F0443 pour l'affichage dans hardware)
        move.b #$FF,ddrb(A0)        
        clr.l D2
        clr.l D3
        clr.l D4
        movea #$4000,A2
        
    
lecture move.b ira(A0),D2
        move.w #%10000,D3
        and D2,D3
        cmp #%10000,D3
        beq test1
        bne lecture
        
test1   move.b ira(A0),D5
        move.w #%10000,D3
        and D5,D3
        move.b D5,orb(A0)
        cmp #$0,D3
        beq suite1
        bne test1
        
suite1  move.w #%01111,D3
        and D3,D2                    *on retire le 1 qui est a coteu nombre entree
        move.b D2,(A2)+
        add #1,D4
        cmp #$4,D4
        bgt test2
        blt lecture
        

test2   clr.w $E00000
        clr.w $E00002
        clr.w $E00004   
        move.l $4000,D6
        cmp D1,D6
        
        beq aff_oui
        bne aff_hou
        
aff_oui move.b zero,$E00000
        move.b let_U,$E00002
        move.b let_I,$E00004
        bsr stop


aff_hou move.b let_H,$E00000
        move.b zero,$E00002
        move.b let_U,$E00004
        bsr stop

stop    move.b #9,D0
        TRAP #15



inter rte

    SIMHALT             ; halt simulator

* Put variables and constants here
pin     dc.b 6,9,1,2
zero    dc.b  $3F
un      dc.b  $06           
deux    dc.b  $5B           
trois   dc.b  $4F           
quatre  dc.b  $66           
cinque  dc.b  $6D           
six     dc.b  $7D          
sept    dc.b  $07           
huit    dc.b  $7F           
neuf    dc.b  $6F 
let_U   dc.b  $3E
let_I   dc.b  $30
let_H   dc.b  $76
off     dc.b  $00          

    END    START        ; last line of source








































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
