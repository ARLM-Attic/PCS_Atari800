 LST OFF
*
* PARALLEL COMMUNICATION
* HANDLER FOR APPLE -> ATARI
* DOWNLOAD
*
 ORG $300
 OBJ $7000
*
BASE EQU $00
*
LOADADR EQU $1300
STOPADR EQU $9000
PORT EQU $C090
AN0TRUE EQU $C059
AN0FALSE EQU $C058
*
* TO USE, TYPE C059 TO SET AN0,
*  AND 300G TO GO!
*
START LDA #>LOADADR
 STA BASE+1
 LDY #0
 STY BASE
*
LOOP LDA (BASE),Y
 STA PORT
 BIT AN0FALSE
 NOP
 NOP
 BIT AN0TRUE
*
 INY
 BNE LOOP
 INC BASE+1
 LDA BASE+1
 CMP #>STOPADR
 BCC LOOP
 RTS
*
