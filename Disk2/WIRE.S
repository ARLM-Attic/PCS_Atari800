 LST OFF
*
* PINBALL CONSTRUCTION KIT
* PINBALL WIRING KIT
*
 ORG $A000
 OBJ $7000
*
* CONSTANTS
*
POLYGON EQU 1
BPOLYGON EQU 2
LIBOBJ EQU 3
*
* TEMPS
*
PARAM EQU $C0
TEMP EQU $C7
XTEMP EQU TEMP+1
YTEMP EQU XTEMP+1
TEMP2 EQU YTEMP+1
*
* DRAWBITS
*
BASE1 EQU $D0
BASE2 EQU BASE1+2
TEMPBITS EQU BASE2+2
VERT EQU TEMPBITS+2
HDIV8 EQU VERT+1
HMOD8 EQU HDIV8+1
WIDTH EQU HMOD8+1
HEIGHT EQU WIDTH+1
*
* RECT ROUTINES
*
TOP EQU TEMPBITS
LFTDIV8 EQU TOP+1
LFTMOD8 EQU LFTDIV8+1
BOTTOM EQU LFTMOD8+3
*
* MAIN PROGRAM
*
CURSOR EQU $80
CURSORY EQU CURSOR+2
CURSORXDIV8 EQU CURSORY+1
CURSORXMOD8 EQU CURSORXDIV8+1
CURSORHEIGHT EQU CURSORXMOD8+1
CURSORWIDTH EQU CURSORHEIGHT+1
NEWCURSORXDIV8 EQU CURSORWIDTH+1
NEWCURSORXMOD8 EQU NEWCURSORXDIV8+1
NEWCURSORY EQU NEWCURSORXMOD8+1
NEWITEM EQU NEWCURSORY+1
LASTITEM EQU NEWITEM+2
*
* OBJECTS
*
OBJ EQU LASTITEM+2
NEXTOBJ EQU OBJ+2
OBJCOUNT EQU NEXTOBJ+1
PLYPTRX EQU OBJCOUNT+1
PLYPTRY EQU PLYPTRX+2
OBJID EQU PLYPTRY+2
FILLCOLOR EQU OBJID+1
VRTXCOUNT EQU FILLCOLOR+1
LBASE EQU VRTXCOUNT+1
SCANMODE EQU LBASE+2
MEMBTM EQU SCANMODE+1
MIDBTM EQU MEMBTM+2
MIDTOP EQU MIDBTM+2
MIDY EQU MIDTOP+2
*
* EDITOR
*
CURSORX EQU MIDY+1
EDITMODE EQU CURSORX+1
SLCTMODE EQU EDITMODE+1
CUROBJ EQU SLCTMODE+1
CURNOISE EQU CUROBJ+1
CURSCORE EQU CURNOISE+1
BMULT EQU CURSCORE+1
ETIMER EQU BMULT+1
SERIES EQU ETIMER+1
SLICE EQU SERIES+1
STEMP EQU SLICE+1
X1 EQU STEMP+1
Y1 EQU X1+1
X2 EQU Y1+1
Y2 EQU X2+1
MIDX EQU Y2+1
WIRE EQU MIDX+1
CONTACTY EQU WIRE+1
*
POLYB EQU $F0
* NEXT EQU $F6
*
* PBDB
*
LOGIC EQU $4B00
WSET EQU $4B18
PBDATA EQU $4B1C
OBJDX EQU PBDATA+1
PBDX EQU $7A40
*
* EXTERNALS
*
DIV8 EQU $2100
MOD8 EQU DIV8+$100
LO EQU MOD8+$100
HI EQU LO+$C0
SETMODE EQU HI+$10F
DRAWBITS EQU SETMODE+$25
XOFFDRAW EQU DRAWBITS+$41
GETRECT EQU XOFFDRAW+$5B
MASKS EQU GETRECT+$41
HLINE EQU MASKS+$11
VLINE EQU HLINE+$20
FRAMERECT EQU VLINE+$58
DRAWRECT EQU FRAMERECT+$28
INRECT EQU DRAWRECT+$10
GETBUTNS EQU INRECT+$2D
INITCRSR EQU GETBUTNS+$B
XDRAWCRSR EQU INITCRSR+$14
UPDATECRSR EQU XDRAWCRSR+$7
DOCRSRX EQU UPDATECRSR+$1E
GETCURSORX EQU DOCRSRX+$17
DOCRSRY EQU GETCURSORX+$10
WAIT EQU DOCRSRY+$3
CRSRINRECT EQU WAIT+$C
DOMENU EQU CRSRINRECT+$13
SELECT EQU DOMENU+$54
INIT EQU SELECT+$40
MOVEUP EQU INIT+$35
MOVEDOWN EQU MOVEUP+$3B
ADDIYX EQU MOVEDOWN+$39
ADDYX EQU ADDIYX+$E
SUBIYX EQU ADDYX+$10
SUBYX EQU SUBIYX+$12
CMPYX EQU SUBYX+$10
CHARTO EQU CMPYX+$F
PRCHAR EQU CHARTO+$A
PRINT EQU PRCHAR+$38
CHAR EQU PRINT+$19
*
* PPAK
*
DRAWDISPLAY EQU $9920
GETOBJ EQU DRAWDISPLAY+$3E
GETNEXTOBJ EQU GETOBJ+$C
GETINFO EQU GETNEXTOBJ+$1B
DRAWOBJ EQU GETINFO+$3E
SCANPOLY EQU DRAWOBJ+$14
ALIGNPOLY EQU SCANPOLY+$433
GETSCAN EQU ALIGNPOLY+$39
MAKEHOLE EQU GETSCAN+$57
SELECTPOLY EQU MAKEHOLE+$4A
POLYPOINTS EQU SELECTPOLY+$33
REMOVEPOLY EQU POLYPOINTS+$37
GETBOUNDS EQU REMOVEPOLY+$6E
*
START LDA #$80
 STA CUROBJ
 STA SCANMODE
 JSR DRAWPOLYS
*
 LDA #0
 STA CURSORY
 STA CURSORXDIV8
 STA CURSORXMOD8
*
 STA EDITMODE
 STA SLCTMODE
*
 STA CURNOISE
 JSR INITSOUND
*
 LDY #2
 JSR SETMODE
*
 LDA #<HAND
 LDX #>HAND
 JSR XOFFDRAW
 LDA #<PLIER
 LDX #>PLIER
 JSR XOFFDRAW
 LDA #<SCREWDRIVER
 LDX #>SCREWDRIVER
 JSR XOFFDRAW
 LDY #$38
 LDX #$21
 LDA #6
 JSR CHARTO
 LDA #<QUITMSG
 LDX #>QUITMSG
 JSR PRINT
*
 LDA #1
STRT2 STA ANDGATE+2
 LDA #<ANDGATE
 LDX #>ANDGATE
 JSR XOFFDRAW
 LDA ANDGATE+2
 CLC
 ADC #15
 CMP #91
 BNE STRT2
*
 ADC #1 ;ADD 2
 LDX #1
 STX XTEMP
STRT3 STA NOTE+2
 LDA #<NOTE
 LDX #>NOTE
 JSR XOFFDRAW
 LDY NOTE+2
 LDX #22
 LDA #1
 JSR CHARTO
 LDA XTEMP
 JSR PRCHAR
 INC XTEMP
 LDA NOTE+2
 CLC
 ADC #14
 CMP #191
 BNE STRT3
*
 LDA #<HAND
 LDX #>HAND
 JSR INITCRSR
*
MAIN INC ETIMER
 JSR SOUND
 JSR UPDATECRSR
 JSR GETBUTNS
 BPL MAIN
*
 LDA #<TOOLB
 LDX #>TOOLB
 JSR CRSRINRECT
 BCC MAIN2
 LDA #0
 STA LASTITEM+1
 LDA #<CMDMENU
 LDX #>CMDMENU
 JSR DOMENU
 JMP MAIN
*
MAIN2 JSR MODE0
 JMP MAIN
*
MODE0 LDA EDITMODE
 BNE MODE1
 JMP SELECTOBJ
MODE1 CMP #1
 BNE MODE2
 JMP CUTWIRE
MODE2 JMP ADDWIRE
*
DRAWPOLYS LDY #0
 JSR GETOBJ
DRAWP2 LDA OBJID
 CMP #<BPOLYGON
 BEQ DRAWP3
 CMP #<POLYGON
 BNE DRAWP4
DRAWP3 JSR DRAWOBJ
DRAWP4 INC NEXTOBJ
 LDY NEXTOBJ
 JSR GETNEXTOBJ
 LDY NEXTOBJ
 CPY OBJCOUNT
 BNE DRAWP2
 RTS
*
INITHAND JSR XDRAWCRSR
 LDA #<HAND
 LDX #>HAND
 LDY #0
SETEDMODE STY EDITMODE
 JMP INITCRSR
*
INITPLIER JSR XDRAWCRSR
 LDA #<PLIER
 LDX #>PLIER
 LDY #1
 BNE SETEDMODE
*
INITDRIVER JSR XDRAWCRSR
 LDA #<SCREWDRIVER
 LDX #>SCREWDRIVER
 LDY #2
 BNE SETEDMODE
*
QUIT LDA SLCTMODE
 BEQ QUIT3
 CMP #1
 BNE QUIT2
 JSR DISPLAYPOLY
 JMP QUIT3
QUIT2 JSR DISPLAYAND
QUIT3 JSR DRAWPOLYS
 PLA
 PLA
 RTS
*
SELECTOBJ LDA #<TABLEB
 LDX #>TABLEB
 JSR CRSRINRECT
 BCC SOBJ2
*
 LDA #1
 JSR SETDSPLY
 JSR SELECTLIB
 STY CUROBJ
 BEQ SPOLY3
 JSR DISPLAYPOLY
 JSR DOSOUND
SPOLY2 JSR GETBUTNS
 BMI SPOLY2
 RTS
SPOLY3 STY CURNOISE
 STY CURSCORE
 RTS
*
DOSOUND LDY CURNOISE
 BEQ DOSND2
 LDA SOUNDCODE-1,Y
 CMP SERIES
 BMI DOSND2
 STA SERIES
DOSND2 RTS
*
SOUNDCODE HEX 00040C1424384C
*
SOBJ2 LDA #<ANDB
 LDX #>ANDB
 JSR CRSRINRECT
 BCC SOBJ3
*
 LDA #2
 JSR SETDSPLY
 JSR SELECTAND
 STY CUROBJ
 JSR DISPLAYAND
 JSR DOSOUND
SAND2 JSR GETBUTNS
 BMI SAND2
 RTS
*
SOBJ3 LDA #<NOTEB
 LDX #>NOTEB
 JSR CRSRINRECT
 BCC SOBJ4
*
 LDA CURNOISE
 JSR HLNOISE
 LDA #0
 STA LASTITEM+1
 LDA #<NOTEMENU
 LDX #>NOTEMENU
 JSR DOMENU
 BEQ SNOTE2
 JSR DOSOUND
 LDA CUROBJ
 BEQ SNOTE2
 LDA CURNOISE
 JSR HLNOISE
 JMP FIXOBJ
SNOTE2 LDA #0
 STA CURNOISE
 JMP FIXOBJ
*
NOTEMENU DA NBOX1
 DA SETNOISE
 DA NBOX2
 DA SETNOISE
 DA NBOX3
 DA SETNOISE
 DA NBOX4
 DA SETNOISE
 DA NBOX5
 DA SETNOISE
 DA NBOX6
 DA SETNOISE
 DA NBOX7
 DA SETNOISE
 HEX 00
*
SETNOISE LDA YTEMP
 CLC
 ADC #6
 LSR
 LSR
 STA CURNOISE
 RTS
*
SOBJ4 LDA SLCTMODE
 CMP #2
 BNE SOBJ5
 LDA #<BMULTBOX
 LDX #>BMULTBOX
 JSR CRSRINRECT
 BCC SOBJ5
*
 LDA BMULT
 BEQ SBON2
 LDA #<BMULTBOX
 LDX #>BMULTBOX
 JSR DRAWRECT
SBON2 LDA #0
 STA LASTITEM+1
 LDA #<BMULTMENU
 LDX #>BMULTMENU
 JSR DOMENU
 BEQ SBON3
 LDA #<BMULTBOX
 LDX #>BMULTBOX
 JSR DRAWRECT
 JMP FIXOBJ
SBON3 LDA #0
 STA BMULT
 JMP FIXOBJ
*
BMULTMENU DA BMULTBOX
 DA SETBMUL
 HEX 00
*
SETBMUL LDA #$80
 STA BMULT
 RTS
*
SCOREMENU DA SCBOX1
 DA SETSCORE
 DA SCBOX2
 DA SETSCORE
 DA SCBOX3
 DA SETSCORE
 DA SCBOX4
 DA SETSCORE
 DA SCBOX5
 DA SETSCORE
 DA SCBOX6
 DA SETSCORE
 DA SCBOX7
 DA SETSCORE
 DA SCBOX8
 DA SETSCORE
 DA SCBOX9
 DA SETSCORE
 DA SCBOX10
 DA SETSCORE
 DA SCBOX11
 DA SETSCORE
 DA SCBOX12
 DA SETSCORE
 DA SCBOX13
 DA SETSCORE
 DA SCBOX14
 DA SETSCORE
 DA SCBOX15
 DA SETSCORE
 HEX 00
*
SOBJ5 LDA #<SCOREB
 LDX #>SCOREB
 JSR CRSRINRECT
 BCC SOBJ6
*
 LDA CURSCORE
 JSR HLSCORE
 LDA #0
 STA LASTITEM+1
 LDA #<SCOREMENU
 LDX #>SCOREMENU
 JSR DOMENU
 BEQ SSCOR2
 LDA CUROBJ
 BEQ SSCOR2
 LDA CURSCORE
 JSR HLSCORE
 JMP FIXOBJ
SSCOR2 LDA #0
 STA CURSCORE
 JMP FIXOBJ
*
SETSCORE LDA YTEMP
 CLC
 ADC #6
 LSR
 LSR
 STA CURSCORE
*
SOBJ6 RTS
*
ADDWIRE LDA SLCTMODE
 CMP #2
 BNE ADDWIR5
 JSR SELECTLIB
 BEQ ADDWIR5
*
 STY TEMP
 LDY #9
 LDA (LBASE),Y
 BMI ADDWIR5
*
 LDA TEMP
 LDX CUROBJ
 LDY TIMES4-1,X
 CMP LOGIC,Y
 BEQ ADDWIR5
 CMP LOGIC+1,Y
 BEQ ADDWIR5
 CMP LOGIC+2,Y
 BEQ ADDWIR5
*
 LDA LOGIC,Y
 BNE ADDWIR2
 LDA TEMP
 STA LOGIC,Y
 LDY #2
 JSR DRAWWIRE
 JMP ADDWIR4
ADDWIR2 INY
 LDA LOGIC,Y
 BNE ADDWIR3
 LDA TEMP
 STA LOGIC,Y
 LDY #7
 JSR DRAWWIRE
 JMP ADDWIR4
ADDWIR3 INY
 LDA LOGIC,Y
 BNE ADDWIR5
 LDA TEMP
 STA LOGIC,Y
 LDY #12
 JSR DRAWWIRE
ADDWIR4 JSR GETBUTNS
 BMI ADDWIR4
ADDWIR5 RTS
*
CUTWIRE LDA SLCTMODE
 CMP #2
 BNE ADDWIR5
 JSR SELECTLIB
 BEQ ADDWIR5
 STY TEMP
 TYA
 LDX CUROBJ
 LDY TIMES4-1,X
 CMP LOGIC,Y
 BNE CUTWIR2
 LDA #0
 STA LOGIC,Y
 LDA TEMP
 LDY #2
 JSR DRAWWIRE
 JMP ADDWIR4
CUTWIR2 INY
 CMP LOGIC,Y
 BNE CUTWIR3
 LDA #0
 STA LOGIC,Y
 LDA TEMP
 LDY #7
 JSR DRAWWIRE
 JMP ADDWIR4
CUTWIR3 INY
 CMP LOGIC,Y
 BNE ADDWIR5
 LDA #0
 STA LOGIC,Y
 LDA TEMP
 LDY #12
 JSR DRAWWIRE
 JMP ADDWIR4
*
FIXOBJ LDX CUROBJ
 BEQ FIXOBJ3
 LDA SLCTMODE
 CMP #1
 BNE FIXOBJ2
 LDA CURNOISE
 ASL
 ASL
 ASL
 ASL
 ORA CURSCORE
 LDY #9
 STA (LBASE),Y
 RTS
*
FIXOBJ2 CMP #2
 BNE FIXOBJ3
 LDA CURNOISE
 ASL
 ASL
 ASL
 ASL
 ORA BMULT
 ORA CURSCORE
 STA TEMP
 LDA TIMES4-1,X
 CLC
 ADC #3
 TAY
 LDA TEMP
 STA LOGIC,Y
 RTS
*
TIMES4 HEX 0004080C1014
*
FIXOBJ3 RTS
*
SETDSPLY CMP SLCTMODE
 BNE SETDSP5
*
SETDSP2 CMP #0
 BNE SETDSP3
 RTS
SETDSP3 CMP #1
 BNE SETDSP4
 JMP DISPLAYPOLY
SETDSP4 JMP DISPLAYAND
*
SETDSP5 PHA
 LDA SLCTMODE
 JSR SETDSP2
 JSR CLEARSB
 PLA
 STA SLCTMODE
 CMP #1
 BNE SETDSP6
 JMP SCMENU
SETDSP6 JMP BNMENU
*
SELECTLIB JSR SELECTPOLY
 BCC SLCTLIB2
 TAY
 JSR GETOBJ
 LDA OBJID
 CMP #<LIBOBJ
 BEQ SLCTLIB3
SLCTLIB2 LDY #0
 BEQ SLCTLIB4
SLCTLIB3 LDY NEXTOBJ
SLCTLIB4 RTS
*
SELECTAND LDY #6
 LDA CURSORY
SLCTAND2 CMP TIMES15-1,Y
 BCS SLCTLIB4
 DEY
 BPL SLCTAND2
*
TIMES15 HEX 000F1E2D3C4B
*
DISPLAYPOLY LDA CUROBJ
 BEQ DSPLY2
 LDY #9
 LDA (LBASE),Y
 AND #$7F
 STA TEMP
 AND #$0F
 STA CURSCORE
 JSR HLSCORE
 LDA TEMP
 LSR
 LSR
 LSR
 LSR
 STA CURNOISE
 JSR HLNOISE
 JSR GETBOUNDS
 LDA PARAM
 STA POLYB
 LDA PARAM+1
 SEC
 SBC PARAM
 CLC
 ADC #1
 STA POLYB+3
 LDY PARAM+2
 LDA DIV8,Y
 STA POLYB+1
 LDA MOD8,Y
 STA POLYB+2
 LDA PARAM+3
 SEC
 SBC PARAM+2
 TAY
 LDA DIV8,Y
 STA POLYB+4
 LDA MOD8,Y
 STA POLYB+5
 LDA #<POLYB
 LDX #>POLYB
 JSR DRAWRECT
DSPLY2 RTS
*
DISPLAYAND LDX CUROBJ
 BEQ DSPLY2
*
 LDY TIMES4-1,X
 STY WIRE
 LDA LOGIC,Y
 BEQ DSAND2
 LDY #2
 JSR DRAWWIRE
DSAND2 INC WIRE
 LDY WIRE
 LDA LOGIC,Y
 BEQ DSAND3
 LDY #7
 JSR DRAWWIRE
DSAND3 INC WIRE
 LDY WIRE
 LDA LOGIC,Y
 BEQ DSAND4
 LDY #12
 JSR DRAWWIRE
DSAND4 INC WIRE
 LDY WIRE
 LDA LOGIC,Y
 STA TEMP
 AND #$0F
 STA CURSCORE
 JSR HLSCORE
 LDA TEMP
 AND #$80
 STA BMULT
 BPL DSAND5
 LDA #<BMULTBOX
 LDX #>BMULTBOX
 JSR DRAWRECT
DSAND5 LDA TEMP
 LSR
 LSR
 LSR
 LSR
 AND #$07
 STA CURNOISE
 JSR HLNOISE
*
 LDY CUROBJ
 LDA TIMES15-1,Y
 STA ANDBOX
 LDA #<ANDBOX
 LDX #>ANDBOX
 JMP DRAWRECT
*
HLSCORE BEQ HLSCR2
 TAY
 LDA SCVERT-1,Y
 STA SCBOX
 LDA #<SCBOX
 LDX #>SCBOX
 JMP DRAWRECT
HLSCR2 RTS
*
SCVERT HEX 0C16202A343E48525C66707A848E98
*
HLNOISE BEQ HLSCR2
 TAY
 LDA NVERT-1,Y
 STA NBOX
 LDA #<NBOX
 LDX #>NBOX
 JMP DRAWRECT
*
NVERT HEX 5C6A788694A2B0
*
DRAWWIRE STY CONTACTY
 TAY
 JSR GETOBJ
 JSR GETBOUNDS
 LDA PARAM+3
 STA X1
 LDA PARAM
 STA Y1
 LDA #160
 STA X2
 LDY CUROBJ
 LDA TIMES15-1,Y
 CLC
 ADC CONTACTY
 STA Y2
*
 LDX X1
 LDA DIV8,X
 STA POLYB+1
 LDA MOD8,X
 STA POLYB+2
 LDA X2
 CLC
 ADC X1
 ROR
 STA MIDX
 SEC
 SBC X1
 TAX
 LDA DIV8,X
 STA POLYB+4
 LDA MOD8,X
 STA POLYB+5
 LDA #<POLYB
 LDX #>POLYB
 JSR GETRECT
 LDX Y1
 JSR HLINE
*
 LDX MIDX
 LDA DIV8,X
 STA POLYB+1
 LDA MOD8,X
 STA POLYB+2
 LDA X2
 SEC
 SBC MIDX
 TAX
 LDA DIV8,X
 STA POLYB+4
 LDA MOD8,X
 STA POLYB+5
 LDA #<POLYB
 LDX #>POLYB
 JSR GETRECT
 LDX Y2
 JSR HLINE
*
 LDA #<POLYB
 LDX #>POLYB
 JSR GETRECT
 LDX Y1
 LDY Y2
 CPY Y1
 BCS DRWIR2
 LDX Y2
 LDY Y1
DRWIR2 INX
 DEY
 STX TOP
 STY BOTTOM
 LDY LFTDIV8
 LDX LFTMOD8
 JMP VLINE
*
CLEARSB LDY #3
 JSR SETMODE
 LDA #<SCOREB
 LDX #>SCOREB
 JSR DRAWRECT
 LDY #2
 JMP SETMODE
*
SCMENU LDY #0
 LDA #4
SCMENU2 STY XTEMP
 STA CHAR+2
 LDA #26
 STA CHAR+3
 LDA #2
 STA CHAR+4
 LDA TXTLO,Y
 LDX TXTHI,Y
 JSR PRINT
 LDA CHAR+2
 CLC
 ADC #10
 LDY XTEMP
 INY
 CPY #16
 BNE SCMENU2
 RTS
*
BNMENU LDY #0
 LDA #4
BNMENU2 STY XTEMP
 STA CHAR+2
 LDA #26
 STA CHAR+3
 LDA #2
 STA CHAR+4
 LDA TXTLO+16,Y
 LDX TXTHI+16,Y
 JSR PRINT
 LDA CHAR+2
 CLC
 ADC #10
 LDY XTEMP
 INY
 CPY #16
 BNE BNMENU2
 LDA #$AA
 STA CHAR+2
 LDA #25
 STA CHAR+3
 LDA #6
 STA CHAR+4
 LDA #<BONUSX
 LDX #>BONUSX
 JMP PRINT
*
CMDMENU DA HANDB
 DA INITHAND
 DA PLIERB
 DA INITPLIER
 DA DRIVERB
 DA INITDRIVER
 DA QUITB
 DA QUIT
 HEX 00
*
* SOUND EFFECTS
*
SOUND LDA ETIMER
 AND #$0F
 BEQ *+3
 RTS
*
 LDA SERIES
 BMI SOUND5
SOUND1 CLC
 ADC SLICE
 TAX
 STX STEMP
 LDY EFFECTS,X
SOUND2 LDX NOTES-12,Y
 BEQ SOUND4
 LDA #$AF
 STA $D201
 STX $D200
 INY
 BNE SOUND2
SOUND4 INC SLICE
 LDX STEMP
 LDA EFFECTS+1,X
 BNE SOUND5
*
INITSOUND LDA #$A0
 STA $D201
 LDY #$FF
 STY SERIES
 INY
 STY SLICE
SOUND5 RTS
*
EFFECTS HEX 540C5400 ;0
 HEX 0C1824303C485400 ;4
 HEX 54483C3024180C00 ;12
 HEX 540C540C540C540C0C243C54543C2400 ;20
 HEX 0C1824303C4854483C303C483C303C483C303C00 ;36
 HEX 0C1824303C485454483C3024180C1824303C4800 ;56
 HEX 0C1824300C1824300C1824300C1824300C182400 ;76
*
NOTES HEX 284828482848284828482800 ;$00
 HEX 385838583858385838583800 ;$0C
 HEX 406040604060406040604000 ;$18
 HEX 284828482848284828482800 ;$24
 HEX 608060806080608060806000 ;$30
 HEX 385838583858385838583800 ;$3C
 HEX 406040604060406040604000 ;$48
 HEX 486848684868486848684800 ;$54
*
TABLEB HEX 000000BF1301
*
KITB HEX 001302BF1407
*
TOOLB HEX 002104BF0303
*
HANDB HEX 0021040F0303
*
PLIERB HEX 102104120303
*
DRIVERB HEX 232104120303
*
QUITB HEX 3621040A0303
*
ANDB HEX 0114015A0303
ANDBOX HEX 0013070E0306
*
SCOREB HEX 041903BB0501
SCBOX HEX 0019030A0307
SCBOX1 HEX 0C19030A0307
SCBOX2 HEX 1619030A0307
SCBOX3 HEX 2019030A0307
SCBOX4 HEX 2A19030A0307
SCBOX5 HEX 3419030A0307
SCBOX6 HEX 3E19030A0307
SCBOX7 HEX 4819030A0307
SCBOX8 HEX 5219030A0307
SCBOX9 HEX 5C19030A0307
SCBOX10 HEX 6619030A0307
SCBOX11 HEX 7019030A0307
SCBOX12 HEX 7A19030A0307
SCBOX13 HEX 8419030A0307
SCBOX14 HEX 8E19030A0307
SCBOX15 HEX 9819030A0307
*
BMULTBOX HEX A819030A0505
*
NOTEB HEX 5C1500620204
NBOX HEX 0014030D0204
NBOX1 HEX 5C14030D0204
NBOX2 HEX 6A14030D0204
NBOX3 HEX 7814030D0204
NBOX4 HEX 8614030D0204
NBOX5 HEX 9414030D0204
NBOX6 HEX A214030D0204
NBOX7 HEX B014030D0204
*
QUITMSG HEX 1A1E129D
*
TXTLO DA <SCOREMSG
 DA <SC1MSG
 DA <SC2MSG
 DA <SC3MSG
 DA <SC4MSG
 DA <SC5MSG
 DA <SC6MSG
 DA <SC7MSG
 DA <SC8MSG
 DA <SC9MSG
 DA <SC10MSG
 DA <SC11MSG
 DA <SC12MSG
 DA <SC13MSG
 DA <SC14MSG
 DA <SC15MSG
 DA <BONUSMSG
 DA <BN1MSG
 DA <BN2MSG
 DA <BN3MSG
 DA <BN4MSG
 DA <BN5MSG
 DA <BN6MSG
 DA <BN7MSG
 DA <BN8MSG
 DA <BN9MSG
 DA <BN10MSG
 DA <BN11MSG
 DA <BN12MSG
 DA <BN13MSG
 DA <BN14MSG
 DA <BN15MSG
*
TXTHI DA >SCOREMSG
 DA >SC1MSG
 DA >SC2MSG
 DA >SC3MSG
 DA >SC4MSG
 DA >SC5MSG
 DA >SC6MSG
 DA >SC7MSG
 DA >SC8MSG
 DA >SC9MSG
 DA >SC10MSG
 DA >SC11MSG
 DA >SC12MSG
 DA >SC13MSG
 DA >SC14MSG
 DA >SC15MSG
 DA >BONUSMSG
 DA >BN1MSG
 DA >BN2MSG
 DA >BN3MSG
 DA >BN4MSG
 DA >BN5MSG
 DA >BN6MSG
 DA >BN7MSG
 DA >BN8MSG
 DA >BN9MSG
 DA >BN10MSG
 DA >BN11MSG
 DA >BN12MSG
 DA >BN13MSG
 DA >BN14MSG
 DA >BN15MSG
*
SCOREMSG HEX 1C0C181B8E
SC1MSG HEX 0180
SC2MSG HEX 0280
SC3MSG HEX 0380
SC4MSG HEX 0480
SC5MSG HEX 0580
SC6MSG HEX 010080
SC7MSG HEX 010580
SC8MSG HEX 020080
SC9MSG HEX 020580
SC10MSG HEX 030080
SC11MSG HEX 040080
SC12MSG HEX 050080
SC13MSG HEX 070580
SC14MSG HEX 01000080
SC15MSG HEX 01050080
*
BONUSMSG HEX 0B18171E9C
BN1MSG HEX 0194
BN2MSG HEX 0294
BN3MSG HEX 0394
BN4MSG HEX 0494
BN5MSG HEX 0594
BN6MSG HEX 0694
BN7MSG HEX 0794
BN8MSG HEX 0894
BN9MSG HEX 0994
BN10MSG HEX 010094
BN11MSG HEX 020094
BN12MSG HEX 030094
BN13MSG HEX 040094
BN14MSG HEX 050094
BN15MSG HEX 01000094
*
BONUSX HEX 0B18171E1CA1
*
HAND DA *+7
 HEX 0222040C02
 HEX C000600030001860
 HEX 2CC03EC07FC07FC0
 HEX 3FA01F600EC00180
*
PLIER DA *+7
 HEX 1222020F03
 HEX 1C00000600006300003B8000
 HEX 0E7FC0038070018018018000
 HEX 018000018000018000018000
 HEX 01800000C000006000
*
SCREWDRIVER DA *+7
 HEX 2523021001
 HEX 6060606060606060
 HEX 90F0F0F0F0F0F060
*
ANDGATE DA *+7
 HEX 0014010D04
 HEX F3FF0000FF01C000F300600003003000
 HEX 03001800F30018F0FF001FF0F30018F0
 HEX 0300180003003000F3006000FF01C000
 HEX F3FF0000
*
NOTE DA *+7
 HEX 0015000C01
 HEX 0E080E080808080878F8F870
