*-----------------------------------------------------------
* Title      :  TP4
* Written by :  ERRARd et DACCACHE
* Date       :  03/04/2024
* Description:  TP4_demande_de_code
*-----------------------------------------------------------
via1 equ $f0441                     *initialisaton des equivalences
ora equ $1E                         *output port A
ira equ $1E                         *input port A
rpc equ $18                         *registre de controle des peripheriques
ifr equ $1A                         *registre d'interruption valide
ier equ $1C                         *registre d'indicateur d'interruption
sr equ $14                          *registre d'etat
ddra equ $6                         *status des ports A0 a A7 (entree ou sortie)
orb equ $0
ddrb equ $4
SR equ $14
ier equ $1C
ifr equ $1A
CR EQU $0D                          *retour chariot (carriage return)
LF EQU $0A                          *Saut de ligne (Line Feed)
    
    ORG    $1000
START:                  ; first instruction of program

* Put program code here
        
        lea via1,A0                 *chargement de via1 dans l'adresse de registre A0
        move.l #inter1,$70           *on choisit l'adresse d'interuption (niveau 4)
        move.b #$11,rpc(A0)         *on met a 1 le bit numero 0 de rpc qui correspond a un front montant sur CA1
        move.b #%10010010,ier(A0)   *on met ier a 1000 0010, pour authorise les interruption sur CA1
        move.w #$2300,sr            *on met les 8 bits de gauche de SR a 0010 0011, pour changer le masque d'interruption a 3 et authorisé mode superviseur
        move.b #$00,ddra(A0)        *on met les pates de A en mode Lecture (0F0443 pour l'affichage dans hardware)
        move.b #$FF,ddrb(A0)
        
        move.l #$4000,A1
        move #$4020,A6
        clr.w (A6)
        move #$4010,A4
        move #$4038,A3

*-------Entree du mot de passe----------        
code    lea MESSAGE1, A1     *chargement de message1 dans l'adresse de registre A1
        move.b #14,D0        *mettre 14 dans le registre D0
        TRAP #15             *affiche du message1     
        lea MESSAGE2, A1     *chargement de message2 dans l'adresse de registre A1
        TRAP #15             *affichage du messsage2
        
        move.b #4,D0          *valeur du premier entier
        TRAP #15              *affichage
        move.w #$A,D6          *déplacement de D1 dans l'adresse (indirect) contenue dans A3 (4030)
        divu D6,D1
        move.l D1,(A3)
        move.b $4039,$4033
        clr.l D1
        move.w $403A,D1
        divu D6,D1
        clr.l (A3)
        move.l D1,(A3)
        move.b $4039,$4032
        clr.l D1
        move.w $403A,D1
        divu D6,D1
        clr.l (A3)
        move.l D1,(A3)
        move.b $4039,$4031
        clr.l D1
        move.w $403A,D1
        divu D6,D1
        clr.l (A3)
        move.l D1,(A3)
        move.b $4039,$4030
        clr.l (A3)
        move #$4030,A3
        
        
        
        
        
initi   move.l #$4000,A2
        clr.l (A2)
        clr.l (A4)
        clr.l D0
        clr.l D2
        clr.l D3
        clr.l D4
        clr.l D5
        clr.w $E00000
        clr.w $E00002
        clr.w $E00004
        clr.w $E00006
        clr.w $E00008
        clr.w $E0000A
        clr.w $E0000C
        clr.w $E0000E
        
    
lecture move.b ira(A0),D2
        move.w #%10000,D3
        and D2,D3
        cmp #%10000,D3
        beq test1
        bne lecture
        
test1   move.b ira(A0),D5
        move.w #%10000,D3
        and D5,D3
        cmp #$0,D3
        beq suite1
        bne test1
        
suite1  move.w #%01111,D3
        and D3,D2                    *on retire le 1 qui est a cote du nombre entree hex
        move.b D2,(A2)+
        bra affichage
cont    add #1,D4
        add #$1,(A4)
        cmp #$4,D4
        bgt test2
        blt lecture
        

test2   move.l #$4000,A1
        move.l (A3),D1
        cmp.l (A1),D1
        beq aff_oui
        bne aff_hou
        
aff_oui move.b zero,$E00000
        move.b let_U,$E00002
        move.b let_I,$E00004
        move.b #$F,orb(A0)
        bsr stop


aff_hou move.b let_H,$E00000
        move.b zero,$E00002
        move.b let_U,$E00004
        move.b #$0,orb(A0)
        add #$1,D7
        add #$1,(A6)
        
        cmp #$3,(A6)
        blt initi
        bsr stop
*--------Affichage des nombres sur le LCD-------------
affichage   cmp #$0,D2
            beq aff_zero
            cmp #$1,D2
            beq aff_un
            cmp #$2,D2
            beq aff_deux
            cmp #$3,D2
            beq aff_trois
            cmp #$4,D2
            beq aff_quatre
            cmp #$5,D2
            beq aff_cinque
            cmp #$6,D2
            beq aff_six
            cmp #$7,D2
            beq aff_sept
            cmp #$8,D2
            beq aff_huit
            cmp #$9,D2
            beq aff_neuf  
*----Affiche 0-----------      
aff_zero cmp #$0,(A4)
         beq aff_pos10
         cmp #$1,(A4)
         beq aff_pos20
         cmp #$2,(A4)
         beq aff_pos30
         cmp #$3,(A4)
         beq aff_pos40
         rts 
aff_pos10 move.b zero,$E00008
         bra cont
aff_pos20 move.b zero,$E0000A
         bra cont
aff_pos30 move.b zero,$E0000C
         bra cont
aff_pos40 move.b zero,$E0000E
         bra cont
*----Affiche 1-----------
aff_un  cmp #$0,(A4)
        beq aff_pos11
        cmp #$1,(A4)
        beq aff_pos21
        cmp #$2,(A4)
        beq aff_pos31
        cmp #$3,(A4)
        beq aff_pos41
        rts 
aff_pos11 move.b un,$E00008
         bra cont
aff_pos21 move.b un,$E0000A
         bra cont
aff_pos31 move.b un,$E0000C
         bra cont
aff_pos41 move.b un,$E0000E
         bra cont
*----Affiche 2-----------
aff_deux cmp #$0,(A4)
        beq aff_pos12
        cmp #$1,(A4)
        beq aff_pos22
        cmp #$2,(A4)
        beq aff_pos32
        cmp #$3,(A4)
        beq aff_pos42
        rts 
aff_pos12 move.b deux,$E00008
         bra cont
aff_pos22 move.b deux,$E0000A
         bra cont
aff_pos32 move.b deux,$E0000C
         bra cont
aff_pos42 move.b deux,$E0000E
         bra cont
*----Affiche 3-----------
aff_trois  cmp #$0,(A4)
        beq aff_pos13
        cmp #$1,(A4)
        beq aff_pos23
        cmp #$2,(A4)
        beq aff_pos33
        cmp #$3,(A4)
        beq aff_pos43
        rts 
aff_pos13 move.b trois,$E00008
         bra cont
aff_pos23 move.b trois,$E0000A
         bra cont
aff_pos33 move.b trois,$E0000C
         bra cont
aff_pos43 move.b trois,$E0000E
         bra cont
*----Affiche 4-----------
aff_quatre  cmp #$0,(A4)
        beq aff_pos14
        cmp #$1,(A4)
        beq aff_pos24
        cmp #$2,(A4)
        beq aff_pos34
        cmp #$3,(A4)
        beq aff_pos44
        rts 
aff_pos14 move.b quatre,$E00008
         bra cont
aff_pos24 move.b quatre,$E0000A
         bra cont
aff_pos34 move.b quatre,$E0000C
         bra cont
aff_pos44 move.b quatre,$E0000E
         bra cont
*----Affiche 5-----------
aff_cinque  cmp #$0,(A4)
        beq aff_pos15
        cmp #$1,(A4)
        beq aff_pos25
        cmp #$2,(A4)
        beq aff_pos35
        cmp #$3,(A4)
        beq aff_pos45
        rts 
aff_pos15 move.b cinque,$E00008
         bra cont
aff_pos25 move.b cinque,$E0000A
         bra cont
aff_pos35 move.b cinque,$E0000C
         bra cont
aff_pos45 move.b cinque,$E0000E
         bra cont
*----Affiche 6-----------
aff_six  cmp #$0,(A4)
        beq aff_pos16
        cmp #$1,(A4)
        beq aff_pos26
        cmp #$2,(A4)
        beq aff_pos36
        cmp #$3,(A4)
        beq aff_pos46
        rts 
aff_pos16 move.b six,$E00008
         bra cont
aff_pos26 move.b six,$E0000A
         bra cont
aff_pos36 move.b six,$E0000C
         bra cont
aff_pos46 move.b six,$E0000E
         bra cont
*----Affiche 7-----------
aff_sept  cmp #$0,(A4)
        beq aff_pos17
        cmp #$1,(A4)
        beq aff_pos27
        cmp #$2,(A4)
        beq aff_pos37
        cmp #$3,(A4)
        beq aff_pos47
        rts 
aff_pos17 move.b sept,$E00008
         bra cont
aff_pos27 move.b sept,$E0000A
         bra cont
aff_pos37 move.b sept,$E0000C
         bra cont
aff_pos47 move.b sept,$E0000E
         bra cont
*----Affiche 8-----------
aff_huit  cmp #$0,(A4)
        beq aff_pos18
        cmp #$1,(A4)
        beq aff_pos28
        cmp #$2,(A4)
        beq aff_pos38
        cmp #$3,(A4)
        beq aff_pos48
        rts 
aff_pos18 move.b huit,$E00008
         bra cont
aff_pos28 move.b huit,$E0000A
         bra cont
aff_pos38 move.b huit,$E0000C
         bra cont
aff_pos48 move.b huit,$E0000E
         bra cont
*----Affiche 9-----------
aff_neuf  cmp #$0,(A4)
        beq aff_pos19
        cmp #$1,(A4)
        beq aff_pos29
        cmp #$2,(A4)
        beq aff_pos39
        cmp #$3,(A4)
        beq aff_pos49
        rts 
aff_pos19 move.b neuf,$E00008
         bra cont
aff_pos29 move.b neuf,$E0000A
         bra cont
aff_pos39 move.b neuf,$E0000C
         bra cont
aff_pos49 move.b neuf,$E0000E
         bra cont
*--------Fin Affichage des nombres sur le LCD------------- 
inter1  move.l #$4000,A2
        clr.l (A1)
        clr.l (A2)
        clr.l (A4)
        clr.l (A6)
        clr.l D0
        clr.l D2
        clr.l D3
        clr.l D4
        clr.l D5
        clr.w $E00000
        clr.w $E00002
        clr.w $E00004
        clr.w $E00006
        clr.w $E00008
        clr.w $E0000A
        clr.w $E0000C
        clr.w $E0000E
        bset #1,ifr(A0)
        rte
        
stop    move.b #9,D0
        TRAP #15
        

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
MESSAGE1  DC.B '----- TP4 Partie 2 ------',CR,LF,0
MESSAGE2  DC.B 'Entrez le mot de passe : ',0

    END    START        ; last line of source












































*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
