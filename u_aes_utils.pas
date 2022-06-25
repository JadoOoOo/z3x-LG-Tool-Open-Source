unit u_aes_utils;

interface

uses
     SysUtils, Windows, WCrypt2, FGInt, FGIntRSA;

const
     AESMaxRounds = 14;

const
     AES_Err_Invalid_Key_Size       = -1;  {Key size <> 128, 192, or 256 Bits}
     AES_Err_Invalid_Mode           = -2;  {Encr/Decr with Init for Decr/Encr}
     AES_Err_Invalid_Length         = -3;  {No full block for cipher stealing}
     AES_Err_Data_After_Short_Block = -4;  {Short block must be last}
     AES_Err_MultipleIncProcs       = -5;  {More than one IncProc Setting    }
     AES_Err_NIL_Pointer            = -6;  {nil pointer to block with nonzero length}
     AES_Err_EAX_Inv_Text_Length    = -7;  {More than 64K text length in EAX all-in-one for 16 Bit}
     AES_Err_EAX_Inv_TAG_Length     = -8;  {EAX all-in-one tag length not 0..16}
     AES_Err_EAX_Verify_Tag         = -9;  {EAX all-in-one tag does not compare}

const
  SBox: array[byte] of byte =
   ($63, $7c, $77, $7b, $f2, $6b, $6f, $c5, $30, $01, $67, $2b, $fe, $d7, $ab, $76,
    $ca, $82, $c9, $7d, $fa, $59, $47, $f0, $ad, $d4, $a2, $af, $9c, $a4, $72, $c0,
    $b7, $fd, $93, $26, $36, $3f, $f7, $cc, $34, $a5, $e5, $f1, $71, $d8, $31, $15,
    $04, $c7, $23, $c3, $18, $96, $05, $9a, $07, $12, $80, $e2, $eb, $27, $b2, $75,
    $09, $83, $2c, $1a, $1b, $6e, $5a, $a0, $52, $3b, $d6, $b3, $29, $e3, $2f, $84,
    $53, $d1, $00, $ed, $20, $fc, $b1, $5b, $6a, $cb, $be, $39, $4a, $4c, $58, $cf,
    $d0, $ef, $aa, $fb, $43, $4d, $33, $85, $45, $f9, $02, $7f, $50, $3c, $9f, $a8,
    $51, $a3, $40, $8f, $92, $9d, $38, $f5, $bc, $b6, $da, $21, $10, $ff, $f3, $d2,
    $cd, $0c, $13, $ec, $5f, $97, $44, $17, $c4, $a7, $7e, $3d, $64, $5d, $19, $73,
    $60, $81, $4f, $dc, $22, $2a, $90, $88, $46, $ee, $b8, $14, $de, $5e, $0b, $db,
    $e0, $32, $3a, $0a, $49, $06, $24, $5c, $c2, $d3, $ac, $62, $91, $95, $e4, $79,
    $e7, $c8, $37, $6d, $8d, $d5, $4e, $a9, $6c, $56, $f4, $ea, $65, $7a, $ae, $08,
    $ba, $78, $25, $2e, $1c, $a6, $b4, $c6, $e8, $dd, $74, $1f, $4b, $bd, $8b, $8a,
    $70, $3e, $b5, $66, $48, $03, $f6, $0e, $61, $35, $57, $b9, $86, $c1, $1d, $9e,
    $e1, $f8, $98, $11, $69, $d9, $8e, $94, $9b, $1e, $87, $e9, $ce, $55, $28, $df,
    $8c, $a1, $89, $0d, $bf, $e6, $42, $68, $41, $99, $2d, $0f, $b0, $54, $bb, $16);

const
  TCe: packed array[0..2047] of byte = (
         $63,$63,$a5,$c6,$63,$63,$a5,$63,$7c,$7c,$84,$f8,$7c,$7c,$84,$7c,
         $77,$77,$99,$ee,$77,$77,$99,$77,$7b,$7b,$8d,$f6,$7b,$7b,$8d,$7b,
         $f2,$f2,$0d,$ff,$f2,$f2,$0d,$f2,$6b,$6b,$bd,$d6,$6b,$6b,$bd,$6b,
         $6f,$6f,$b1,$de,$6f,$6f,$b1,$6f,$c5,$c5,$54,$91,$c5,$c5,$54,$c5,
         $30,$30,$50,$60,$30,$30,$50,$30,$01,$01,$03,$02,$01,$01,$03,$01,
         $67,$67,$a9,$ce,$67,$67,$a9,$67,$2b,$2b,$7d,$56,$2b,$2b,$7d,$2b,
         $fe,$fe,$19,$e7,$fe,$fe,$19,$fe,$d7,$d7,$62,$b5,$d7,$d7,$62,$d7,
         $ab,$ab,$e6,$4d,$ab,$ab,$e6,$ab,$76,$76,$9a,$ec,$76,$76,$9a,$76,
         $ca,$ca,$45,$8f,$ca,$ca,$45,$ca,$82,$82,$9d,$1f,$82,$82,$9d,$82,
         $c9,$c9,$40,$89,$c9,$c9,$40,$c9,$7d,$7d,$87,$fa,$7d,$7d,$87,$7d,
         $fa,$fa,$15,$ef,$fa,$fa,$15,$fa,$59,$59,$eb,$b2,$59,$59,$eb,$59,
         $47,$47,$c9,$8e,$47,$47,$c9,$47,$f0,$f0,$0b,$fb,$f0,$f0,$0b,$f0,
         $ad,$ad,$ec,$41,$ad,$ad,$ec,$ad,$d4,$d4,$67,$b3,$d4,$d4,$67,$d4,
         $a2,$a2,$fd,$5f,$a2,$a2,$fd,$a2,$af,$af,$ea,$45,$af,$af,$ea,$af,
         $9c,$9c,$bf,$23,$9c,$9c,$bf,$9c,$a4,$a4,$f7,$53,$a4,$a4,$f7,$a4,
         $72,$72,$96,$e4,$72,$72,$96,$72,$c0,$c0,$5b,$9b,$c0,$c0,$5b,$c0,
         $b7,$b7,$c2,$75,$b7,$b7,$c2,$b7,$fd,$fd,$1c,$e1,$fd,$fd,$1c,$fd,
         $93,$93,$ae,$3d,$93,$93,$ae,$93,$26,$26,$6a,$4c,$26,$26,$6a,$26,
         $36,$36,$5a,$6c,$36,$36,$5a,$36,$3f,$3f,$41,$7e,$3f,$3f,$41,$3f,
         $f7,$f7,$02,$f5,$f7,$f7,$02,$f7,$cc,$cc,$4f,$83,$cc,$cc,$4f,$cc,
         $34,$34,$5c,$68,$34,$34,$5c,$34,$a5,$a5,$f4,$51,$a5,$a5,$f4,$a5,
         $e5,$e5,$34,$d1,$e5,$e5,$34,$e5,$f1,$f1,$08,$f9,$f1,$f1,$08,$f1,
         $71,$71,$93,$e2,$71,$71,$93,$71,$d8,$d8,$73,$ab,$d8,$d8,$73,$d8,
         $31,$31,$53,$62,$31,$31,$53,$31,$15,$15,$3f,$2a,$15,$15,$3f,$15,
         $04,$04,$0c,$08,$04,$04,$0c,$04,$c7,$c7,$52,$95,$c7,$c7,$52,$c7,
         $23,$23,$65,$46,$23,$23,$65,$23,$c3,$c3,$5e,$9d,$c3,$c3,$5e,$c3,
         $18,$18,$28,$30,$18,$18,$28,$18,$96,$96,$a1,$37,$96,$96,$a1,$96,
         $05,$05,$0f,$0a,$05,$05,$0f,$05,$9a,$9a,$b5,$2f,$9a,$9a,$b5,$9a,
         $07,$07,$09,$0e,$07,$07,$09,$07,$12,$12,$36,$24,$12,$12,$36,$12,
         $80,$80,$9b,$1b,$80,$80,$9b,$80,$e2,$e2,$3d,$df,$e2,$e2,$3d,$e2,
         $eb,$eb,$26,$cd,$eb,$eb,$26,$eb,$27,$27,$69,$4e,$27,$27,$69,$27,
         $b2,$b2,$cd,$7f,$b2,$b2,$cd,$b2,$75,$75,$9f,$ea,$75,$75,$9f,$75,
         $09,$09,$1b,$12,$09,$09,$1b,$09,$83,$83,$9e,$1d,$83,$83,$9e,$83,
         $2c,$2c,$74,$58,$2c,$2c,$74,$2c,$1a,$1a,$2e,$34,$1a,$1a,$2e,$1a,
         $1b,$1b,$2d,$36,$1b,$1b,$2d,$1b,$6e,$6e,$b2,$dc,$6e,$6e,$b2,$6e,
         $5a,$5a,$ee,$b4,$5a,$5a,$ee,$5a,$a0,$a0,$fb,$5b,$a0,$a0,$fb,$a0,
         $52,$52,$f6,$a4,$52,$52,$f6,$52,$3b,$3b,$4d,$76,$3b,$3b,$4d,$3b,
         $d6,$d6,$61,$b7,$d6,$d6,$61,$d6,$b3,$b3,$ce,$7d,$b3,$b3,$ce,$b3,
         $29,$29,$7b,$52,$29,$29,$7b,$29,$e3,$e3,$3e,$dd,$e3,$e3,$3e,$e3,
         $2f,$2f,$71,$5e,$2f,$2f,$71,$2f,$84,$84,$97,$13,$84,$84,$97,$84,
         $53,$53,$f5,$a6,$53,$53,$f5,$53,$d1,$d1,$68,$b9,$d1,$d1,$68,$d1,
         $00,$00,$00,$00,$00,$00,$00,$00,$ed,$ed,$2c,$c1,$ed,$ed,$2c,$ed,
         $20,$20,$60,$40,$20,$20,$60,$20,$fc,$fc,$1f,$e3,$fc,$fc,$1f,$fc,
         $b1,$b1,$c8,$79,$b1,$b1,$c8,$b1,$5b,$5b,$ed,$b6,$5b,$5b,$ed,$5b,
         $6a,$6a,$be,$d4,$6a,$6a,$be,$6a,$cb,$cb,$46,$8d,$cb,$cb,$46,$cb,
         $be,$be,$d9,$67,$be,$be,$d9,$be,$39,$39,$4b,$72,$39,$39,$4b,$39,
         $4a,$4a,$de,$94,$4a,$4a,$de,$4a,$4c,$4c,$d4,$98,$4c,$4c,$d4,$4c,
         $58,$58,$e8,$b0,$58,$58,$e8,$58,$cf,$cf,$4a,$85,$cf,$cf,$4a,$cf,
         $d0,$d0,$6b,$bb,$d0,$d0,$6b,$d0,$ef,$ef,$2a,$c5,$ef,$ef,$2a,$ef,
         $aa,$aa,$e5,$4f,$aa,$aa,$e5,$aa,$fb,$fb,$16,$ed,$fb,$fb,$16,$fb,
         $43,$43,$c5,$86,$43,$43,$c5,$43,$4d,$4d,$d7,$9a,$4d,$4d,$d7,$4d,
         $33,$33,$55,$66,$33,$33,$55,$33,$85,$85,$94,$11,$85,$85,$94,$85,
         $45,$45,$cf,$8a,$45,$45,$cf,$45,$f9,$f9,$10,$e9,$f9,$f9,$10,$f9,
         $02,$02,$06,$04,$02,$02,$06,$02,$7f,$7f,$81,$fe,$7f,$7f,$81,$7f,
         $50,$50,$f0,$a0,$50,$50,$f0,$50,$3c,$3c,$44,$78,$3c,$3c,$44,$3c,
         $9f,$9f,$ba,$25,$9f,$9f,$ba,$9f,$a8,$a8,$e3,$4b,$a8,$a8,$e3,$a8,
         $51,$51,$f3,$a2,$51,$51,$f3,$51,$a3,$a3,$fe,$5d,$a3,$a3,$fe,$a3,
         $40,$40,$c0,$80,$40,$40,$c0,$40,$8f,$8f,$8a,$05,$8f,$8f,$8a,$8f,
         $92,$92,$ad,$3f,$92,$92,$ad,$92,$9d,$9d,$bc,$21,$9d,$9d,$bc,$9d,
         $38,$38,$48,$70,$38,$38,$48,$38,$f5,$f5,$04,$f1,$f5,$f5,$04,$f5,
         $bc,$bc,$df,$63,$bc,$bc,$df,$bc,$b6,$b6,$c1,$77,$b6,$b6,$c1,$b6,
         $da,$da,$75,$af,$da,$da,$75,$da,$21,$21,$63,$42,$21,$21,$63,$21,
         $10,$10,$30,$20,$10,$10,$30,$10,$ff,$ff,$1a,$e5,$ff,$ff,$1a,$ff,
         $f3,$f3,$0e,$fd,$f3,$f3,$0e,$f3,$d2,$d2,$6d,$bf,$d2,$d2,$6d,$d2,
         $cd,$cd,$4c,$81,$cd,$cd,$4c,$cd,$0c,$0c,$14,$18,$0c,$0c,$14,$0c,
         $13,$13,$35,$26,$13,$13,$35,$13,$ec,$ec,$2f,$c3,$ec,$ec,$2f,$ec,
         $5f,$5f,$e1,$be,$5f,$5f,$e1,$5f,$97,$97,$a2,$35,$97,$97,$a2,$97,
         $44,$44,$cc,$88,$44,$44,$cc,$44,$17,$17,$39,$2e,$17,$17,$39,$17,
         $c4,$c4,$57,$93,$c4,$c4,$57,$c4,$a7,$a7,$f2,$55,$a7,$a7,$f2,$a7,
         $7e,$7e,$82,$fc,$7e,$7e,$82,$7e,$3d,$3d,$47,$7a,$3d,$3d,$47,$3d,
         $64,$64,$ac,$c8,$64,$64,$ac,$64,$5d,$5d,$e7,$ba,$5d,$5d,$e7,$5d,
         $19,$19,$2b,$32,$19,$19,$2b,$19,$73,$73,$95,$e6,$73,$73,$95,$73,
         $60,$60,$a0,$c0,$60,$60,$a0,$60,$81,$81,$98,$19,$81,$81,$98,$81,
         $4f,$4f,$d1,$9e,$4f,$4f,$d1,$4f,$dc,$dc,$7f,$a3,$dc,$dc,$7f,$dc,
         $22,$22,$66,$44,$22,$22,$66,$22,$2a,$2a,$7e,$54,$2a,$2a,$7e,$2a,
         $90,$90,$ab,$3b,$90,$90,$ab,$90,$88,$88,$83,$0b,$88,$88,$83,$88,
         $46,$46,$ca,$8c,$46,$46,$ca,$46,$ee,$ee,$29,$c7,$ee,$ee,$29,$ee,
         $b8,$b8,$d3,$6b,$b8,$b8,$d3,$b8,$14,$14,$3c,$28,$14,$14,$3c,$14,
         $de,$de,$79,$a7,$de,$de,$79,$de,$5e,$5e,$e2,$bc,$5e,$5e,$e2,$5e,
         $0b,$0b,$1d,$16,$0b,$0b,$1d,$0b,$db,$db,$76,$ad,$db,$db,$76,$db,
         $e0,$e0,$3b,$db,$e0,$e0,$3b,$e0,$32,$32,$56,$64,$32,$32,$56,$32,
         $3a,$3a,$4e,$74,$3a,$3a,$4e,$3a,$0a,$0a,$1e,$14,$0a,$0a,$1e,$0a,
         $49,$49,$db,$92,$49,$49,$db,$49,$06,$06,$0a,$0c,$06,$06,$0a,$06,
         $24,$24,$6c,$48,$24,$24,$6c,$24,$5c,$5c,$e4,$b8,$5c,$5c,$e4,$5c,
         $c2,$c2,$5d,$9f,$c2,$c2,$5d,$c2,$d3,$d3,$6e,$bd,$d3,$d3,$6e,$d3,
         $ac,$ac,$ef,$43,$ac,$ac,$ef,$ac,$62,$62,$a6,$c4,$62,$62,$a6,$62,
         $91,$91,$a8,$39,$91,$91,$a8,$91,$95,$95,$a4,$31,$95,$95,$a4,$95,
         $e4,$e4,$37,$d3,$e4,$e4,$37,$e4,$79,$79,$8b,$f2,$79,$79,$8b,$79,
         $e7,$e7,$32,$d5,$e7,$e7,$32,$e7,$c8,$c8,$43,$8b,$c8,$c8,$43,$c8,
         $37,$37,$59,$6e,$37,$37,$59,$37,$6d,$6d,$b7,$da,$6d,$6d,$b7,$6d,
         $8d,$8d,$8c,$01,$8d,$8d,$8c,$8d,$d5,$d5,$64,$b1,$d5,$d5,$64,$d5,
         $4e,$4e,$d2,$9c,$4e,$4e,$d2,$4e,$a9,$a9,$e0,$49,$a9,$a9,$e0,$a9,
         $6c,$6c,$b4,$d8,$6c,$6c,$b4,$6c,$56,$56,$fa,$ac,$56,$56,$fa,$56,
         $f4,$f4,$07,$f3,$f4,$f4,$07,$f4,$ea,$ea,$25,$cf,$ea,$ea,$25,$ea,
         $65,$65,$af,$ca,$65,$65,$af,$65,$7a,$7a,$8e,$f4,$7a,$7a,$8e,$7a,
         $ae,$ae,$e9,$47,$ae,$ae,$e9,$ae,$08,$08,$18,$10,$08,$08,$18,$08,
         $ba,$ba,$d5,$6f,$ba,$ba,$d5,$ba,$78,$78,$88,$f0,$78,$78,$88,$78,
         $25,$25,$6f,$4a,$25,$25,$6f,$25,$2e,$2e,$72,$5c,$2e,$2e,$72,$2e,
         $1c,$1c,$24,$38,$1c,$1c,$24,$1c,$a6,$a6,$f1,$57,$a6,$a6,$f1,$a6,
         $b4,$b4,$c7,$73,$b4,$b4,$c7,$b4,$c6,$c6,$51,$97,$c6,$c6,$51,$c6,
         $e8,$e8,$23,$cb,$e8,$e8,$23,$e8,$dd,$dd,$7c,$a1,$dd,$dd,$7c,$dd,
         $74,$74,$9c,$e8,$74,$74,$9c,$74,$1f,$1f,$21,$3e,$1f,$1f,$21,$1f,
         $4b,$4b,$dd,$96,$4b,$4b,$dd,$4b,$bd,$bd,$dc,$61,$bd,$bd,$dc,$bd,
         $8b,$8b,$86,$0d,$8b,$8b,$86,$8b,$8a,$8a,$85,$0f,$8a,$8a,$85,$8a,
         $70,$70,$90,$e0,$70,$70,$90,$70,$3e,$3e,$42,$7c,$3e,$3e,$42,$3e,
         $b5,$b5,$c4,$71,$b5,$b5,$c4,$b5,$66,$66,$aa,$cc,$66,$66,$aa,$66,
         $48,$48,$d8,$90,$48,$48,$d8,$48,$03,$03,$05,$06,$03,$03,$05,$03,
         $f6,$f6,$01,$f7,$f6,$f6,$01,$f6,$0e,$0e,$12,$1c,$0e,$0e,$12,$0e,
         $61,$61,$a3,$c2,$61,$61,$a3,$61,$35,$35,$5f,$6a,$35,$35,$5f,$35,
         $57,$57,$f9,$ae,$57,$57,$f9,$57,$b9,$b9,$d0,$69,$b9,$b9,$d0,$b9,
         $86,$86,$91,$17,$86,$86,$91,$86,$c1,$c1,$58,$99,$c1,$c1,$58,$c1,
         $1d,$1d,$27,$3a,$1d,$1d,$27,$1d,$9e,$9e,$b9,$27,$9e,$9e,$b9,$9e,
         $e1,$e1,$38,$d9,$e1,$e1,$38,$e1,$f8,$f8,$13,$eb,$f8,$f8,$13,$f8,
         $98,$98,$b3,$2b,$98,$98,$b3,$98,$11,$11,$33,$22,$11,$11,$33,$11,
         $69,$69,$bb,$d2,$69,$69,$bb,$69,$d9,$d9,$70,$a9,$d9,$d9,$70,$d9,
         $8e,$8e,$89,$07,$8e,$8e,$89,$8e,$94,$94,$a7,$33,$94,$94,$a7,$94,
         $9b,$9b,$b6,$2d,$9b,$9b,$b6,$9b,$1e,$1e,$22,$3c,$1e,$1e,$22,$1e,
         $87,$87,$92,$15,$87,$87,$92,$87,$e9,$e9,$20,$c9,$e9,$e9,$20,$e9,
         $ce,$ce,$49,$87,$ce,$ce,$49,$ce,$55,$55,$ff,$aa,$55,$55,$ff,$55,
         $28,$28,$78,$50,$28,$28,$78,$28,$df,$df,$7a,$a5,$df,$df,$7a,$df,
         $8c,$8c,$8f,$03,$8c,$8c,$8f,$8c,$a1,$a1,$f8,$59,$a1,$a1,$f8,$a1,
         $89,$89,$80,$09,$89,$89,$80,$89,$0d,$0d,$17,$1a,$0d,$0d,$17,$0d,
         $bf,$bf,$da,$65,$bf,$bf,$da,$bf,$e6,$e6,$31,$d7,$e6,$e6,$31,$e6,
         $42,$42,$c6,$84,$42,$42,$c6,$42,$68,$68,$b8,$d0,$68,$68,$b8,$68,
         $41,$41,$c3,$82,$41,$41,$c3,$41,$99,$99,$b0,$29,$99,$99,$b0,$99,
         $2d,$2d,$77,$5a,$2d,$2d,$77,$2d,$0f,$0f,$11,$1e,$0f,$0f,$11,$0f,
         $b0,$b0,$cb,$7b,$b0,$b0,$cb,$b0,$54,$54,$fc,$a8,$54,$54,$fc,$54,
         $bb,$bb,$d6,$6d,$bb,$bb,$d6,$bb,$16,$16,$3a,$2c,$16,$16,$3a,$16);

  TCd: packed array[0..2047] of byte = (
         $f4,$a7,$50,$51,$f4,$a7,$50,$52,$41,$65,$53,$7e,$41,$65,$53,$09,
         $17,$a4,$c3,$1a,$17,$a4,$c3,$6a,$27,$5e,$96,$3a,$27,$5e,$96,$d5,
         $ab,$6b,$cb,$3b,$ab,$6b,$cb,$30,$9d,$45,$f1,$1f,$9d,$45,$f1,$36,
         $fa,$58,$ab,$ac,$fa,$58,$ab,$a5,$e3,$03,$93,$4b,$e3,$03,$93,$38,
         $30,$fa,$55,$20,$30,$fa,$55,$bf,$76,$6d,$f6,$ad,$76,$6d,$f6,$40,
         $cc,$76,$91,$88,$cc,$76,$91,$a3,$02,$4c,$25,$f5,$02,$4c,$25,$9e,
         $e5,$d7,$fc,$4f,$e5,$d7,$fc,$81,$2a,$cb,$d7,$c5,$2a,$cb,$d7,$f3,
         $35,$44,$80,$26,$35,$44,$80,$d7,$62,$a3,$8f,$b5,$62,$a3,$8f,$fb,
         $b1,$5a,$49,$de,$b1,$5a,$49,$7c,$ba,$1b,$67,$25,$ba,$1b,$67,$e3,
         $ea,$0e,$98,$45,$ea,$0e,$98,$39,$fe,$c0,$e1,$5d,$fe,$c0,$e1,$82,
         $2f,$75,$02,$c3,$2f,$75,$02,$9b,$4c,$f0,$12,$81,$4c,$f0,$12,$2f,
         $46,$97,$a3,$8d,$46,$97,$a3,$ff,$d3,$f9,$c6,$6b,$d3,$f9,$c6,$87,
         $8f,$5f,$e7,$03,$8f,$5f,$e7,$34,$92,$9c,$95,$15,$92,$9c,$95,$8e,
         $6d,$7a,$eb,$bf,$6d,$7a,$eb,$43,$52,$59,$da,$95,$52,$59,$da,$44,
         $be,$83,$2d,$d4,$be,$83,$2d,$c4,$74,$21,$d3,$58,$74,$21,$d3,$de,
         $e0,$69,$29,$49,$e0,$69,$29,$e9,$c9,$c8,$44,$8e,$c9,$c8,$44,$cb,
         $c2,$89,$6a,$75,$c2,$89,$6a,$54,$8e,$79,$78,$f4,$8e,$79,$78,$7b,
         $58,$3e,$6b,$99,$58,$3e,$6b,$94,$b9,$71,$dd,$27,$b9,$71,$dd,$32,
         $e1,$4f,$b6,$be,$e1,$4f,$b6,$a6,$88,$ad,$17,$f0,$88,$ad,$17,$c2,
         $20,$ac,$66,$c9,$20,$ac,$66,$23,$ce,$3a,$b4,$7d,$ce,$3a,$b4,$3d,
         $df,$4a,$18,$63,$df,$4a,$18,$ee,$1a,$31,$82,$e5,$1a,$31,$82,$4c,
         $51,$33,$60,$97,$51,$33,$60,$95,$53,$7f,$45,$62,$53,$7f,$45,$0b,
         $64,$77,$e0,$b1,$64,$77,$e0,$42,$6b,$ae,$84,$bb,$6b,$ae,$84,$fa,
         $81,$a0,$1c,$fe,$81,$a0,$1c,$c3,$08,$2b,$94,$f9,$08,$2b,$94,$4e,
         $48,$68,$58,$70,$48,$68,$58,$08,$45,$fd,$19,$8f,$45,$fd,$19,$2e,
         $de,$6c,$87,$94,$de,$6c,$87,$a1,$7b,$f8,$b7,$52,$7b,$f8,$b7,$66,
         $73,$d3,$23,$ab,$73,$d3,$23,$28,$4b,$02,$e2,$72,$4b,$02,$e2,$d9,
         $1f,$8f,$57,$e3,$1f,$8f,$57,$24,$55,$ab,$2a,$66,$55,$ab,$2a,$b2,
         $eb,$28,$07,$b2,$eb,$28,$07,$76,$b5,$c2,$03,$2f,$b5,$c2,$03,$5b,
         $c5,$7b,$9a,$86,$c5,$7b,$9a,$a2,$37,$08,$a5,$d3,$37,$08,$a5,$49,
         $28,$87,$f2,$30,$28,$87,$f2,$6d,$bf,$a5,$b2,$23,$bf,$a5,$b2,$8b,
         $03,$6a,$ba,$02,$03,$6a,$ba,$d1,$16,$82,$5c,$ed,$16,$82,$5c,$25,
         $cf,$1c,$2b,$8a,$cf,$1c,$2b,$72,$79,$b4,$92,$a7,$79,$b4,$92,$f8,
         $07,$f2,$f0,$f3,$07,$f2,$f0,$f6,$69,$e2,$a1,$4e,$69,$e2,$a1,$64,
         $da,$f4,$cd,$65,$da,$f4,$cd,$86,$05,$be,$d5,$06,$05,$be,$d5,$68,
         $34,$62,$1f,$d1,$34,$62,$1f,$98,$a6,$fe,$8a,$c4,$a6,$fe,$8a,$16,
         $2e,$53,$9d,$34,$2e,$53,$9d,$d4,$f3,$55,$a0,$a2,$f3,$55,$a0,$a4,
         $8a,$e1,$32,$05,$8a,$e1,$32,$5c,$f6,$eb,$75,$a4,$f6,$eb,$75,$cc,
         $83,$ec,$39,$0b,$83,$ec,$39,$5d,$60,$ef,$aa,$40,$60,$ef,$aa,$65,
         $71,$9f,$06,$5e,$71,$9f,$06,$b6,$6e,$10,$51,$bd,$6e,$10,$51,$92,
         $21,$8a,$f9,$3e,$21,$8a,$f9,$6c,$dd,$06,$3d,$96,$dd,$06,$3d,$70,
         $3e,$05,$ae,$dd,$3e,$05,$ae,$48,$e6,$bd,$46,$4d,$e6,$bd,$46,$50,
         $54,$8d,$b5,$91,$54,$8d,$b5,$fd,$c4,$5d,$05,$71,$c4,$5d,$05,$ed,
         $06,$d4,$6f,$04,$06,$d4,$6f,$b9,$50,$15,$ff,$60,$50,$15,$ff,$da,
         $98,$fb,$24,$19,$98,$fb,$24,$5e,$bd,$e9,$97,$d6,$bd,$e9,$97,$15,
         $40,$43,$cc,$89,$40,$43,$cc,$46,$d9,$9e,$77,$67,$d9,$9e,$77,$57,
         $e8,$42,$bd,$b0,$e8,$42,$bd,$a7,$89,$8b,$88,$07,$89,$8b,$88,$8d,
         $19,$5b,$38,$e7,$19,$5b,$38,$9d,$c8,$ee,$db,$79,$c8,$ee,$db,$84,
         $7c,$0a,$47,$a1,$7c,$0a,$47,$90,$42,$0f,$e9,$7c,$42,$0f,$e9,$d8,
         $84,$1e,$c9,$f8,$84,$1e,$c9,$ab,$00,$00,$00,$00,$00,$00,$00,$00,
         $80,$86,$83,$09,$80,$86,$83,$8c,$2b,$ed,$48,$32,$2b,$ed,$48,$bc,
         $11,$70,$ac,$1e,$11,$70,$ac,$d3,$5a,$72,$4e,$6c,$5a,$72,$4e,$0a,
         $0e,$ff,$fb,$fd,$0e,$ff,$fb,$f7,$85,$38,$56,$0f,$85,$38,$56,$e4,
         $ae,$d5,$1e,$3d,$ae,$d5,$1e,$58,$2d,$39,$27,$36,$2d,$39,$27,$05,
         $0f,$d9,$64,$0a,$0f,$d9,$64,$b8,$5c,$a6,$21,$68,$5c,$a6,$21,$b3,
         $5b,$54,$d1,$9b,$5b,$54,$d1,$45,$36,$2e,$3a,$24,$36,$2e,$3a,$06,
         $0a,$67,$b1,$0c,$0a,$67,$b1,$d0,$57,$e7,$0f,$93,$57,$e7,$0f,$2c,
         $ee,$96,$d2,$b4,$ee,$96,$d2,$1e,$9b,$91,$9e,$1b,$9b,$91,$9e,$8f,
         $c0,$c5,$4f,$80,$c0,$c5,$4f,$ca,$dc,$20,$a2,$61,$dc,$20,$a2,$3f,
         $77,$4b,$69,$5a,$77,$4b,$69,$0f,$12,$1a,$16,$1c,$12,$1a,$16,$02,
         $93,$ba,$0a,$e2,$93,$ba,$0a,$c1,$a0,$2a,$e5,$c0,$a0,$2a,$e5,$af,
         $22,$e0,$43,$3c,$22,$e0,$43,$bd,$1b,$17,$1d,$12,$1b,$17,$1d,$03,
         $09,$0d,$0b,$0e,$09,$0d,$0b,$01,$8b,$c7,$ad,$f2,$8b,$c7,$ad,$13,
         $b6,$a8,$b9,$2d,$b6,$a8,$b9,$8a,$1e,$a9,$c8,$14,$1e,$a9,$c8,$6b,
         $f1,$19,$85,$57,$f1,$19,$85,$3a,$75,$07,$4c,$af,$75,$07,$4c,$91,
         $99,$dd,$bb,$ee,$99,$dd,$bb,$11,$7f,$60,$fd,$a3,$7f,$60,$fd,$41,
         $01,$26,$9f,$f7,$01,$26,$9f,$4f,$72,$f5,$bc,$5c,$72,$f5,$bc,$67,
         $66,$3b,$c5,$44,$66,$3b,$c5,$dc,$fb,$7e,$34,$5b,$fb,$7e,$34,$ea,
         $43,$29,$76,$8b,$43,$29,$76,$97,$23,$c6,$dc,$cb,$23,$c6,$dc,$f2,
         $ed,$fc,$68,$b6,$ed,$fc,$68,$cf,$e4,$f1,$63,$b8,$e4,$f1,$63,$ce,
         $31,$dc,$ca,$d7,$31,$dc,$ca,$f0,$63,$85,$10,$42,$63,$85,$10,$b4,
         $97,$22,$40,$13,$97,$22,$40,$e6,$c6,$11,$20,$84,$c6,$11,$20,$73,
         $4a,$24,$7d,$85,$4a,$24,$7d,$96,$bb,$3d,$f8,$d2,$bb,$3d,$f8,$ac,
         $f9,$32,$11,$ae,$f9,$32,$11,$74,$29,$a1,$6d,$c7,$29,$a1,$6d,$22,
         $9e,$2f,$4b,$1d,$9e,$2f,$4b,$e7,$b2,$30,$f3,$dc,$b2,$30,$f3,$ad,
         $86,$52,$ec,$0d,$86,$52,$ec,$35,$c1,$e3,$d0,$77,$c1,$e3,$d0,$85,
         $b3,$16,$6c,$2b,$b3,$16,$6c,$e2,$70,$b9,$99,$a9,$70,$b9,$99,$f9,
         $94,$48,$fa,$11,$94,$48,$fa,$37,$e9,$64,$22,$47,$e9,$64,$22,$e8,
         $fc,$8c,$c4,$a8,$fc,$8c,$c4,$1c,$f0,$3f,$1a,$a0,$f0,$3f,$1a,$75,
         $7d,$2c,$d8,$56,$7d,$2c,$d8,$df,$33,$90,$ef,$22,$33,$90,$ef,$6e,
         $49,$4e,$c7,$87,$49,$4e,$c7,$47,$38,$d1,$c1,$d9,$38,$d1,$c1,$f1,
         $ca,$a2,$fe,$8c,$ca,$a2,$fe,$1a,$d4,$0b,$36,$98,$d4,$0b,$36,$71,
         $f5,$81,$cf,$a6,$f5,$81,$cf,$1d,$7a,$de,$28,$a5,$7a,$de,$28,$29,
         $b7,$8e,$26,$da,$b7,$8e,$26,$c5,$ad,$bf,$a4,$3f,$ad,$bf,$a4,$89,
         $3a,$9d,$e4,$2c,$3a,$9d,$e4,$6f,$78,$92,$0d,$50,$78,$92,$0d,$b7,
         $5f,$cc,$9b,$6a,$5f,$cc,$9b,$62,$7e,$46,$62,$54,$7e,$46,$62,$0e,
         $8d,$13,$c2,$f6,$8d,$13,$c2,$aa,$d8,$b8,$e8,$90,$d8,$b8,$e8,$18,
         $39,$f7,$5e,$2e,$39,$f7,$5e,$be,$c3,$af,$f5,$82,$c3,$af,$f5,$1b,
         $5d,$80,$be,$9f,$5d,$80,$be,$fc,$d0,$93,$7c,$69,$d0,$93,$7c,$56,
         $d5,$2d,$a9,$6f,$d5,$2d,$a9,$3e,$25,$12,$b3,$cf,$25,$12,$b3,$4b,
         $ac,$99,$3b,$c8,$ac,$99,$3b,$c6,$18,$7d,$a7,$10,$18,$7d,$a7,$d2,
         $9c,$63,$6e,$e8,$9c,$63,$6e,$79,$3b,$bb,$7b,$db,$3b,$bb,$7b,$20,
         $26,$78,$09,$cd,$26,$78,$09,$9a,$59,$18,$f4,$6e,$59,$18,$f4,$db,
         $9a,$b7,$01,$ec,$9a,$b7,$01,$c0,$4f,$9a,$a8,$83,$4f,$9a,$a8,$fe,
         $95,$6e,$65,$e6,$95,$6e,$65,$78,$ff,$e6,$7e,$aa,$ff,$e6,$7e,$cd,
         $bc,$cf,$08,$21,$bc,$cf,$08,$5a,$15,$e8,$e6,$ef,$15,$e8,$e6,$f4,
         $e7,$9b,$d9,$ba,$e7,$9b,$d9,$1f,$6f,$36,$ce,$4a,$6f,$36,$ce,$dd,
         $9f,$09,$d4,$ea,$9f,$09,$d4,$a8,$b0,$7c,$d6,$29,$b0,$7c,$d6,$33,
         $a4,$b2,$af,$31,$a4,$b2,$af,$88,$3f,$23,$31,$2a,$3f,$23,$31,$07,
         $a5,$94,$30,$c6,$a5,$94,$30,$c7,$a2,$66,$c0,$35,$a2,$66,$c0,$31,
         $4e,$bc,$37,$74,$4e,$bc,$37,$b1,$82,$ca,$a6,$fc,$82,$ca,$a6,$12,
         $90,$d0,$b0,$e0,$90,$d0,$b0,$10,$a7,$d8,$15,$33,$a7,$d8,$15,$59,
         $04,$98,$4a,$f1,$04,$98,$4a,$27,$ec,$da,$f7,$41,$ec,$da,$f7,$80,
         $cd,$50,$0e,$7f,$cd,$50,$0e,$ec,$91,$f6,$2f,$17,$91,$f6,$2f,$5f,
         $4d,$d6,$8d,$76,$4d,$d6,$8d,$60,$ef,$b0,$4d,$43,$ef,$b0,$4d,$51,
         $aa,$4d,$54,$cc,$aa,$4d,$54,$7f,$96,$04,$df,$e4,$96,$04,$df,$a9,
         $d1,$b5,$e3,$9e,$d1,$b5,$e3,$19,$6a,$88,$1b,$4c,$6a,$88,$1b,$b5,
         $2c,$1f,$b8,$c1,$2c,$1f,$b8,$4a,$65,$51,$7f,$46,$65,$51,$7f,$0d,
         $5e,$ea,$04,$9d,$5e,$ea,$04,$2d,$8c,$35,$5d,$01,$8c,$35,$5d,$e5,
         $87,$74,$73,$fa,$87,$74,$73,$7a,$0b,$41,$2e,$fb,$0b,$41,$2e,$9f,
         $67,$1d,$5a,$b3,$67,$1d,$5a,$93,$db,$d2,$52,$92,$db,$d2,$52,$c9,
         $10,$56,$33,$e9,$10,$56,$33,$9c,$d6,$47,$13,$6d,$d6,$47,$13,$ef,
         $d7,$61,$8c,$9a,$d7,$61,$8c,$a0,$a1,$0c,$7a,$37,$a1,$0c,$7a,$e0,
         $f8,$14,$8e,$59,$f8,$14,$8e,$3b,$13,$3c,$89,$eb,$13,$3c,$89,$4d,
         $a9,$27,$ee,$ce,$a9,$27,$ee,$ae,$61,$c9,$35,$b7,$61,$c9,$35,$2a,
         $1c,$e5,$ed,$e1,$1c,$e5,$ed,$f5,$47,$b1,$3c,$7a,$47,$b1,$3c,$b0,
         $d2,$df,$59,$9c,$d2,$df,$59,$c8,$f2,$73,$3f,$55,$f2,$73,$3f,$eb,
         $14,$ce,$79,$18,$14,$ce,$79,$bb,$c7,$37,$bf,$73,$c7,$37,$bf,$3c,
         $f7,$cd,$ea,$53,$f7,$cd,$ea,$83,$fd,$aa,$5b,$5f,$fd,$aa,$5b,$53,
         $3d,$6f,$14,$df,$3d,$6f,$14,$99,$44,$db,$86,$78,$44,$db,$86,$61,
         $af,$f3,$81,$ca,$af,$f3,$81,$17,$68,$c4,$3e,$b9,$68,$c4,$3e,$2b,
         $24,$34,$2c,$38,$24,$34,$2c,$04,$a3,$40,$5f,$c2,$a3,$40,$5f,$7e,
         $1d,$c3,$72,$16,$1d,$c3,$72,$ba,$e2,$25,$0c,$bc,$e2,$25,$0c,$77,
         $3c,$49,$8b,$28,$3c,$49,$8b,$d6,$0d,$95,$41,$ff,$0d,$95,$41,$26,
         $a8,$01,$71,$39,$a8,$01,$71,$e1,$0c,$b3,$de,$08,$0c,$b3,$de,$69,
         $b4,$e4,$9c,$d8,$b4,$e4,$9c,$14,$56,$c1,$90,$64,$56,$c1,$90,$63,
         $cb,$84,$61,$7b,$cb,$84,$61,$55,$32,$b6,$70,$d5,$32,$b6,$70,$21,
         $6c,$5c,$74,$48,$6c,$5c,$74,$0c,$b8,$57,$42,$d0,$b8,$57,$42,$7d);

const
  RCon: array[0..9] of longint= ($01,$02,$04,$08,$10,$20,$40,$80,$1b,$36);


type
     RSAPUBLICKEY_BLOB = record
	    publicKeyStruc : PUBLICKEYSTRUC; (*< The blob header.*)
	    rsaPubKey      : RSAPUBKEY;      (*< The rsa public key description.*)
	    modulus        : array of Byte;       (*< The key modulus.*)
     end;

     TAESBlock   = packed array[0..15] of byte;
     TKeyArray   = packed array[0..AESMaxRounds] of TAESBlock;
     TIncProc    = procedure(var CTR: TAESBlock);   {user supplied IncCTR proc}
     TAESContext = packed record
                  RK      : TKeyArray;  {Key (encr. or decr.)   }
                  IV      : TAESBlock;  {IV or CTR              }
                  buf     : TAESBlock;  {Work buffer            }
                  bLen    : word;       {Bytes used in buf      }
                  Rounds  : word;       {Number of rounds       }
                  KeyBits : word;       {Number of bits in key  }
                  Decrypt : byte;       {<>0 if decrypting key  }
                  Flag    : byte;       {Bit 1: Short block     }
                  IncProc : TIncProc;   {Increment proc CTR-Mode}
                end;
     TAWk  = packed array[0..4*(AESMaxRounds+1)-1] of longint; {Key as array of longint}
     TBA4  = packed array[0..3] of byte;         {AES "word" as array of byte  }

     TH3 = packed record
          L: longint;
          b0,b1,b2,box: byte;
        end;

     TH2 = packed record
          b0: byte;
          L: longint;
          b1,b2,box: byte;
        end;

     TH1 = packed record
          b0,b1: byte;
          L: longint;
          b2,box: byte;
        end;

     TH0 = packed record
          b0,b1,b2: byte;
          L: longint;
          box: byte;
        end;

     TDU = record
          case integer of
            0: (D0: TH0);
            1: (D1: TH1);
            2: (D2: TH2);
            3: (D3: TH3);
          end;

     TWA4  = packed array[0..3] of longint;      {AES block as array of longint}
     PAESBlock   = ^TAESBlock;
     PWA4  = ^TWA4;

     TEU = record
          case integer of
            0: (E0: TH0);
            1: (E1: TH1);
            2: (E2: TH2);
            3: (E3: TH3);
          end;

     function AES_CBC_Init_Encr(var Key; KeyBits: word; var IV: TAESBlock; var ctx: TAESContext): integer;
     function AES_Init_Decr(var Key; KeyBits: word; var ctx: TAESContext): integer;
     function AES_CBC_Decrypt(ctp, ptp: Pointer; ILen: word; var ctx: TAESContext): integer;
     function AES_CBC_Encrypt(ptp, ctp: Pointer; ILen: word; var ctx: TAESContext): integer;
     function AES_CBC_Init_Decr(var Key; KeyBits: word; var IV: TAESBlock; var ctx: TAESContext): integer;
     function ReadHex4(var buf : array of Byte; offs : Integer) : Integer;
     procedure MakeXKey(var orig_key : array of Byte; var new_key : array of Byte);
     procedure PutHex4(var buf : array of Byte; offs : Integer; value : Integer);
     procedure MakeSign(var hash : array of Byte; var RSA_PubMod : array of Byte; var RSA_Priv : array of Byte; var signature : array of Byte);
     function VerifySign(var hash : array of Byte; exp : Integer; var RSA_PubMod : array of Byte; var signature : array of Byte) : Boolean;

implementation

const
     AESBLKSIZE = sizeof(TAESBlock);

var
     Td: packed array[byte] of TDU absolute TCd;
     Te: array[byte] of TEU absolute TCe;
     
procedure MakeDecrKey(var ctx: TAESContext);
  {-Calculate decryption key from encryption key}
var
  i,j: integer;
  x: longint;
  t: TBA4 absolute x;
begin
  with ctx do begin
    i:=0;
    j:=Rounds*4;
    repeat

      Inc(i,4);
      Dec(j,4);
    until i >= j;

    for i:=4 to 4*Rounds-1 do begin
      {Inverse MixColumns transformation: use Sbox and}
      {implicit endian conversion compared with [2]   }
      x := TAWK(RK)[i];
      TAWK(RK)[i] := Td[SBox[t[3]]].D3.L xor Td[SBox[t[2]]].D2.L xor Td[SBox[t[1]]].D1.L xor Td[SBox[t[0]]].D0.L;
    end;
  end;
end;

procedure AES_XorBlock(var B1, B2: TAESBlock; var B3: TAESBlock);
  {-xor two blocks, result in third}
var
  a1: TWA4 absolute B1;
  a2: TWA4 absolute B2;
  a3: TWA4 absolute B3;
begin
  a3[0] := a1[0] xor a2[0];
  a3[1] := a1[1] xor a2[1];
  a3[2] := a1[2] xor a2[2];
  a3[3] := a1[3] xor a2[3];
end;

function AES_Init(var Key; KeyBits: word; var ctx: TAESContext): integer;
  {-AES key expansion, error if invalid key size}
var
  pK: ^TAWK;
  i : integer;
  temp: longint;
  {$ifdef BIT16}
    s: TBA4;
    t: TBA4 absolute temp;
  {$endif}
  Nk: word;
begin
  AES_Init := 0;

  fillchar(ctx, sizeof(ctx), 0);

  if (KeyBits<>128) and (KeyBits<>192) and (KeyBits<>256) then begin
    AES_Init := AES_Err_Invalid_Key_Size;
    exit;
  end;

  Nk := KeyBits div 32;
  Move(Key, ctx.RK, 4*Nk);

  ctx.KeyBits := KeyBits;
  ctx.Rounds  := 6 + Nk;
  ctx.Decrypt := 0;

  {Calculate encryption round keys, cf.[2]}
  pK := addr(ctx.RK);

  {32 bit use shift and mask}
  if keybits=128 then begin
    for i:=0 to 9 do begin
      temp := pK^[3];
      {SubWord(RotWord(temp)) if "word" count mod 4 = 0}
      pK^[4] := (longint(SBox[(temp shr  8) and $ff])       ) xor
                (longint(SBox[(temp shr 16) and $ff]) shl  8) xor
                (longint(SBox[(temp shr 24)        ]) shl 16) xor
                (longint(SBox[(temp       ) and $ff]) shl 24) xor
                pK^[0] xor RCon[i];
      pK^[5] := pK^[1] xor pK^[4];
      pK^[6] := pK^[2] xor pK^[5];
      pK^[7] := pK^[3] xor pK^[6];
      pK := addr(pK^[4]);
    end;
  end
  else if keybits=192 then begin
    for i:=0 to 7 do begin
      temp := pK^[5];
      {SubWord(RotWord(temp)) if "word" count mod 6 = 0}
      pK^[ 6] := (longint(SBox[(temp shr  8) and $ff])       ) xor
                 (longint(SBox[(temp shr 16) and $ff]) shl  8) xor
                 (longint(SBox[(temp shr 24)        ]) shl 16) xor
                 (longint(SBox[(temp       ) and $ff]) shl 24) xor
                 pK^[0] xor RCon[i];
      pK^[ 7] := pK^[1] xor pK^[6];
      pK^[ 8] := pK^[2] xor pK^[7];
      pK^[ 9] := pK^[3] xor pK^[8];
      if i=7 then exit;
      pK^[10] := pK^[4] xor pK^[ 9];
      pK^[11] := pK^[5] xor pK^[10];
      pK := addr(pK^[6]);
    end;
  end
  else begin
    for i:=0 to 6 do begin
      temp := pK^[7];
      {SubWord(RotWord(temp)) if "word" count mod 8 = 0}
      pK^[ 8] := (longint(SBox[(temp shr  8) and $ff])       ) xor
                 (longint(SBox[(temp shr 16) and $ff]) shl  8) xor
                 (longint(SBox[(temp shr 24)        ]) shl 16) xor
                 (longint(SBox[(temp       ) and $ff]) shl 24) xor
                 pK^[0] xor RCon[i];
      pK^[ 9] := pK^[1] xor pK^[ 8];
      pK^[10] := pK^[2] xor pK^[ 9];
      pK^[11] := pK^[3] xor pK^[10];
      if i=6 then exit;
      temp := pK^[11];
      {SubWord(temp) if "word" count mod 8 = 4}
      pK^[12] := (longint(SBox[(temp       ) and $ff])       ) xor
                 (longint(SBox[(temp shr  8) and $ff]) shl  8) xor
                 (longint(SBox[(temp shr 16) and $ff]) shl 16) xor
                 (longint(SBox[(temp shr 24)        ]) shl 24) xor
                 pK^[4];
      pK^[13] := pK^[5] xor pK^[12];
      pK^[14] := pK^[6] xor pK^[13];
      pK^[15] := pK^[7] xor pK^[14];
      pK := addr(pK^[8]);
    end;
  end;
end;

function AES_CBC_Init_Encr(var Key; KeyBits: word; var IV: TAESBlock; var ctx: TAESContext): integer;
  {-AES key expansion, error if invalid key size, encrypt IV}
begin
  {-AES key expansion, error if invalid key size}
  AES_CBC_Init_Encr := AES_Init(Key, KeyBits, ctx);
  ctx.IV := IV;
end;

function AES_Init_Decr(var Key; KeyBits: word; var ctx: TAESContext): integer;
  {-AES key expansion, InvMixColumn(Key) for decrypt, error if invalid key size}
begin
  AES_Init_Decr := AES_Init(Key, KeyBits, ctx);
  MakeDecrKey(ctx);
  ctx.Decrypt := 1;
end;

procedure AES_Decrypt(var ctx: TAESContext; {$ifdef CONST} const {$else} var {$endif} BI: TAESBlock; var BO: TAESBlock);
  {-decrypt one block (in ECB mode)}
label done;
var
  r: integer;
  pK: PWA4;       {pointer to loop rount key   }
  s,t: TAESBlock;
begin
  {Setup key pointer}
  pK := PWA4(@ctx.RK[ctx.Rounds]);
  {Initialize with input block}
  TWA4(s)[0] := TWA4(BI)[0] xor pK^[0];
  TWA4(s)[1] := TWA4(BI)[1] xor pK^[1];
  TWA4(s)[2] := TWA4(BI)[2] xor pK^[2];
  TWA4(s)[3] := TWA4(BI)[3] xor pK^[3];
  dec(longint(pK), 4*sizeof(longint));
  r := ctx.Rounds-1;
  while true do begin
    TWA4(t)[3] := Td[s[3*4+0]].D0.L xor Td[s[2*4+1]].D1.L xor Td[s[1*4+2]].D2.L xor Td[s[0*4+3]].D3.L xor pK^[3];
    TWA4(t)[2] := Td[s[2*4+0]].D0.L xor Td[s[1*4+1]].D1.L xor Td[s[0*4+2]].D2.L xor Td[s[3*4+3]].D3.L xor pK^[2];
    TWA4(t)[1] := Td[s[1*4+0]].D0.L xor Td[s[0*4+1]].D1.L xor Td[s[3*4+2]].D2.L xor Td[s[2*4+3]].D3.L xor pK^[1];
    TWA4(t)[0] := Td[s[0*4+0]].D0.L xor Td[s[3*4+1]].D1.L xor Td[s[2*4+2]].D2.L xor Td[s[1*4+3]].D3.L xor pK^[0];
    dec(longint(pK), 4*sizeof(longint));
    dec(r);
    if r<1 then goto done;
    TWA4(s)[3] := Td[t[3*4+0]].D0.L xor Td[t[2*4+1]].D1.L xor Td[t[1*4+2]].D2.L xor Td[t[0*4+3]].D3.L xor pK^[3];
    TWA4(s)[2] := Td[t[2*4+0]].D0.L xor Td[t[1*4+1]].D1.L xor Td[t[0*4+2]].D2.L xor Td[t[3*4+3]].D3.L xor pK^[2];
    TWA4(s)[1] := Td[t[1*4+0]].D0.L xor Td[t[0*4+1]].D1.L xor Td[t[3*4+2]].D2.L xor Td[t[2*4+3]].D3.L xor pK^[1];
    TWA4(s)[0] := Td[t[0*4+0]].D0.L xor Td[t[3*4+1]].D1.L xor Td[t[2*4+2]].D2.L xor Td[t[1*4+3]].D3.L xor pK^[0];
    dec(longint(pK), 4*sizeof(longint));
    dec(r);
  end;

done:

  s[00] := Td[t[0*4+0]].D0.box;
  s[01] := Td[t[3*4+1]].D0.box;
  s[02] := Td[t[2*4+2]].D0.box;
  s[03] := Td[t[1*4+3]].D0.box;
  s[04] := Td[t[1*4+0]].D0.box;
  s[05] := Td[t[0*4+1]].D0.box;
  s[06] := Td[t[3*4+2]].D0.box;
  s[07] := Td[t[2*4+3]].D0.box;
  s[08] := Td[t[2*4+0]].D0.box;
  s[09] := Td[t[1*4+1]].D0.box;
  s[10] := Td[t[0*4+2]].D0.box;
  s[11] := Td[t[3*4+3]].D0.box;
  s[12] := Td[t[3*4+0]].D0.box;
  s[13] := Td[t[2*4+1]].D0.box;
  s[14] := Td[t[1*4+2]].D0.box;
  s[15] := Td[t[0*4+3]].D0.box;

  TWA4(BO)[0] := TWA4(s)[0] xor pK^[0];
  TWA4(BO)[1] := TWA4(s)[1] xor pK^[1];
  TWA4(BO)[2] := TWA4(s)[2] xor pK^[2];
  TWA4(BO)[3] := TWA4(s)[3] xor pK^[3];
end;

function AES_CBC_Decrypt(ctp, ptp: Pointer; ILen: word; var ctx: TAESContext): integer;
  {-Decrypt ILen bytes from ctp^ to ptp^ in CBC mode}
var
  i,n,m: word;
  tmp: TAESBlock;
begin

  AES_CBC_Decrypt := 0;

  if ctx.Decrypt=0 then begin
    AES_CBC_Decrypt := AES_Err_Invalid_Mode;
    exit;
  end;

  if (ptp=nil) or (ctp=nil) then begin
    if ILen>0 then begin
      AES_CBC_Decrypt := AES_Err_NIL_Pointer;
      exit;
    end;
  end;

  n := ILen div AESBLKSIZE; {Full blocks}
  m := ILen mod AESBLKSIZE; {Remaining bytes in short block}
  if m<>0 then begin
    if n=0 then begin
      AES_CBC_Decrypt := AES_Err_Invalid_Length;
      exit;
    end;
    dec(n);           {CTS: special treatment of last TWO blocks}
  end;

  {Short block must be last, no more processing allowed}
  if ctx.Flag and 1 <> 0 then begin
    AES_CBC_Decrypt := AES_Err_Data_After_Short_Block;
    exit;
  end;

  with ctx do begin
    for i:=1 to n do begin
      {pt[i] = decr(ct[i]) xor ct[i-1]), cf. [3] 6.2}
      buf := IV;
      IV  := PAESBlock(ctp)^;
      AES_Decrypt(ctx, IV, PAESBlock(ptp)^);
      AES_XorBlock(PAESBlock(ptp)^, buf, PAESBlock(ptp)^);
      inc(longint(ptp),AESBLKSIZE);
      inc(longint(ctp),AESBLKSIZE);
    end;
    if m<>0 then begin
      {Cipher text stealing, L=ILen (Schneier's n)}
      buf := IV;                       {C(L-2)}
      AES_Decrypt(ctx, PAESBlock(ctp)^, IV);
      inc(longint(ctp),AESBLKSIZE);
      fillchar(tmp,sizeof(tmp),0);
      move(PAESBlock(ctp)^,tmp,m);     {c[L]|0}
      AES_XorBlock(tmp,IV,IV);
      tmp := IV;
      move(PAESBlock(ctp)^,tmp,m);     {c[L]| C'}
      AES_Decrypt(ctx,tmp,tmp);
      AES_XorBlock(tmp, buf, PAESBlock(ptp)^);
      inc(longint(ptp),AESBLKSIZE);
      move(IV,PAESBlock(ptp)^,m);
      {Set short block flag}
      Flag := Flag or 1;
    end;
  end;
end;

procedure AES_Encrypt(var ctx: TAESContext; const BI: TAESBlock; var BO: TAESBlock);
  {-encrypt one block, not checked: key must be encryption key}
var
  r: integer;              {round loop countdown counter}
  pK: PWA4;                {pointer to loop round key   }
  s3,s0,s1,s2: longint;    {TAESBlock s as separate variables}
  t: TWA4;
begin
  {Setup key pointer}
  pK := PWA4(@ctx.RK);
  {Initialize with input block}
  s0 := TWA4(BI)[0] xor pK^[0];
  s1 := TWA4(BI)[1] xor pK^[1];
  s2 := TWA4(BI)[2] xor pK^[2];
  s3 := TWA4(BI)[3] xor pK^[3];
  inc(pK);
  {perform encryption rounds}
  for r:=1 to ctx.Rounds-1 do begin
    t[0] := Te[s0 and $ff].E0.L xor Te[s1 shr 8 and $ff].E1.L xor Te[s2 shr 16 and $ff].E2.L xor Te[s3 shr 24].E3.L xor pK^[0];
    t[1] := Te[s1 and $ff].E0.L xor Te[s2 shr 8 and $ff].E1.L xor Te[s3 shr 16 and $ff].E2.L xor Te[s0 shr 24].E3.L xor pK^[1];
    t[2] := Te[s2 and $ff].E0.L xor Te[s3 shr 8 and $ff].E1.L xor Te[s0 shr 16 and $ff].E2.L xor Te[s1 shr 24].E3.L xor pK^[2];
    s3   := Te[s3 and $ff].E0.L xor Te[s0 shr 8 and $ff].E1.L xor Te[s1 shr 16 and $ff].E2.L xor Te[s2 shr 24].E3.L xor pK^[3];
    s0   := t[0];
    s1   := t[1];
    s2   := t[2];
    inc(pK);
  end;
  {Uses Sbox byte from Te and shl, needs type cast longint() for 16 bit compilers}
  TWA4(BO)[0] := (longint(Te[s0        and $ff].E0.box)        xor
                  longint(Te[s1 shr  8 and $ff].E0.box) shl  8 xor
                  longint(Te[s2 shr 16 and $ff].E0.box) shl 16 xor
                  longint(Te[s3 shr 24        ].E0.box) shl 24    ) xor pK^[0];
  TWA4(BO)[1] := (longint(Te[s1        and $ff].E0.box)        xor
                  longint(Te[s2 shr  8 and $ff].E0.box) shl  8 xor
                  longint(Te[s3 shr 16 and $ff].E0.box) shl 16 xor
                  longint(Te[s0 shr 24        ].E0.box) shl 24    ) xor pK^[1];
  TWA4(BO)[2] := (longint(Te[s2        and $ff].E0.box)        xor
                  longint(Te[s3 shr  8 and $ff].E0.box) shl  8 xor
                  longint(Te[s0 shr 16 and $ff].E0.box) shl 16 xor
                  longint(Te[s1 shr 24        ].E0.box) shl 24    ) xor pK^[2];
  TWA4(BO)[3] := (longint(Te[s3        and $ff].E0.box)        xor
                  longint(Te[s0 shr  8 and $ff].E0.box) shl  8 xor
                  longint(Te[s1 shr 16 and $ff].E0.box) shl 16 xor
                  longint(Te[s2 shr 24        ].E0.box) shl 24    ) xor pK^[3];

end;

function AES_CBC_Encrypt(ptp, ctp: Pointer; ILen: word; var ctx: TAESContext): integer;
  {-Encrypt ILen bytes from ptp^ to ctp^ in CBC mode}
var
  i,n,m: word;
begin

  AES_CBC_Encrypt := 0;

  if ctx.Decrypt<>0 then begin
    AES_CBC_Encrypt := AES_Err_Invalid_Mode;
    exit;
  end;

  if (ptp=nil) or (ctp=nil) then begin
    if ILen>0 then begin
      AES_CBC_Encrypt := AES_Err_NIL_Pointer;
      exit;
    end;
  end;


  n := ILen div AESBLKSIZE; {Full blocks}
  m := ILen mod AESBLKSIZE; {Remaining bytes in short block}
  if m<>0 then begin
    if n=0 then begin
      AES_CBC_Encrypt := AES_Err_Invalid_Length;
      exit;
    end;
    dec(n);           {CTS: special treatment of last TWO blocks}
  end;

  {Short block must be last, no more processing allowed}
  if ctx.Flag and 1 <> 0 then begin
    AES_CBC_Encrypt := AES_Err_Data_After_Short_Block;
    exit;
  end;

  with ctx do begin
    for i:=1 to n do begin
      {ct[i] = encr(ct[i-1] xor pt[i]), cf. [3] 6.2}
      AES_XorBlock(PAESBlock(ptp)^, IV, IV);
      AES_Encrypt(ctx, IV, IV);
      PAESBlock(ctp)^ := IV;
      inc(longint(ptp),AESBLKSIZE);
      inc(longint(ctp),AESBLKSIZE);
    end;
    if m<>0 then begin
      {Cipher text stealing}
      AES_XorBlock(PAESBlock(ptp)^, IV, IV);
      AES_Encrypt(ctx, IV, IV);
      buf := IV;
      inc(longint(ptp),AESBLKSIZE);
      for i:=0 to m-1 do IV[i] := IV[i] xor PAESBlock(ptp)^[i];
      AES_Encrypt(ctx, IV, PAESBlock(ctp)^);
      inc(longint(ctp),AESBLKSIZE);
      move(buf,PAESBlock(ctp)^,m);
      {Set short block flag}
      Flag := Flag or 1;
    end;
  end;
end;

function AES_CBC_Init_Decr(var Key; KeyBits: word; var IV: TAESBlock; var ctx: TAESContext): integer;
  {-AES key expansion, error if invalid key size, encrypt IV}
begin
  {-AES key expansion, error if invalid key size}
  AES_CBC_Init_Decr := AES_Init_Decr(Key, KeyBits, ctx);
  ctx.IV := IV;
end;

procedure MakeXKey(var orig_key : array of Byte; var new_key : array of Byte);
var
 i, j: Integer;
 str : STring;
begin
str:='';
for i:=0 to Length(orig_key)-1 do
 str:=str + IntToHex(orig_key[i],2);

////Form1.//Memo1.Lines.Add('Key: '+str);

new_key[0]:=$67;
new_key[1]:=$45;
new_key[2]:=$23;
new_key[3]:=1;
i:=0;
repeat
 j:=i*4 + i;
 new_key[i*4]:=(orig_key[j+1] xor orig_key[j+2] xor orig_key[j+3] xor new_key[i]) + orig_key[j] + orig_key[j+4];
 new_key[i*4+1]:=(orig_key[j+2] xor orig_key[j+3] xor orig_key[j+4] xor new_key[i+1]) + orig_key[j+1] + orig_key[j];
 new_key[i*4+2]:=(orig_key[j+3] xor orig_key[j+4] xor orig_key[j] xor new_key[i+2]) + orig_key[j+2] + orig_key[j+1];
 new_key[i*4+3]:=(orig_key[j+4] xor orig_key[j] xor orig_key[j+1] xor new_key[i+3]) + orig_key[j+3] + orig_key[j+2];
 Inc(i);
until i >= 4;

str:='';
for i:=0 to Length(new_key)-1 do
 str:=str + IntToHex(new_key[i],2);

////Form1.//Memo1.Lines.Add('New key: '+str);
end;

procedure PutHex4(var buf : array of Byte; offs : Integer; value : Integer);
begin
buf[offs]:=(value shr $18) and $FF;
buf[offs+1]:=(value shr $10) and $FF;
buf[offs+2]:=(value shr 8) and $FF;
buf[offs+3]:=value and $FF;
end;

function ReadHex4(var buf : array of Byte; offs : Integer) : Integer;
begin
     Result:=MakeLong(MakeWord(buf[offs],buf[offs+1]),MakeWord(buf[offs+2],buf[offs+3]));
end;

procedure MakeSign(var hash : array of Byte; var RSA_PubMod : array of Byte; var RSA_Priv : array of Byte; var signature : array of Byte);
var
 i : Integer;
 str, str3, hash_str, RSAKey_str, PrivKey_str : String;
 modul, priv, Nilgint : TFGInt;
begin
  hash_str:='';
  for i:=0 to Length(hash)-1 do
   hash_str:=hash_str + Chr(hash[i]);

  //---RSA Public Key--------------------------------
  //modulus to str
  for i:=0 to $7F do
   RSAKey_str:=RSAKey_str + IntToHex(RSA_PubMod[i],2);
  ConvertHexStringToBase256String(RSAKey_str, str);

  //modulus to FGInt
  BASE256StringToFGInt(str, modul);
  //--------------------------------------------------

  //---RSA Private Key--------------------------------
  //key to str
  for i:=0 to $7F do
   PrivKey_str:=PrivKey_str + IntToHex(RSA_Priv[i],2);
  ConvertHexStringToBase256String(PrivKey_str, str);

  //modulus to FGInt
  BASE256StringToFGInt(str, priv);
  //--------------------------------------------------

  FGIntDestroy(Nilgint);

  SetLength(str3,127);
  str3[1]:=#1;
  FillChar(str3[2],105,#255);
  str3[107]:=#0;
  CopyMemory(@str3[108], @hash[0], $14);

  str:='';
  RSASign(str3, priv, modul, Nilgint, Nilgint, Nilgint, Nilgint, str);

  for i:=1 to Length(str) do
   signature[i-1]:=Ord(str[i]);

  FGIntDestroy(modul);
  FGIntDestroy(priv);
end;

function VerifySign(var hash : array of Byte; exp : Integer; var RSA_PubMod : array of Byte; var signature : array of Byte) : Boolean;
var
 i : Integer;
 str, hash_str, RSAKey_str, sig_str : String;
 exp_, modul, priv, Nilgint : TFGInt;
begin
  hash_str:='';
  for i:=0 to Length(hash)-1 do
   hash_str:=hash_str + Chr(hash[i]);

  //---RSA Public Key--------------------------------
  Base10StringToFGInt(IntToStr(exp), exp_);

  //modulus to str
  for i:=0 to $7F do
   RSAKey_str:=RSAKey_str + IntToHex(RSA_PubMod[i],2);
  ConvertHexStringToBase256String(RSAKey_str, str);

  //modulus to FGInt
  BASE256StringToFGInt(str, modul);
  //--------------------------------------------------

  //---signature--------------------------------
  for i:=0 to $7F do
   sig_str:=sig_str + Chr(signature[i]);
//  ConvertHexStringToBase256String(sig_str, str);
  //--------------------------------------------------

  FGIntDestroy(Nilgint);

  Result:=False;
  RSAVerify(hash_str, sig_str, exp_, modul, Result);

  FGIntDestroy(exp_);
  FGIntDestroy(modul);
  FGIntDestroy(priv);
end;

end.
