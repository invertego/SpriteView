	.686
	.model	flat, C

.CODE

DefHandler	macro	name

	EXTRN	&name&Handler:PROC

	name	PROC

		pushfd
		pusha
		push        esp
		call        &name&Handler
		add         esp,4
		popa
		popfd
		ret

	name	ENDP

endm

Int10h	macro
;	int         10h
	call        VidInt
endm

Int16h	macro
;	int         16h
	call        KeyInt
endm

Int21h	macro
;	int         21h
	call        DosInt
endm

Int31h	macro
;	int         31h
	call        DpmiInt
endm

PortOut	macro
;	out         dx,al
	call        VidOut
endm

DefHandler VidInt
DefHandler VidOut
DefHandler KeyInt
DefHandler DosInt
DefHandler DpmiInt

SV_Main	PROC

	push        ebx
	push        ebp
	push        esi
	push        edi

	mov         esi,dword ptr [esp+14h]
	mov         edi,dword ptr [esp+18h]
	xor         ebp,ebp

	mov         dword ptr [Lbss+0000h],esi
	mov         dword ptr [Lbss+0004h],edi
	mov         dword ptr [Lbss+0008h],ebp
;	mov         word ptr [Lbss+000Ch],es
;	push        ds
;	pop         es
	call        L1B50
	jb          L1113
	test        byte ptr [Ldata+13C0h],1
	je          L1105
	push        0
	call        L271E
	lea         esp,[esp+4]
	jb          L110C
	call        L1949
	jb          L1113
	test        byte ptr [Ldata+13C0h],8
	je          L1067
	call        L1A44
	jae         L1086
	call        L10FC
L1067:
	cmp         byte ptr [Lbss+0940h],0
	jne         L108D
	mov         esi,dword ptr [Lbss+0938h]
	add         esi,618h
	mov         edi,offset Ldata+0AB4h
	call        L2701
L1086:
	mov         byte ptr [Ldata+142Fh],5
L108D:
	cmp         dword ptr [Ldata+13C4h],0
	ja          L10C5
	mov         eax,dword ptr [Lbss+093Ch]
	mov         ebx,200h
	and         eax,7FFFh
	cmp         eax,ebx
	jne         L10B2
	mov         dword ptr [Ldata+13C4h],ebx
L10B2:
	cmp         byte ptr [Lbss+0940h],0
	jne         L10C5
	mov         dword ptr [Ldata+13C4h],20C13h
L10C5:
	call        L1CAD
	push        offset L1CE1
	call        L2BB2
	lea         esp,[esp+4]
	mov         al,byte ptr [Ldata+142Fh]
	call        L17CA
	call        L1D3C
	call        L1D0F
	call        L1124
	call        L2BE4
;	mov         ax,4C00h
;	Int21h
	xor         eax,eax
	jmp         Epilog
L10FC:
	mov         ah,9
	Int21h
	jmp         L2066
L1105:
	mov         edx,offset Ldata+1598h
	jmp         L1113
L110C:
	mov         edx,offset Ldata+14D5h
	jmp         L1113
L1113:
	push        edx
	call        L2BE4
	pop         edx
	mov         ah,9
	Int21h
;	mov         ax,4C01h
;	Int21h
	mov         eax,1

Epilog:
	pop         edi
	pop         esi
	pop         ebp
	pop         ebx
	ret

SV_Main	ENDP

L1124	PROC

	push        offset L1377
	jmp         L14EF
L112E:
	call        L2043
	jae         L112E
	mov         esi,offset Ldata+00A4h
	call        L2012
	jb          L112E
	jmp         dword ptr [ecx*4+Ldata+0014h]

L1148::
	mov         edx,0FFFFFFFFh
	jmp         L1352

L1152::
	mov         edx,1
	jmp         L1352

L115C::
	mov         edx,0FFFFFFFFh
	jmp         L1341

L1166::
	mov         edx,1
	jmp         L1341

L1170::
	mov         edx,0FFFFFFFFh
	jmp         L1322

L117A::
	mov         edx,1
	jmp         L1322

L1184::
	mov         edx,0FFFFFFF0h
	jmp         L1322

L118E::
	mov         edx,10h
	jmp         L1322

L1198::
	mov         edx,0FFFF8000h
	jmp         L1352

L11A2::
	mov         edx,8000h
	jmp         L1352

L11AC::
	mov         eax,0FFFFFFF8h
	jmp         L1434

L11B6::
	mov         eax,8
	jmp         L1434

L11C0::
	mov         eax,dword ptr [Ldata+13D8h]
	shr         eax,1
	and         eax,3F8h
	jmp         L143A

L11D1::
	mov         eax,dword ptr [Ldata+13D8h]
	shl         eax,1
	and         eax,7F8h
	jmp         L143A

L11E2::
	mov         dl,0FFh
	jmp         L11E8

L11E6::
	mov         dl,1

L11E8:
	add         dl,byte ptr [Ldata+142Fh]
	push        offset L1377
	jmp         L1483

L11F8::
	sub         al,30h
	cmp         al,2
	je          L121A
	cmp         al,3
	je          L1226
	cmp         al,4
	je          L1232
	cmp         al,8
	jne         L1423
	mov         ah,12h
	mov         ebx,80h
	jmp         L12FF

L121A:
	mov         ah,10h
	mov         ebx,20h
	jmp         L12FF

L1226:
	mov         ah,13h
	mov         ebx,100h
	jmp         L12FF

L1232:
	mov         ah,11h
	mov         ebx,40h
	jmp         L12FF

L123E::
	mov         ax,9
	mov         ebx,10h
	jmp         L12FF

L124C::
	mov         ax,0E0Fh
	mov         ebx,8
	jmp         L12FF

L125A::
	mov         ax,0B0Ah
	mov         ebx,1
	jmp         L12FF

L1268::
	mov         ax,0D0Ch
	mov         ebx,2
	jmp         L12FF

L1276::
	mov         al,0FFh
	jmp         L127C

L127A::
	mov         al,1

L127C:
	mov         cl,byte ptr [Ldata+13C8h]
	mov         bl,byte ptr [Ldata+1431h]
	shr         bl,cl
	add         bl,al
	shl         bl,cl
	mov         byte ptr [Ldata+1431h],bl
	push        offset L1377
	jmp         L1496

L129E::
	mov         al,10h
	cmp         byte ptr [Ldata+1436h],al
	jne         L12AA
	mov         al,0Ah

L12AA:
	mov         byte ptr [Ldata+1436h],al
	jmp         L137C

L12B4::
	xor         edx,edx
	jmp         L1358

L12BB::
	mov         edx,dword ptr [Lbss+093Ch]
	dec         edx
	jmp         L1358

L12C7::
	mov         eax,0FFh
	jmp         L14B1

L12D1::
	mov         eax,1
	jmp         L14B1

L12DB::
	mov         eax,0FF00h
	jmp         L14B1

L12E5::
	mov         eax,100h
	jmp         L14B1

L12EF::
	ret

L12F0::
	call        L190E
	push        offset L1377
	jmp         L14EF
L12FF:
	mov         cl,byte ptr [Ldata+1430h]
	cmp         cl,al
	je          L130D
	cmp         cl,ah
	jne         L1313
L130D:
	xor         dword ptr [Ldata+1432h],ebx
L1313:
	test        dword ptr [Ldata+1432h],ebx
	je          L131D
	mov         al,ah
L131D:
	jmp         L1423
L1322:
	mov         ebx,dword ptr [Ldata+13D8h]
	shr         ebx,3
	imul        edx,ebx
	movzx       eax,byte ptr [Ldata+142Ch]
	imul        edx,dword ptr [Ldata+13CCh]
	imul        edx,eax
	jmp         L1352
L1341:
	movzx       eax,byte ptr [Ldata+142Eh]
	imul        edx,dword ptr [Ldata+13D0h]
	imul        edx,eax
L1352:
	add         edx,dword ptr [Ldata+13C4h]
L1358:
	mov         ebx,dword ptr [Lbss+093Ch]
	cmp         edx,ebx
	jb          L1371
	cmp         dword ptr [Ldata+13C4h],ebx
	jb          L112E
	mov         edx,ebx
	dec         ebx
L1371:
	mov         dword ptr [Ldata+13C4h],edx
L1377:
	call        L212F
L137C:
	movzx       ebx,byte ptr [Ldata+1436h]
	mov         eax,dword ptr [Ldata+13C4h]
	mov         ecx,7
	mov         edi,offset Ldata+00CEh
	call        L1C31
	mov         eax,dword ptr [Ldata+13D8h]
	mov         ecx,4
	mov         edi,offset Ldata+00D6h
	call        L1C2C
	mov         dword ptr [Ldata+0000h],0
	mov         esi,dword ptr [Ldata+13E8h]
	call        L1405
	mov         al,byte ptr [Ldata+142Ch]
	add         al,30h
	mov         byte ptr [Ldata+00F2h],al
	mov         al,byte ptr [Ldata+142Dh]
	add         al,30h
	mov         byte ptr [Ldata+00F4h],al
	mov         al,byte ptr [Ldata+142Fh]
	call        L18C4
	call        L1405
	pushw       5
	pushw       0BCh
	pushw       27h
	push        offset Ldata+00CEh
	call        L1DE4
	add         esp,0Ah
	jmp         L112E
L1405:
	mov         ebx,dword ptr [Ldata+0000h]
	mov         edi,dword ptr [ebx*8+Ldata+0004h]
	mov         ecx,dword ptr [ebx*8+Ldata+0008h]
	cld
	rep movs    byte ptr [edi],byte ptr [esi]
	inc         dword ptr [Ldata+0000h]
	ret
L1423:
	call        L157D
	je          L142F
	call        L1496
L142F:
	jmp         L1377
L1434:
	add         eax,dword ptr [Ldata+13D8h]
L143A:
	cmp         eax,8
	jb          L112E
	cmp         eax,400h
	ja          L112E
	cmp         dword ptr [Ldata+13D8h],eax
	mov         dword ptr [Ldata+13D8h],eax
	jbe         L1377
	add         eax,4
	pushw       20h
	pushw       103h
	push        ax
	pushw       0B2h
	pushw       3
	call        L1E62
	add         esp,0Ah
	jmp         L1377
L1483:
	cmp         dl,6
	jb          L1490
	jns         L148E
	mov         dl,5
	jmp         L1490
L148E:
	xor         dl,dl
L1490:
	mov         byte ptr [Ldata+142Fh],dl
L1496:
	mov         al,byte ptr [Ldata+142Fh]
	call        L17CA
	call        L1D3C
	call        L1D0F
	call        L1550
	ret
	ret
L14B1:
	mov         ecx,dword ptr [Ldata+142Ch]
	add         cl,al
	je          L112E
	cmp         cl,8
	ja          L112E
	mov         byte ptr [Ldata+142Ch],cl
	add         ch,ah
	je          L112E
	cmp         ch,8
	ja          L112E
	mov         byte ptr [Ldata+142Dh],ch
	call        L22EA
	jmp         L1377
L14EF:
	mov         al,20h
	call        L1F28
	pushw       1
	pushw       104h
	pushw       3
	pushw       0B3h
	pushw       2
	call        L1F47
	add         esp,0Ah
	pushw       1
	pushw       104h
	pushw       3
	pushw       0B8h
	pushw       0B5h
	call        L1F47
	add         esp,0Ah
	pushw       1
	pushw       13Dh
	pushw       3
	pushw       0C5h
	pushw       0BAh
	call        L1F47
	add         esp,0Ah
	call        L1550
	ret

L1124	ENDP

L1550	PROC

	mov         edi,FrameBuffer+0E384h
	xor         eax,eax
	mov         cl,byte ptr [Ldata+13C8h]
	mov         ch,1
	shl         ch,cl
	test        ch,ch
	jne         L1569
	dec         ch
	inc         ah
L1569:
	xor         cl,cl
L156B:
	mov         byte ptr [edi],al
	mov         byte ptr [edi+00000140h],al
	inc         edi
	add         ah,ch
	adc         al,0
	dec         cl
	jne         L156B
	ret

L1550	ENDP

L157D	PROC

	movzx       eax,al
	cmp         al,14h
	jae         L1590
	mov         byte ptr [Ldata+1430h],al
	jmp         dword ptr [eax*4+L177A]
L1590:
	test        al,al
	ret
L1593:
	mov         al,2
	mov         dword ptr [Ldata+13E0h],offset L2340
	mov         dword ptr [Ldata+13E4h],offset L2414
	mov         dword ptr [Ldata+13E8h],offset Ldata+145Dh
	jmp         L175C
L15B8:
	mov         ebx,dword ptr [eax*4+L23F0]
	mov         dword ptr [Ldata+13E0h],offset L2340
	mov         dword ptr [Ldata+13E4h],ebx
	mov         esi,offset Ldata+1453h
	cmp         al,2
	je          L15E8
	mov         esi,offset Ldata+1449h
	mov         dl,al
	add         dl,30h
	mov         byte ptr [Ldata+1451h],dl
L15E8:
	mov         dword ptr [Ldata+13E8h],esi
	jmp         L175C
L15F3:
	mov         al,8
	mov         byte ptr [L2508],1
	mov         dword ptr [Ldata+13E0h],offset L24CC
	mov         dword ptr [Ldata+13E8h],offset Ldata+1467h
	jmp         L175C
L1615:
	mov         al,8
	mov         byte ptr [L2508],2
	mov         dword ptr [Ldata+13CCh],80h
	mov         byte ptr [Ldata+13D0h],80h
	mov         dword ptr [Ldata+13E0h],offset L24CC
	mov         dword ptr [Ldata+13E8h],offset Ldata+1471h
	jmp         L176E
L1648:
	mov         al,4
	mov         dword ptr [Ldata+13E0h],offset L2509
	mov         dword ptr [Ldata+13E8h],offset Ldata+148Fh
	jmp         L175C
L1663:
	mov         al,2
	mov         dword ptr [Ldata+13E0h],offset L269B
	mov         dword ptr [Ldata+13E8h],offset Ldata+14CBh
	jmp         L175C
L167E:
	mov         eax,202h
	mov         dword ptr [Ldata+13E0h],offset L2605
	mov         dword ptr [Ldata+13E8h],offset Ldata+14ADh
	jmp         L1748
L169C:
	mov         eax,404h
	mov         dword ptr [Ldata+13E0h],offset L2649
	mov         dword ptr [Ldata+13E8h],offset Ldata+14B7h
	jmp         L1748
L16BA:
	mov         eax,808h
	mov         dword ptr [Ldata+13E0h],offset L267C
	mov         dword ptr [Ldata+13E8h],offset Ldata+14C1h
	jmp         L1748
L16D8:
	mov         dword ptr [Ldata+13E8h],offset Ldata+147Bh
	xor         cl,cl
	jmp         L16F2
L16E6:
	mov         dword ptr [Ldata+13E8h],offset Ldata+1485h
	mov         cl,4
L16F2:
	mov         byte ptr [L2570],cl
	mov         eax,804h
	mov         dword ptr [Ldata+13E0h],offset L253B
	jmp         L1748
L170C:
	mov         eax,2008h
	mov         dword ptr [Ldata+13E0h],offset L2571
	mov         dword ptr [Ldata+13E8h],offset Ldata+1499h
	jmp         L1748
L172A:
	mov         eax,1008h
	mov         dword ptr [Ldata+13E0h],offset L25B3
	mov         dword ptr [Ldata+13E8h],offset Ldata+14A3h
	jmp         L1748
L1748:
	movzx       edx,ah
	mov         dword ptr [Ldata+13D0h],edx
	shl         edx,3
	mov         dword ptr [Ldata+13CCh],edx
	jmp         L176E
L175C:
	movzx       edx,al
	shl         edx,3
	mov         dword ptr [Ldata+13CCh],edx
	mov         dword ptr [Ldata+13D0h],edx
L176E:
	cmp         byte ptr [Ldata+13C8h],al
	mov         byte ptr [Ldata+13C8h],al
	ret
L177A:
	dd          offset L1593
	dd          offset L15B8
	dd          offset L15B8
	dd          offset L15B8
	dd          offset L15B8
	dd          offset L15B8
	dd          offset L15B8
	dd          offset L15B8
	dd          offset L15B8
	dd          offset L1648
	dd          offset L15F3
	dd          offset L1615
	dd          offset L16D8
	dd          offset L16E6
	dd          offset L170C
	dd          offset L172A
	dd          offset L167E
	dd          offset L169C
	dd          offset L16BA
	dd          offset L1663

L157D	ENDP

L17CA	PROC

	movzx       eax,al
	cmp         eax,6
	jae         L17F4
	mov         cl,byte ptr [Ldata+13C8h]
	cmp         cl,8
	ja          L17F4
	mov         ebx,1
	shl         ebx,cl
	dec         ebx
	mov         edi,offset Lbss+0958h
	cld
	jmp         dword ptr [eax*4+L18AC]
L17F4:
	ret
L17F5:
	mov         esi,offset Ldata+07B4h
	mov         ecx,100h
	jmp         L189C
L1804:
	mov         esi,offset Ldata+04B4h
	neg         cl
	add         cl,8
	mov         edx,1
	shl         edx,cl
	dec         edx
	lea         edx,[edx+edx*2]
L1819:
	movs        word ptr [edi],word ptr [esi]
	movs        byte ptr [edi],byte ptr [esi]
	inc         edi
	add         esi,edx
	dec         ebx
	jns         L1819
	ret
L1823:
	lea         edi,[edi+ebx*4]
	mov         edx,0FFFFFFFCh
	jmp         L1832
L182D:
	mov         edx,4
L1832:
	mov         eax,1010100h
	shr         eax,cl
	xor         ecx,ecx
L183B:
	mov         dword ptr [edi],ecx
	add         edi,edx
	add         ecx,eax
	dec         ebx
	jns         L183B
	ret
L1845:
	movzx       esi,byte ptr [Ldata+1431h]
	lea         edx,[ebx+esi]
	cmp         edx,100h
	jae         L1868
	lea         ecx,[ebx+1]
	lea         esi,[esi+esi*2]
	add         esi,offset Ldata+0AB4h
	jmp         L189C
L1868:
	mov         esi,offset Ldata+0AB4h
	mov         ecx,100h
	jmp         L189C
L1877:
	xor         eax,eax
L1879:
	stos        dword ptr [edi]
	add         al,2Bh
	jae         L1898
	xor         al,al
	add         ah,2Bh
	jae         L1898
	xor         ah,ah
	add         eax,2B0000h
	cmp         eax,0FFFFFFh
	jb          L1898
	and         eax,0FFFFh
L1898:
	dec         ebx
	jns         L1879
	ret
L189C:
	mov         eax,dword ptr [esi]
	and         eax,0FFFFFFh
	add         esi,3
	stos        dword ptr [edi]
	dec         ecx
	jne         L189C
	ret

	db          00h

L18AC:
	dd          offset L17F5
	dd          offset L1804
	dd          offset L182D
	dd          offset L1823
	dd          offset L1877
	dd          offset L1845

L17CA	ENDP

L18C4	PROC

	movzx       eax,al
	cmp         eax,6
	jae         L1906
	cmp         eax,5
	jne         L18F9
	mov         edi,offset Ldata+015Ah
	movzx       eax,byte ptr [Ldata+1431h]
	mov         ecx,3
	call        L1C2C
	mov         esi,offset Ldata+0151h
	jmp         L1900
L18F9:
	mov         esi,dword ptr [eax*4+Ldata+00F8h]
L1900:
	mov         eax,0Ch
	ret
L1906:
	mov         esi,offset Ldata+011Dh
	xor         eax,eax
	ret

L18C4	ENDP

L190E	PROC

	mov         al,20h
	call        L1F28
	pushw       1
	pushw       13Ch
	pushw       3
	pushw       0C5h
	pushw       2
	call        L1F47
	add         esp,0Ah
	push        50004h
	push        offset Ldata+17DEh
	call        L1E15
	add         esp,8
	call        L2066
	ret

L190E	ENDP

L1949	PROC

	mov         ax,3D00h
	mov         edx,offset Lbss+0738h
	Int21h
	jb          L1A0D
	mov         word ptr [Lbss+0000h],ax
	mov         ebx,eax
	mov         eax,4202h
	xor         ecx,ecx
	xor         edx,edx
	Int21h
	jb          L1A0D
	shl         edx,10h
	mov         dx,ax
	test        edx,edx
	je          L1A29
	mov         dword ptr [Lbss+093Ch],edx
	push        edx
	call        L2847
	lea         esp,[esp+4]
	mov         edx,dword ptr [Lbss+0628h]
	jb          L1A30
	mov         dword ptr [Lbss+0938h],edx
	mov         eax,4200h
	xor         ecx,ecx
	xor         edx,edx
	Int21h
	mov         edi,dword ptr [Lbss+093Ch]
	mov         edx,dword ptr [Lbss+0938h]
	mov         ecx,100000h
L19BF:
	cmp         edi,ecx
	jae         L19C5
	mov         ecx,edi
L19C5:
	mov         eax,ecx
	shr         eax,0Ch
	mov         esi,edx
L19CC:
	mov         byte ptr [esi],0
	add         esi,1000h
	dec         eax
	jg          L19CC
	mov         eax,3F00h
	Int21h
	jb          L1A13
	push        edx
	mov         eax,200h
	mov         dl,2Eh
	Int21h
	pop         edx
	add         edx,100000h
	sub         edi,ecx
	ja          L19BF
	mov         ax,3E00h
	Int21h
	mov         esi,offset Lbss+0738h
	call        L1ADB
	mov         byte ptr [Lbss+0940h],al
	clc
	ret
L1A0D:
	mov         edx,offset Ldata+1505h
	ret
L1A13:
	push        dword ptr [Lbss+0938h]
	call        L2931
	lea         esp,[esp+4]
	mov         edx,offset Ldata+1505h
	stc
	ret
L1A29:
	mov         edx,offset Ldata+153Eh
	stc
	ret
L1A30:
	mov         bx,word ptr [Lbss+0000h]
	mov         ax,3E00h
	Int21h
	mov         edx,offset Ldata+1522h
	stc
	ret

L1949	ENDP

L1A44	PROC

	mov         ax,3D00h
	mov         edx,offset Lbss+0838h
	Int21h
	mov         edx,offset Ldata+1568h
	jb          L1AA7
	mov         dword ptr [Lbss+0000h],eax
	sub         esp,400h
	mov         esi,offset Lbss+0838h
	call        L1ADB
	mov         esi,esp
	mov         edi,offset Ldata+0AB4h
	cmp         al,0
	jne         L1AA8
	mov         edx,618h
	call        L1ABA
	mov         ecx,200h
	mov         edx,esp
	call        L1ACD
	call        L2701
	add         esp,400h
L1A9B:
	mov         ebx,dword ptr [Lbss+0000h]
	mov         ax,3E00h
	Int21h
L1AA7:
	ret
L1AA8:
	call        L1A9B
	add         esp,400h
	mov         edx,offset Ldata+154Dh
	stc
	ret

L1A44	ENDP

L1ABA	PROC

	mov         eax,4200h
	mov         ecx,edx
	mov         ebx,dword ptr [Lbss+0000h]
	shr         ecx,10h
	Int21h
	ret

L1ABA	ENDP

L1ACD	PROC

	mov         eax,3F00h
	mov         ebx,dword ptr [Lbss+0000h]
	Int21h
	ret

L1ACD	ENDP

L1ADB	PROC

	call        L1C13
	cmp         eax,5
	jb          L1B33
	mov         eax,dword ptr [esi+eax-3]
	mov         ecx,4
L1AF4:
	cmp         al,41h
	jb          L1AFE
	cmp         al,5Ah
	ja          L1AFE
	or          al,20h
L1AFE:
	rol         eax,8
	dec         ecx
	jne         L1AF4
	cmp         eax,706D62h
	jne         L1B0E
	mov         al,2
	ret
L1B0E:
	cmp         eax,666967h
	jne         L1B18
	mov         al,3
	ret
L1B18:
	mov         edx,74737Ah
	call        L1B36
	je          L1B30
	mov         edx,766D7Ah
	call        L1B36
	jne         L1B33
L1B30:
	mov         al,0
	ret
L1B33:
	mov         al,4
	ret

L1ADB	ENDP

L1B36	PROC

	cmp         ax,dx
	jne         L1B4F
	cmp         eax,edx
	je          L1B4F
	cmp         eax,310000h
	jb          L1B4F
	cmp         eax,39FFFFh
	ja          L1B4F
	cmp         eax,eax
L1B4F:
	ret

L1B36	ENDP

L1B50	PROC

	mov         edx,1
	push        eax
	cld
L1B57:
	call        L1BFE
	jbe         L1B91
	cmp         al,2Dh
	jne         L1BE6
	inc         esi
	mov         dword ptr [esp],esi
	xor         ebx,ebx
	mov         edi,offset Ldata+015Eh
	movzx       ecx,byte ptr [edi]
L1B74:
	inc         edi
	lea         eax,[edi+ecx]
	repe cmps   byte ptr [esi],byte ptr [edi]
	je          L1B94
	inc         ebx
	mov         esi,dword ptr [esp]
	mov         edi,eax
	movzx       ecx,byte ptr [edi]
	test        ecx,ecx
	jne         L1B74
	mov         edx,offset Ldata+1585h
L1B8E:
	pop         eax
	stc
	ret
L1B91:
	pop         eax
	clc
	ret
L1B94:
	cmp         ebx,4
	jae         L1B57
	jmp         dword ptr [ebx*4+Ldata+016Ch]

L1BA3::
	mov         edx,offset Ldata+1598h
	jmp         L1B8E

L1BAA::
	mov         edx,offset Ldata+1A36h
	jmp         L1B8E

L1BB1::
	call        L1BFE
	jbe         L1B57
	push        edx
	call        L1CA1
	mov         dword ptr [Ldata+13C4h],eax
	pop         edx
	jmp         L1B57

L1BCD::
	call        L1BFE
	jbe         L1B57
	or          byte ptr [Ldata+13C0h],8
	mov         edi,offset Lbss+0838h
	jmp         L1BF2
L1BE6:
	mov         edi,offset Lbss+0738h
	or          byte ptr [Ldata+13C0h],1
L1BF2:
	mov         ecx,40h
	rep movs    dword ptr [edi],dword ptr [esi]
	jmp         L1B57

L1B50	ENDP

L1BFE	PROC

	cmp         dword ptr [Lbss+0000h],edx
	jbe         L1C12
	mov         esi,dword ptr [Lbss+0004h]
	mov         esi,dword ptr [esi+edx*4]
	mov         al,byte ptr [esi]
	inc         edx
L1C12:
	ret

L1BFE	ENDP

L1C13	PROC

	push        edi
	push        ecx
	mov         edi,esi
	mov         ecx,2000h
	mov         eax,ecx
	cld
	repne scas  byte ptr [edi]
	sub         eax,ecx
	dec         eax
	pop         ecx
	pop         edi
	ret

L1C13	ENDP

	mov         ecx,8

L1C2C	PROC

	mov         ebx,0Ah
L1C31::
	xor         edx,edx
	lea         edi,[edi+ecx-1]
L1C37:
	div         ebx
	mov         dl,byte ptr [edx+L1C58]
	mov         byte ptr [edi],dl
	dec         edi
	test        eax,eax
	je          L1C4D
	xor         dl,dl
	dec         cl
	jne         L1C37
	ret
L1C4D:
	mov         al,20h
	dec         ecx
	mov         ebx,ecx
	std
	rep stos    byte ptr [edi]
	mov         ecx,ebx
	ret

L1C2C	ENDP

L1C58:
	db          30h
	db          31h
	db          32h
	db          33h
	db          34h
	db          35h
	db          36h
	db          37h
	db          38h
	db          39h
	db          41h
	db          42h
	db          43h
	db          44h
	db          45h
	db          46h
	mov         ecx,0Ah
	mov         ebx,0Ah

L1C72	PROC

	xor         edx,edx
	mov         edi,ecx
	xor         eax,eax
L1C78:
	mov         dl,byte ptr [esi]
	sub         dl,30h
	jb          L1C9E
	cmp         dl,0Ah
	jb          L1C94
	and         dl,0DFh
	cmp         dl,11h
	jb          L1C9E
	cmp         dl,16h
	ja          L1C9E
	sub         dl,7
L1C94:
	imul        eax,ebx
	add         eax,edx
	inc         esi
	dec         cl
	jne         L1C78
L1C9E:
	sub         edi,ecx
	ret

L1C72	ENDP

L1CA1	PROC

	mov         ecx,0Ah
	mov         ebx,10h
	jmp         L1C72

L1CA1	ENDP

L1CAD	PROC

	push        eax
	push        ebx
	mov         ax,13h
	Int10h
	mov         dword ptr [Lbss+0944h],0A0000h
	mov         ax,word ptr [Ldata+1447h]
	mov         ax,word ptr [Ldata+1443h]
	mov         bx,word ptr [Ldata+1445h]
	mov         word ptr [Lbss+0948h],ax
	mov         word ptr [Lbss+094Ah],bx
	jmp         L1CF7
L1CE1::
	mov         ax,3
	Int10h
	ret
	push        eax
	push        ebx
	mov         ax,word ptr [Lbss+0948h]
	mov         bx,word ptr [Lbss+094Ah]
L1CF7:
	dec         ax
	dec         bx
	shl         eax,10h
	shl         ebx,10h
	mov         dword ptr [Lbss+0950h],eax
	mov         dword ptr [Lbss+0954h],ebx
	pop         ebx
	pop         eax
	ret

L1CAD	ENDP

L1D0F	PROC

	push        esi
	push        edx
	xor         eax,eax
	mov         ecx,100h
	mov         esi,offset Lbss+0958h
	mov         dx,3C8h
	PortOut
	inc         edx
	cld
L1D24:
	lods        dword ptr [esi]
	shr         eax,2
	and         eax,3F3F3Fh
	PortOut
	shr         eax,8
	PortOut
	shr         eax,8
	PortOut
	dec         ecx
	jne         L1D24
	pop         edx
	pop         esi
	ret

L1D0F	ENDP

L1D3C	PROC

	push        edi
	push        esi
	push        ecx
	mov         edi,offset Lbss+0958h
	mov         esi,offset Ldata+0DB4h
	mov         ecx,5
	cld
L1D4F:
	movs        word ptr [edi],word ptr [esi]
	movs        byte ptr [edi],byte ptr [esi]
	add         edi,3Dh
	dec         ecx
	jne         L1D4F
	pop         ecx
	pop         esi
	pop         edi
	ret

L1D3C	ENDP

	nop
	nop
	nop
	nop
	mov         al,byte ptr [esp+4]
	movzx       edx,word ptr [esp+6]
	movzx       ecx,word ptr [esp+8]

L1D6E	PROC

	movzx       eax,al
	shl         eax,4
	mov         ebx,dword ptr [Ldata+1437h]
	lea         esi,[ebx+eax]
	mov         edi,edx
	shl         edx,6
	shl         edi,8
	add         edi,edx
	add         edi,ecx
	and         edi,0FFFFh
	add         edi,FrameBuffer
	push        ebp
	mov         ebx,dword ptr [Ldata+143Bh]
	mov         cl,8
	cld
L1D9F:
	mov         dx,word ptr [esi]
	add         esi,2
	mov         ch,4
L1DA7:
	mov         eax,edx
	and         eax,3
	mov         al,byte ptr [ebx+eax*2]
	shr         edx,2
	shrd        ebp,eax,8
	dec         ch
	jne         L1DA7
	mov         dword ptr [edi],ebp
	mov         ch,4
L1DC0:
	mov         eax,edx
	and         eax,3
	mov         al,byte ptr [ebx+eax*2]
	shr         edx,2
	shrd        ebp,eax,8
	dec         ch
	jne         L1DC0
	mov         dword ptr [edi+4],ebp
	add         edi,140h
	dec         cl
	jne         L1D9F
	pop         ebp
	ret

L1D6E	ENDP

L1DE4	PROC

	cmp         word ptr [esp+8],0
	je          L1E14
	mov         esi,dword ptr [esp+4]
	mov         al,byte ptr [esi]
	inc         dword ptr [esp+4]
	movzx       edx,word ptr [esp+0Ah]
	movzx       ecx,word ptr [esp+0Ch]
	call        dword ptr [Ldata+143Fh]
	add         word ptr [esp+0Ch],8
	dec         word ptr [esp+8]
	jne         L1DE4
L1E14:
	ret

L1DE4	ENDP

L1E15	PROC

	mov         ax,word ptr [esp+0Ah]
	mov         word ptr [L1E60],ax
L1E20:
	mov         esi,dword ptr [esp+4]
	mov         al,byte ptr [esi]
	inc         dword ptr [esp+4]
	cmp         al,1
	js          L1E46
	movzx       edx,word ptr [esp+8]
	movzx       ecx,word ptr [esp+0Ah]
	call        dword ptr [Ldata+143Fh]
	add         word ptr [esp+0Ah],8
	jmp         L1E20
L1E46:
	test        al,al
	je          L1E5F
	cmp         al,81h
	mov         ax,word ptr [L1E60]
	mov         word ptr [esp+0Ah],ax
	add         word ptr [esp+8],9
	jmp         L1E20
L1E5F:
	ret

L1E15	ENDP

;L1E60:
;	dw          0

L1E62	PROC

	mov         ax,word ptr [esp+8]
	cmp         ax,word ptr [Lbss+0954h]
	jge         L1E7B
	mov         ax,word ptr [Lbss+0954h]
	mov         word ptr [esp+8],ax
L1E7B:
	mov         bx,word ptr [esp+0Ah]
	cmp         bx,word ptr [Lbss+0956h]
	jle         L1E95
	mov         bx,word ptr [Lbss+0956h]
	mov         word ptr [esp+0Ah],bx
L1E95:
	sub         bx,ax
	js          L1F27
	inc         bx
	mov         edx,140h
	sub         dx,bx
	shl         ebx,10h
	mov         ax,word ptr [esp+4]
	cmp         ax,word ptr [Lbss+0950h]
	jge         L1EC4
	mov         ax,word ptr [Lbss+0950h]
	mov         word ptr [esp+4],ax
L1EC4:
	mov         bx,word ptr [esp+6]
	cmp         bx,word ptr [Lbss+0952h]
	jle         L1EDE
	mov         bx,word ptr [Lbss+0952h]
	mov         word ptr [esp+6],bx
L1EDE:
	sub         bx,ax
	js          L1F27
	inc         bx
	movzx       eax,ax
	mov         edi,eax
	shl         eax,6
	shl         edi,8
	add         edi,eax
	movzx       eax,word ptr [esp+8]
	lea         edi,[eax+edi+FrameBuffer]
	mov         al,byte ptr [esp+0Ch]
	mov         ah,al
	mov         ecx,eax
	shl         eax,10h
	mov         ax,cx
	xor         ecx,ecx
	cld
L1F0F:
	shld        ecx,ebx,0Eh
	rep stos    dword ptr [edi]
	shld        ecx,ebx,10h
	and         ecx,3
	rep stos    byte ptr [edi]
	add         edi,edx
	dec         bx
	jne         L1F0F
L1F27:
	ret

L1E62	ENDP

L1F28	PROC

	push        edi
	push        cx
	mov         ah,al
	mov         cx,ax
	shl         eax,10h
	mov         ax,cx
	mov         ecx,3E80h
	mov         edi,Framebuffer
	cld
	rep stos    dword ptr [edi]
	pop         cx
	pop         edi
	ret

L1F28	ENDP

L1F47	PROC

	mov         eax,100030h
	test        byte ptr [esp+0Ch],1
	je          L1F56
	rol         eax,10h
L1F56:
	push        eax
	mov         dx,word ptr [esp+0Ch]
	mov         cx,word ptr [esp+0Ah]
	mov         bx,word ptr [esp+8]
	push        ax
	push        dx
	push        dx
	push        cx
	push        bx
	call        L1E62
	mov         ax,word ptr [esp+0Ch]
	mov         word ptr [esp+8],ax
	mov         dx,word ptr [esp+18h]
	mov         word ptr [esp+4],dx
	mov         word ptr [esp+6],dx
	call        L1E62
	mov         ax,word ptr [esp+0Ah]
	mov         word ptr [esp+8],ax
	mov         bx,word ptr [esp+12h]
	mov         dx,word ptr [esp+16h]
	mov         word ptr [esp],bx
	mov         word ptr [esp+2],bx
	mov         word ptr [esp+4],dx
	call        L1E62
	mov         ax,word ptr [esp+0Ch]
	mov         word ptr [esp+8],ax
	mov         bx,word ptr [esp+14h]
	mov         word ptr [esp],bx
	mov         word ptr [esp+2],bx
	call        L1E62
	test        byte ptr [esp+1Ah],2
	je          L200E
	add         esp,0Ah
	mov         dx,word ptr [esp+0Eh]
	mov         cx,word ptr [esp+0Ch]
	mov         bx,word ptr [esp+0Ah]
	mov         ax,word ptr [esp+8]
	dec         dx
	inc         cx
	dec         bx
	inc         ax
	pushw       20h
	push        dx
	push        cx
	push        bx
	push        ax
	call        L1E62
L200E:
	add         esp,0Eh
	ret

L1F47	ENDP

L2012	PROC

	cld
	mov         edi,dword ptr [esi]
	movzx       ecx,byte ptr [esi+4]
	test        al,al
	je          L2028
	repne scas  byte ptr [edi]
	jne         L2041
	not         cl
	add         cl,byte ptr [esi+4]
	clc
	ret
L2028:
	add         edi,ecx
	mov         al,ah
	mov         cl,byte ptr [esi+5]
	repne scas  byte ptr [edi]
	jne         L203F
	not         cl
	add         cl,byte ptr [esi+5]
	xor         al,al
	add         cl,byte ptr [esi+4]
	clc
	ret
L203F:
	xor         al,al
L2041:
	stc
	ret

L2012	ENDP

L2043	PROC

	push        ecx
	push        ebx
	mov         ecx,10h
	xor         ebx,ebx
L204C:
	mov         ah,1
	Int16h
	je          L205B
	mov         ah,0
	Int16h
	mov         ebx,eax
	dec         ecx
	jne         L204C
L205B:
	cmp         ecx,10h
	mov         eax,ebx
	pop         ebx
	pop         ecx
	ret

L2043	ENDP

L2066	PROC

	call        L2043
L206B:
	call        L2090
	cmp         al,2
	jae         L207F
	mov         ah,1
	Int16h
	je          L206B
	mov         ah,0
	Int16h
	stc
L207F:
	ret

L2066	ENDP

L2080	PROC

	cmp         byte ptr [Lbss+0010h],0
	je          L208B
	int         33h
L208B:
	ret

L2080	ENDP

	nop
	nop
	nop
	nop

L2090	PROC

	cmp         byte ptr [Lbss+0010h],0
	je          L20FF
	mov         ax,3
	int         33h
	xor         al,al
	mov         ah,byte ptr [Lbss+0013h]
	not         ah
	and         ah,bl
	mov         byte ptr [Lbss+0013h],bl
	mov         byte ptr [Lbss+0012h],ah
	je          L20D5
	mov         esi,dword ptr [0000046Ch]
	mov         ebx,esi
	sub         ebx,dword ptr [Lbss+0018h]
	mov         dword ptr [Lbss+0018h],esi
	mov         dword ptr [Lbss+001Ch],ebx
	or          al,2
L20D5:
	shr         cx,1
	cmp         dx,word ptr [Lbss+0014h]
	jne         L20EA
	cmp         cx,word ptr [Lbss+0016h]
	je          L20FE
L20EA:
	or          al,1
	mov         word ptr [Lbss+0014h],dx
	mov         word ptr [Lbss+0016h],cx
	push        ax
	pop         ax
L20FE:
	ret
L20FF:
	xor         al,al
	ret

L2090	ENDP

L2102	PROC

	mov         dword ptr [Lbss+0024h],offset Ldata+0DDCh
	xor         eax,eax
	int         33h
	cmp         ax,0FFFFh
	jne         L2127
	mov         byte ptr [Lbss+0010h],al
	mov         byte ptr [Lbss+0011h],bl
	call        L2090
	ret
L2127:
	mov         byte ptr [Lbss+0010h],0
	ret

L2102	ENDP

L212F	PROC

	mov         bx,word ptr [Ldata+01A5h]
	mov         byte ptr [Ldata+01A3h],bl
	mov         eax,dword ptr [Ldata+13D8h]
	shr         eax,3
	je          L22DF
	cmp         al,bh
	jbe         L2150
	mov         al,bh
L2150:
	mov         byte ptr [Ldata+01A2h],al
	mov         byte ptr [Ldata+01A4h],al
	movzx       eax,byte ptr [Ldata+142Dh]
	movzx       ecx,byte ptr [Ldata+142Ch]
	mov         byte ptr [Ldata+01A0h],al
	mov         byte ptr [Ldata+01A1h],cl
	mov         al,byte ptr [Ldata+142Eh]
	mov         ebx,dword ptr [Ldata+13D8h]
	mov         edx,dword ptr [Ldata+13D0h]
	shr         ebx,3
	imul        ecx,dword ptr [Ldata+13CCh]
	imul        eax,edx
	imul        ecx,ebx
	mov         dword ptr [Ldata+0194h],eax
	imul        edx,ebx
	mov         dword ptr [Ldata+0190h],ecx
	xor         eax,eax
	mov         dword ptr [Ldata+13DCh],edx
	mov         dword ptr [Ldata+019Ch],eax
	mov         dword ptr [Ldata+0198h],eax
	mov         ebx,dword ptr [Ldata+017Ch]
	mov         dword ptr [Ldata+0180h],ebx
	mov         dword ptr [Ldata+0184h],ebx
	mov         eax,dword ptr [Ldata+13C4h]
	mov         ebx,dword ptr [Lbss+0938h]
	add         eax,ebx
	add         ebx,dword ptr [Lbss+093Ch]
	mov         dword ptr [L2214],ebx
	mov         dword ptr [Ldata+018Ch],eax
	mov         dword ptr [Ldata+0188h],eax
	push        ebp
	cld
L21EB:
	mov         edx,dword ptr [Ldata+019Ch]
	movzx       esi,byte ptr [edx+Ldata+13ECh]
	inc         edx
	imul        esi,dword ptr [Ldata+13D0h]
	mov         dword ptr [Ldata+019Ch],edx
	add         esi,dword ptr [Ldata+0188h]
	mov         edi,dword ptr [Ldata+0180h]
L2212:
;	cmp         esi,0
	cmp         esi,dword ptr [L2214]
	jae         L22E0
	call        dword ptr [Ldata+13E0h]
L2224:
	add         dword ptr [Ldata+0180h],8
	dec         byte ptr [Ldata+01A0h]
	jg          L2255
	mov         al,byte ptr [Ldata+142Dh]
	mov         esi,dword ptr [Ldata+0194h]
	mov         edx,dword ptr [Ldata+0198h]
	add         dword ptr [Ldata+0188h],esi
	mov         dword ptr [Ldata+019Ch],edx
	mov         byte ptr [Ldata+01A0h],al
L2255:
	dec         byte ptr [Ldata+01A4h]
	jg          L21EB
	mov         esi,dword ptr [Ldata+018Ch]
	dec         byte ptr [Ldata+01A1h]
	jg          L228B
	mov         al,byte ptr [Ldata+142Ch]
	xor         edx,edx
	add         esi,dword ptr [Ldata+0190h]
	mov         dword ptr [Ldata+0198h],edx
	mov         dword ptr [Ldata+018Ch],esi
	mov         byte ptr [Ldata+01A1h],al
	jmp         L229A
L228B:
	mov         edx,dword ptr [Ldata+0198h]
	add         edx,8
	mov         dword ptr [Ldata+0198h],edx
L229A:
	mov         al,byte ptr [Ldata+142Dh]
	mov         dword ptr [Ldata+019Ch],edx
	mov         dword ptr [Ldata+0188h],esi
	mov         byte ptr [Ldata+01A0h],al
	mov         edi,dword ptr [Ldata+0184h]
	add         edi,0A00h
	mov         dword ptr [Ldata+0184h],edi
	mov         dword ptr [Ldata+0180h],edi
	mov         al,byte ptr [Ldata+01A2h]
	mov         byte ptr [Ldata+01A4h],al
	dec         byte ptr [Ldata+01A3h]
	jg          L21EB
	pop         ebp
L22DF:
	ret
L22E0:
	call        L26DE
	jmp         L2224

L212F	ENDP

L22EA	PROC

	mov         ebx,dword ptr [Ldata+142Ch]
	mov         eax,ebx
	imul        bh
	cmp         bl,1
	mov         byte ptr [Ldata+142Eh],al
	jbe         L2312
	cmp         bh,1
	jbe         L2312
	cmp         byte ptr [Ldata+13EDh],1
	jbe         L2310
	mov         bh,1
	jmp         L2312
L2310:
	mov         bl,1
L2312:
	cld
	mov         edi,offset Ldata+13ECh
	mov         ecx,40h
	xor         eax,eax
L231F:
	mov         edx,8
L2324:
	stos        byte ptr [edi]
	add         al,bl
	dec         ecx
	jle         L2333
	dec         edx
	jg          L2324
	add         ah,bh
	mov         al,ah
	jmp         L231F
L2333:
	ret

L22EA	ENDP

	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop

L2340	PROC

	mov         ecx,dword ptr [Ldata+13C8h]
	mov         ebx,dword ptr [Ldata+13E4h]
	mov         ch,8
L234E:
	mov         al,cl
	shl         ecx,10h
	mov         cl,al
	xor         edx,edx
	xor         eax,eax
L2359:
	movsx       ebp,byte ptr [ebx]
	add         esi,ebp
	inc         ebx
	mov         ch,byte ptr [esi]
	test        ecx,100h
	je          L236F
	or          edx,1000000h
L236F:
	test        ecx,1000h
	je          L237C
	or          eax,1000000h
L237C:
	test        ecx,200h
	je          L238A
	or          edx,10000h
L238A:
	test        ecx,2000h
	je          L2397
	or          eax,10000h
L2397:
	test        ecx,400h
	je          L23A5
	or          edx,100h
L23A5:
	test        ecx,4000h
	je          L23B2
	or          eax,100h
L23B2:
	test        ecx,800h
	je          L23C0
	or          edx,1
L23C0:
	test        ecx,8000h
	je          L23CD
	or          eax,1
L23CD:
	ror         eax,1
	ror         edx,1
	dec         cl
	jne         L2359
	shr         ecx,10h
	rol         eax,cl
	mov         dword ptr [edi],eax
	rol         edx,cl
	mov         dword ptr [edi+4],edx
	add         edi,dword ptr [Ldata+01A8h]
	dec         ch
	jne         L234E
	ret

L2340	ENDP

L23F0:
	dd          offset L2434
	dd          offset L2434
	dd          offset L2434
	dd          offset L2454
	dd          offset L246C
	dd          offset L246C
	dd          offset L246C
	dd          offset L246C
	dd          offset L248C
L2414:
	dd          8F90800h, 3 dup(8F908F9h), 8F90801h, 3 dup(8F908F9h)
L2434:
	dd          1010100h, 7 dup(1010101h)
L2454:
	dd          0F20F0100h, 1F30E01h, 0C01F40Dh, 0F60B01F5h, 1F70A01h
	dd          801F809h
L246C:
	dd          10F0100h, 7 dup(10F01F1h)
L248C:
	dd          10F0100h, 10F010Fh, 10F01D1h, 10F010Fh, 10F01D1h, 10F010Fh
	dd          10F01D1h, 10F010Fh, 10F01D1h, 10F010Fh, 10F01D1h, 10F010Fh
	dd          10F01D1h, 10F010Fh, 10F01D1h, 10F010Fh

L24CC	PROC

	mov         ch,8
	movzx       ebx,byte ptr [L2508]
	mov         ebp,dword ptr [Ldata+01A8h]
	sub         ebp,8
L24DE:
	mov         cl,2
L24E0:
	mov         al,byte ptr [esi]
	ror         eax,8
	mov         al,byte ptr [esi+ebx]
	lea         esi,[esi+ebx*2]
	ror         eax,8
	mov         al,byte ptr [esi]
	ror         eax,8
	mov         al,byte ptr [esi+ebx]
	lea         esi,[esi+ebx*2]
	ror         eax,8
	stos        dword ptr [edi]
	dec         cl
	jne         L24E0
	add         edi,ebp
	dec         ch
	jne         L24DE
	ret

L24CC	ENDP

;L2508:
;	db          1

L2509	PROC

	mov         ebp,dword ptr [Ldata+01A8h]
	xor         eax,eax
	sub         ebp,8
	mov         ch,8
L2516:
	mov         cl,4
	mov         ebx,dword ptr [esi]
L251A:
	mov         ah,bl
	shr         eax,4
	ror         ebx,8
	shr         al,4
	xchg        al,ah
	stos        word ptr [edi]
	dec         cl
	jne         L251A
	add         esi,4
	add         edi,ebp
	dec         ch
	jne         L2516
	ret

L2509	ENDP

L253B	PROC

	mov         ebp,dword ptr [Ldata+01A8h]
	mov         ch,8
	mov         cl,byte ptr [L2570]
	mov         edx,dword ptr [Ldata+13DCh]
L254F:
	mov         eax,dword ptr [esi]
	shr         eax,cl
	and         eax,0F0F0F0Fh
	mov         dword ptr [edi],eax
	mov         eax,dword ptr [esi+4]
	shr         eax,cl
	and         eax,0F0F0F0Fh
	mov         dword ptr [edi+4],eax
	add         esi,edx
	add         edi,ebp
	dec         ch
	jne         L254F
	ret

L253B	ENDP

;L2570:
;	db          0

L2571	PROC

	mov         ebp,dword ptr [Ldata+01A8h]
	sub         ebp,8
	mov         edx,dword ptr [Ldata+13DCh]
	sub         edx,20h
	xor         ebx,ebx
	mov         ch,8
L2587:
	mov         cl,8
L2589:
	lods        dword ptr [esi]
	mov         bl,ah
	mov         ah,byte ptr [ebx+Ldata+02B4h]
	mov         bl,al
	add         ah,byte ptr [ebx+Ldata+01B4h]
	shr         eax,8
	mov         bl,ah
	add         al,byte ptr [ebx+Ldata+03B4h]
	stos        byte ptr [edi]
	dec         cl
	jne         L2589
	add         esi,edx
	add         edi,ebp
	dec         ch
	jne         L2587
	ret

L2571	ENDP

L25B3	PROC

	mov         ebp,dword ptr [Ldata+01A8h]
	sub         ebp,8
	mov         edx,dword ptr [Ldata+13DCh]
	sub         edx,10h
	xor         ebx,ebx
	mov         ch,8
L25C9:
	mov         cl,8
L25CB:
	lods        word ptr [esi]
	mov         bl,al
	and         bl,3Eh
	shl         ebx,2
	mov         al,byte ptr [ebx+Ldata+03B4h]
	mov         ebx,eax
	and         ebx,7C0h
	shr         ebx,3
	add         al,byte ptr [ebx+Ldata+02B4h]
	mov         bl,ah
	and         bl,0F8h
	add         al,byte ptr [ebx+Ldata+01B4h]
	stos        byte ptr [edi]
	dec         cl
	jne         L25CB
	add         esi,edx
	add         edi,ebp
	dec         ch
	jne         L25C9
	ret

L25B3	ENDP

L2605	PROC

	mov         ebp,dword ptr [Ldata+01A8h]
	sub         ebp,8
	mov         edx,dword ptr [Ldata+13DCh]
	xor         eax,eax
	mov         ch,8
L2618:
	mov         cl,2
	mov         bx,word ptr [esi]
	shl         ebx,8
L2620:
	mov         bl,bh
	mov         eax,ebx
	shr         al,2
	rol         eax,10h
	mov         ax,bx
	shr         al,6
	shr         ah,4
	and         eax,3030303h
	stos        dword ptr [edi]
	shr         ebx,8
	dec         cl
	jne         L2620
	add         esi,edx
	add         edi,ebp
	dec         ch
	jne         L2618
	ret

L2605	ENDP

L2649	PROC

	mov         ebp,dword ptr [Ldata+01A8h]
	sub         ebp,8
	mov         edx,dword ptr [Ldata+13DCh]
	xor         eax,eax
	mov         ch,8
L265C:
	mov         cl,4
	mov         ebx,dword ptr [esi]
L2660:
	mov         ah,bl
	shr         eax,4
	ror         ebx,8
	shr         al,4
	xchg        al,ah
	stos        word ptr [edi]
	dec         cl
	jne         L2660
	add         esi,edx
	add         edi,ebp
	dec         ch
	jne         L265C
	ret

L2649	ENDP

L267C	PROC

	mov         edx,dword ptr [Ldata+13DCh]
	mov         ebp,dword ptr [Ldata+01A8h]
	sub         edx,8
	sub         ebp,8
	mov         cl,8
L2690:
	movs        dword ptr [edi],dword ptr [esi]
	movs        dword ptr [edi],dword ptr [esi]
	add         esi,edx
	add         edi,ebp
	dec         cl
	jne         L2690
	ret

L267C	ENDP

L269B	PROC

	mov         ebp,dword ptr [Ldata+01A8h]
	xor         eax,eax
	sub         ebp,8
	mov         ch,8
L26A8:
	mov         cl,2
	mov         bx,word ptr [esi]
	shl         ebx,8
L26B0:
	mov         bl,bh
	mov         eax,ebx
	shr         al,4
	shr         ah,6
	rol         eax,10h
	mov         ax,bx
	shr         ah,2
	and         eax,3030303h
	stos        dword ptr [edi]
	shr         ebx,8
	dec         cl
	jne         L26B0
	add         esi,2
	add         edi,ebp
	dec         ch
	jne         L26A8
	ret

L269B	ENDP

L26DE	PROC

	mov         ecx,8
	mov         eax,200020h
	mov         edx,dword ptr [Ldata+01A8h]
L26EE:
	mov         dword ptr [edi],eax
	mov         dword ptr [edi+4],eax
	add         edi,edx
	rol         eax,8
	dec         ecx
	jne         L26EE
	ret

L26DE	ENDP

;	mov         edi,offset Lbss+0958h

L2701	PROC

	mov         edx,100h
	cld
L2707:
	lods        word ptr [esi]
	shl         eax,3
	stos        byte ptr [edi]
	shr         eax,5
	and         eax,1FF8h
	shl         ah,3
	stos        word ptr [edi]
	dec         edx
	jne         L2707
	ret

L2701	ENDP

L271E	PROC

	push        eax
	push        ebx
	push        ecx
	push        edx
	push        esi
	push        edi
	cmp         word ptr [Ldata+01ACh],0
	jne         L283F
	cmp         word ptr [Ldata+01AEh],0
	jne         L283F
	mov         edx,dword ptr [esp+1Ch]
	cmp         edx,0
	je          L2771
	cmp         edx,100h
	jbe         L283F
	mov         ecx,edx
	shld        ebx,edx,10h
	mov         ax,501h
	Int31h
	jb          L283F
	jmp         L27A9
L2771:
	sub         esp,36h
	mov         edi,esp
	mov         ax,500h
	Int31h
	pop         edx
	lea         esp,[esp+32h]
L2784:
	cmp         edx,1000h
	jb          L283F
	mov         ecx,edx
	shld        ebx,edx,10h
	mov         ax,501h
	Int31h
	jae         L27A9
	sub         edx,1000h
	jmp         L2784
L27A9:
	mov         word ptr [Ldata+01ACh],si
	mov         word ptr [Ldata+01AEh],di
	shl         ebx,10h
	mov         bx,cx
	add         ebx,7
	and         ebx,0FFFFFFF8h
	mov         dword ptr [Lbss+0634h],ebx
	mov         dword ptr [ebx],edx
	and         edx,0FFFFFFF8h
	sub         edx,30h
	mov         dword ptr [ebx+4],edx
	mov         eax,ebx
	add         eax,10h
	mov         ecx,dword ptr [Lbss+0634h]
	add         ecx,dword ptr [ebx+4]
	mov         dword ptr [ebx+8],ecx
	mov         dword ptr [ecx-10h],0
	mov         dword ptr [ecx-0Ch],0
	mov         dword ptr [ecx-8],0
	mov         dword ptr [ecx-4],0
	mov         dword ptr [ebx+0Ch],eax
	mov         dword ptr [eax],edx
	mov         dword ptr [eax+4],45455246h
	mov         dword ptr [eax+8],0
	mov         dword ptr [eax+0Ch],0
	push        offset L2B84
	call        L2BB2
	lea         esp,[esp+4]
	pop         edi
	pop         esi
	pop         edx
	pop         ecx
	pop         ebx
	pop         eax
	clc
	ret
L283F:
	pop         edi
	pop         esi
	pop         edx
	pop         ecx
	pop         ebx
	pop         eax
	stc
	ret

L271E	ENDP

L2847	PROC

	push        eax
	push        ecx
	push        edx
	push        esi
	mov         ecx,dword ptr [esp+14h]
	add         ecx,7
	and         ecx,0FFFFFFF8h
	mov         esi,dword ptr [Lbss+0634h]
	mov         esi,dword ptr [esi+0Ch]
	or          esi,esi
	je          L2877
	xor         eax,eax

L286A:
	cmp         ecx,dword ptr [esi]
	jbe         L2887
	mov         eax,esi
	mov         esi,dword ptr [esi+8]
	or          esi,esi
	jne         L286A

L2877:
	mov         dword ptr [Lbss+0628h],0
	pop         esi
	pop         edx
	pop         ecx
	pop         eax
	stc
	ret

L2887:
	mov         edx,dword ptr [esi]
	sub         edx,10h
	cmp         ecx,edx
	ja          L28F3
	push        eax
	mov         eax,esi
	add         eax,ecx
	add         eax,8
	mov         edx,dword ptr [esi]
	mov         dword ptr [eax],edx
	sub         dword ptr [eax],ecx
	sub         dword ptr [eax],8
	mov         edx,dword ptr [esi+8]
	mov         dword ptr [eax+4],45455246h
	mov         dword ptr [eax+8],edx
	mov         dword ptr [eax+0Ch],esi
	mov         edx,dword ptr [Lbss+0634h]
	cmp         dword ptr [edx+0Ch],esi
	jne         L28C7
	mov         dword ptr [edx+0Ch],eax

L28C7:
	mov         dword ptr [esi],ecx
	sub         dword ptr [edx+4],ecx
	sub         dword ptr [edx+4],8
	mov         edx,dword ptr [esi+0Ch]
	mov         dword ptr [esi+4],edx
	add         esi,8
	mov         dword ptr [Lbss+0628h],esi
	pop         ecx
	or          ecx,ecx
	je          L28ED
	mov         dword ptr [ecx+8],eax

L28ED:
	pop         esi
	pop         edx
	pop         ecx
	pop         eax
	clc
	ret

L28F3:
	push        eax
	push        dword ptr [esi+8]
	mov         dword ptr [esi],ecx
	mov         edx,dword ptr [esi+0Ch]
	mov         dword ptr [esi+4],edx
	mov         eax,dword ptr [esi+8]
	mov         edx,dword ptr [Lbss+0634h]
	cmp         dword ptr [edx+0Ch],esi
	jne         L2910
	mov         dword ptr [edx+0Ch],eax

L2910:
	sub         dword ptr [edx+4],ecx
	sub         dword ptr [edx+4],8
	add         esi,8
	mov         dword ptr [Lbss+0628h],esi
	pop         esi
	pop         eax
	mov         dword ptr [eax+8],esi
	pop         esi
	pop         edx
	pop         ecx
	pop         eax
	clc
	ret

L2847	ENDP

L2931	PROC

	push        eax
	push        ebx
	push        ecx
	push        edx
	push        esi
	mov         esi,dword ptr [esp+18h]
	mov         ebx,dword ptr [Lbss+0634h]
	lea         ecx,[ebx+10h]
	mov         edx,esi
	sub         esi,8
	mov         eax,dword ptr [esi+4]
	cmp         eax,45455246h
	je          L2B7D
	or          eax,eax
	jne         L296A
	cmp         esi,ecx
	jne         L2B7D
	jmp         L29A6

L296A:
	cmp         eax,ecx
	jb          L2B7D
	cmp         eax,dword ptr [ebx+8]
	jae         L2B7D
	and         edx,7
	jne         L2B7D
	add         eax,dword ptr [eax]
	add         eax,8
	cmp         eax,esi
	jne         L2B7D
	mov         eax,dword ptr [esi+4]
	cmp         dword ptr [eax+4],45455246h
	je          L2AB9

L29A6:
	lea         eax,[esi+8]
	add         eax,dword ptr [esi]
	cmp         eax,dword ptr [ebx+8]
	jae         L2A81
	cmp         dword ptr [eax+4],45455246h
	jne         L2A1B
	mov         ecx,dword ptr [esi]
	add         ecx,8
	add         dword ptr [ebx+4],ecx
	mov         ecx,dword ptr [eax]
	add         ecx,8
	add         dword ptr [esi],ecx
	mov         ecx,dword ptr [eax+8]
	mov         dword ptr [esi+8],ecx
	mov         ecx,dword ptr [esi+4]
	mov         dword ptr [esi+0Ch],ecx
	mov         dword ptr [esi+4],45455246h
	add         eax,dword ptr [eax]
	add         eax,8
	cmp         eax,dword ptr [ebx+8]
	jae         L29F4
	mov         dword ptr [eax+4],esi

L29F4:
	cmp         esi,dword ptr [ebx+0Ch]
	jae         L29FC
	mov         dword ptr [ebx+0Ch],esi

L29FC:
	mov         eax,esi
	lea         esi,[esi+8]

L2A01:
	mov         esi,dword ptr [esi+4]
	or          esi,esi
	je          L2A14
	cmp         dword ptr [esi+4],45455246h
	jne         L2A01
	mov         dword ptr [esi+8],eax

L2A14:
	pop         esi
	pop         edx
	pop         ecx
	pop         ebx
	pop         eax
	clc
	ret

L2A1B:
	mov         eax,dword ptr [esi+4]
	mov         dword ptr [esi+4],45455246h
	mov         dword ptr [esi+0Ch],eax
	mov         eax,esi
	lea         esi,[esi+8]

L2A2D:
	mov         esi,dword ptr [esi+4]
	or          esi,esi
	je          L2A40
	cmp         dword ptr [esi+4],45455246h
	jne         L2A2D
	mov         dword ptr [esi+8],eax

L2A40:
	mov         esi,eax
	cmp         esi,dword ptr [ebx+0Ch]
	jae         L2A4A
	mov         dword ptr [ebx+0Ch],esi

L2A4A:
	add         eax,dword ptr [eax]
	add         eax,8
	cmp         eax,dword ptr [ebx+8]
	jae         L2A6E
	cmp         dword ptr [eax+4],45455246h
	jne         L2A4A
	mov         dword ptr [esi+8],eax
	mov         ecx,dword ptr [esi]
	add         dword ptr [ebx+4],ecx
	pop         esi
	pop         edx
	pop         ecx
	pop         ebx
	pop         eax
	clc
	ret

L2A6E:
	mov         dword ptr [esi+8],0
	mov         ecx,dword ptr [esi]
	add         dword ptr [ebx+4],ecx
	pop         esi
	pop         edx
	pop         ecx
	pop         ebx
	pop         eax
	clc
	ret

L2A81:
	mov         eax,dword ptr [esi+4]
	mov         dword ptr [esi+4],45455246h
	mov         dword ptr [esi+8],0
	mov         dword ptr [esi+0Ch],eax
	mov         ecx,dword ptr [esi]
	add         dword ptr [ebx+4],ecx
	mov         eax,esi
	lea         esi,[esi+8]

L2A9F:
	mov         esi,dword ptr [esi+4]
	or          esi,esi
	je          L2AB2
	cmp         dword ptr [esi+4],45455246h
	jne         L2A9F
	mov         dword ptr [esi+8],eax

L2AB2:
	pop         esi
	pop         edx
	pop         ecx
	pop         ebx
	pop         eax
	clc
	ret

L2AB9:
	lea         ecx,[esi+8]
	add         ecx,dword ptr [esi]
	cmp         ecx,dword ptr [ebx+8]
	jae         L2ACC
	cmp         dword ptr [ecx+4],45455246h
	je          L2B25

L2ACC:
	mov         ecx,dword ptr [eax]
	add         ecx,8
	sub         dword ptr [ebx+4],ecx
	mov         ecx,dword ptr [esi]
	add         ecx,8
	add         dword ptr [eax],ecx
	mov         ecx,esi
	add         ecx,dword ptr [ecx]
	add         ecx,8
	cmp         ecx,dword ptr [ebx+8]
	jae         L2AF3
	mov         dword ptr [ecx+4],eax

L2AF3:
	mov         esi,dword ptr [esi+8]
	mov         dword ptr [eax+8],esi
	cmp         eax,dword ptr [ebx+0Ch]
	jae         L2B01
	mov         dword ptr [ebx+0Ch],eax

L2B01:
	mov         ecx,dword ptr [esi]
	add         dword ptr [ebx+4],ecx
	mov         esi,eax
	lea         esi,[esi+8]

L2B0B:
	mov         esi,dword ptr [esi+4]
	or          esi,esi
	je          L2B1E
	cmp         dword ptr [esi+4],45455246h
	jne         L2B0B
	mov         dword ptr [esi+8],eax

L2B1E:
	pop         esi
	pop         edx
	pop         ecx
	pop         ebx
	pop         eax
	clc
	ret

L2B25:
	mov         edx,dword ptr [ecx]
	add         dword ptr [eax],edx
	mov         edx,dword ptr [esi]
	add         edx,10h
	add         dword ptr [eax],edx
	mov         edx,dword ptr [ecx+8]
	mov         dword ptr [eax+8],edx
	mov         edx,ecx
	add         edx,dword ptr [edx]
	add         edx,8
	cmp         edx,dword ptr [ebx+8]
	jae         L2B4B
	mov         dword ptr [edx+4],eax

L2B4B:
	mov         ecx,dword ptr [esi]
	add         ecx,10h
	add         dword ptr [ebx+4],ecx
	cmp         eax,dword ptr [ebx+0Ch]
	jae         L2B5E
	mov         dword ptr [ebx+0Ch],eax

L2B5E:
	mov         esi,eax
	lea         esi,[esi+8]

L2B63:
	mov         esi,dword ptr [esi+4]
	or          esi,esi
	je          L2B76
	cmp         dword ptr [esi+4],45455246h
	jne         L2B63
	mov         dword ptr [esi+8],eax

L2B76:
	pop         esi
	pop         edx
	pop         ecx
	pop         ebx
	pop         eax
	clc
	ret

L2B7D:
	pop         esi
	pop         edx
	pop         ecx
	pop         ebx
	pop         eax
	stc
	ret

L2931	ENDP

L2B84	PROC

	push        eax
	push        esi
	push        edi
	mov         si,word ptr [Ldata+01ACh]
	mov         di,word ptr [Ldata+01AEh]
	mov         ax,502h
	Int31h
	mov         word ptr [Ldata+01ACh],0
	mov         word ptr [Ldata+01AEh],0
	pop         edi
	pop         esi
	pop         eax
	clc
	ret

L2B84	ENDP

L2BB2	PROC

	push        eax
	push        ebx
	cmp         dword ptr [Ldata+01B0h],40h
	je          L2BE0
	mov         eax,offset Lbss+0638h
	mov         ebx,dword ptr [Ldata+01B0h]
	shl         ebx,2
	add         eax,ebx
	mov         ebx,dword ptr [esp+0Ch]
	mov         dword ptr [eax],ebx
	inc         dword ptr [Ldata+01B0h]
	pop         ebx
	pop         eax
	clc
	ret

L2BE0:
	pop         ebx
	pop         eax
	stc
	ret

L2BB2	ENDP

L2BE4	PROC

	mov         ecx,dword ptr [Ldata+01B0h]
	or          ecx,ecx
	je          L2C0C
	dec         ecx
	mov         esi,offset Lbss+0638h
	shl         ecx,2
	add         esi,ecx
	shr         ecx,2
	inc         ecx

L2BFD:
	push        ecx
	push        esi
	call        dword ptr [esi]
	pop         esi
	pop         ecx
	sub         esi,4
	dec         ecx
	jne         L2BFD

L2C0C:
	ret

L2BE4	ENDP

.DATA

Ldata\
	dd 0	; 3000
	dd offset Ldata+00DBh	; 3004
	dd 9	; 3008
	dd offset Ldata+00E5h	; 300C
	dd 0Ch	; 3010
	dd offset L11AC	; 3014
	dd offset L11B6	; 3018
	dd offset L1276	; 301C
	dd offset L127A	; 3020
	dd offset L12C7	; 3024
	dd offset L12D1	; 3028
	dd offset L12DB	; 302C
	dd offset L12E5	; 3030
	dd offset L11C0	; 3034
	dd offset L11D1	; 3038
	dd offset L11E6	; 303C
	dd offset L11E2	; 3040
	dd offset L11F8	; 3044
	dd offset L11F8	; 3048
	dd offset L11F8	; 304C
	dd offset L11F8	; 3050
	dd offset L11F8	; 3054
	dd offset L123E	; 3058
	dd offset L1268	; 305C
	dd offset L125A	; 3060
	dd offset L124C	; 3064
	dd offset L129E	; 3068
	dd offset L12EF	; 306C
	dd offset L1170	; 3070
	dd offset L117A	; 3074
	dd offset L1184	; 3078
	dd offset L118E	; 307C
	dd offset L115C	; 3080
	dd offset L1166	; 3084
	dd offset L1148	; 3088
	dd offset L1152	; 308C
	dd offset L1198	; 3090
	dd offset L11A2	; 3094
	dd offset L12B4	; 3098
	dd offset L12BB	; 309C
	dd offset L12F0	; 30A0
	dd offset Ldata+00AAh	; 30A4
	db 017h, 00Dh, 05Bh, 05Dh, 02Ch, 02Eh, 02Fh, 02Ah	; 30A8
	db 02Dh, 02Bh, 07Bh, 07Dh, 070h, 050h, 031h, 032h, 033h, 034h, 038h, 035h, 036h, 037h, 039h, 068h	; 30B0
	db 01Bh, 048h, 050h, 049h, 051h, 04Bh, 04Dh, 073h, 074h, 084h, 076h, 047h, 04Fh, 03Bh, 030h, 030h	; 30C0
	db 030h, 030h, 030h, 030h, 030h, 020h, 030h, 030h, 030h, 030h, 020h, 024h, 024h, 024h, 024h, 024h	; 30D0
	db 024h, 024h, 024h, 024h, 020h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h	; 30E0
	db 024h, 020h, 039h, 078h, 039h, 090h, 090h, 090h	; 30F0

	dd offset Ldata+0110h	; 30F8
	dd offset Ldata+011Dh	; 30FC
	dd offset Ldata+012Ah	; 3100
	dd offset Ldata+0137h	; 3104
	dd offset Ldata+0144h	; 3108
	dd offset Ldata+0151h	; 310C

	db " Default VGA", 0	; 3110
	db "     Rainbow", 0	; 311D
	db "        Gray", 0	; 312A
	db "Inverse gray", 0	; 3137
	db "  True color", 0	; 3144
	db "    User:000", 0	; 3151

	db 002h, 03Fh	; 315E
	db 000h, 002h, 068h, 000h, 002h, 070h, 000h, 002h, 067h, 000h, 000h, 090h	; 3160

	dd offset L1BAA	; 316C
	dd offset L1BA3	; 3170
	dd offset L1BCD	; 3174
	dd offset L1BB1	; 3178

	dd FrameBuffer+03C4h	; 317C
	dd 0A0000h	; 3180
	dd 0A0000h	; 3184
	dd 0	; 3188
	dd 0	; 318C
	dd 200h	; 3190
	dd 20h	; 3194
	dd 0	; 3198
	dd 0	; 319C
	db 1	; 31A0
	db 1	; 31A1
	db 10h	; 31A2
	db 18h	; 31A3
	db 10h	; 31A4
	dw 2016h	; 31A5
	db 90h	; 31A7
	dd 140h	; 31A8
	dw 0	; 31AC
	dw 0	; 31AE
	dd 0	; 31B0

	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 31B4
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 31C4
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 001h, 001h, 001h, 001h, 001h	; 31D4
	db 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h	; 31E4
	db 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h, 001h	; 31F4
	db 001h, 001h, 001h, 001h, 001h, 001h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h	; 3204
	db 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h	; 3214
	db 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h, 002h	; 3224
	db 002h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h	; 3234
	db 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h	; 3244
	db 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h, 004h, 004h, 004h, 004h	; 3254
	db 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h	; 3264
	db 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h, 004h	; 3274
	db 004h, 004h, 004h, 004h, 004h, 004h, 004h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h	; 3284
	db 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h	; 3294
	db 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h, 005h	; 32A4

	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 32B4
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 32C4
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 006h, 006h, 006h, 006h, 006h	; 32D4
	db 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h	; 32E4
	db 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h, 006h	; 32F4
	db 006h, 006h, 006h, 006h, 006h, 006h, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch	; 3304
	db 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch	; 3314
	db 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch, 00Ch	; 3324
	db 00Ch, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h	; 3334
	db 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h	; 3344
	db 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 012h, 018h, 018h, 018h, 018h	; 3354
	db 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h	; 3364
	db 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h, 018h	; 3374
	db 018h, 018h, 018h, 018h, 018h, 018h, 018h, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh	; 3384
	db 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh	; 3394
	db 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh, 01Eh	; 33A4

	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 33B4
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 33C0
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 024h, 024h, 024h, 024h, 024h	; 33D0
	db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h	; 33E0
	db 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h, 024h	; 33F0
	db 024h, 024h, 024h, 024h, 024h, 024h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h	; 3400
	db 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h	; 3410
	db 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h, 048h	; 3420
	db 048h, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch	; 3430
	db 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch	; 3440
	db 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 06Ch, 090h, 090h, 090h, 090h	; 3450
	db 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h	; 3460
	db 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h, 090h	; 3470
	db 090h, 090h, 090h, 090h, 090h, 090h, 090h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h	; 3480
	db 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h	; 3490
	db 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h, 0B4h	; 34A0

	db 000h, 000h, 000h, 080h, 0ECh, 010h, 084h, 0E8h, 00Ch, 088h, 0E8h, 00Ch, 08Ch, 0E4h, 00Ch, 090h	; 34B4
	db 0E4h, 008h, 090h, 0E0h, 008h, 094h, 0E0h, 008h, 098h, 0DCh, 008h, 09Ch, 0DCh, 004h, 09Ch, 0D8h	; 34C4
	db 004h, 0A0h, 0D8h, 004h, 0A4h, 0D4h, 004h, 0A8h, 0D4h, 004h, 0A8h, 0D0h, 000h, 0ACh, 0D0h, 000h	; 34D4
	db 0B0h, 0CCh, 000h, 0B0h, 0C8h, 000h, 0B4h, 0C8h, 000h, 0B8h, 0C4h, 000h, 0BCh, 0C0h, 000h, 0BCh	; 34E4
	db 0C0h, 000h, 0C0h, 0BCh, 000h, 0C4h, 0B8h, 000h, 0C4h, 0B8h, 000h, 0C8h, 0B4h, 000h, 0CCh, 0B0h	; 34F4
	db 000h, 0CCh, 0B0h, 000h, 0D0h, 0ACh, 000h, 0D0h, 0A8h, 000h, 0D4h, 0A4h, 004h, 0D8h, 0A4h, 004h	; 3504
	db 0D8h, 0A0h, 004h, 0DCh, 09Ch, 004h, 0DCh, 098h, 004h, 0E0h, 098h, 008h, 0E0h, 094h, 008h, 0E4h	; 3514
	db 090h, 008h, 0E4h, 08Ch, 008h, 0E8h, 088h, 00Ch, 0E8h, 088h, 00Ch, 0E8h, 084h, 010h, 0ECh, 080h	; 3524
	db 010h, 0ECh, 07Ch, 010h, 0F0h, 07Ch, 014h, 0F0h, 078h, 014h, 0F0h, 074h, 018h, 0F4h, 070h, 018h	; 3534
	db 0F4h, 06Ch, 018h, 0F4h, 06Ch, 01Ch, 0F8h, 068h, 01Ch, 0F8h, 064h, 020h, 0F8h, 060h, 020h, 0F8h	; 3544
	db 060h, 024h, 0F8h, 05Ch, 028h, 0FCh, 058h, 028h, 0FCh, 054h, 02Ch, 0FCh, 054h, 02Ch, 0FCh, 050h	; 3554
	db 030h, 0FCh, 04Ch, 034h, 0FCh, 04Ch, 034h, 0FCh, 048h, 038h, 0FCh, 044h, 038h, 0FCh, 040h, 03Ch	; 3564
	db 0FCh, 040h, 040h, 0FCh, 03Ch, 040h, 0FCh, 038h, 044h, 0FCh, 038h, 048h, 0FCh, 034h, 04Ch, 0FCh	; 3574
	db 034h, 04Ch, 0FCh, 030h, 050h, 0FCh, 02Ch, 054h, 0FCh, 02Ch, 054h, 0FCh, 028h, 058h, 0F8h, 028h	; 3584
	db 05Ch, 0F8h, 024h, 060h, 0F8h, 020h, 060h, 0F8h, 020h, 064h, 0F8h, 01Ch, 068h, 0F4h, 01Ch, 06Ch	; 3594
	db 0F4h, 018h, 06Ch, 0F4h, 018h, 070h, 0F0h, 018h, 074h, 0F0h, 014h, 078h, 0F0h, 014h, 07Ch, 0ECh	; 35A4
	db 010h, 07Ch, 0ECh, 010h, 080h, 0E8h, 010h, 084h, 0E8h, 00Ch, 088h, 0E8h, 00Ch, 088h, 0E4h, 008h	; 35B4
	db 08Ch, 0E4h, 008h, 090h, 0E0h, 008h, 094h, 0E0h, 008h, 098h, 0DCh, 004h, 098h, 0DCh, 004h, 09Ch	; 35C4
	db 0D8h, 004h, 0A0h, 0D8h, 004h, 0A4h, 0D4h, 004h, 0A4h, 0D0h, 000h, 0A8h, 0D0h, 000h, 0ACh, 0CCh	; 35D4
	db 000h, 0B0h, 0CCh, 000h, 0B0h, 0C8h, 000h, 0B4h, 0C4h, 000h, 0B8h, 0C4h, 000h, 0B8h, 0C0h, 000h	; 35E4
	db 0BCh, 0BCh, 000h, 0C0h, 0BCh, 000h, 0C0h, 0B8h, 000h, 0C4h, 0B4h, 000h, 0C8h, 0B0h, 000h, 0C8h	; 35F4
	db 0B0h, 000h, 0CCh, 0ACh, 000h, 0D0h, 0A8h, 000h, 0D0h, 0A8h, 004h, 0D4h, 0A4h, 004h, 0D4h, 0A0h	; 3604
	db 004h, 0D8h, 09Ch, 004h, 0D8h, 09Ch, 004h, 0DCh, 098h, 008h, 0DCh, 094h, 008h, 0E0h, 090h, 008h	; 3614
	db 0E0h, 090h, 008h, 0E4h, 08Ch, 00Ch, 0E4h, 088h, 00Ch, 0E8h, 084h, 00Ch, 0E8h, 080h, 010h, 0ECh	; 3624
	db 080h, 010h, 0ECh, 07Ch, 014h, 0F0h, 078h, 014h, 0F0h, 074h, 014h, 0F0h, 074h, 018h, 0F4h, 070h	; 3634
	db 018h, 0F4h, 06Ch, 01Ch, 0F4h, 068h, 01Ch, 0F4h, 064h, 020h, 0F8h, 064h, 020h, 0F8h, 060h, 024h	; 3644
	db 0F8h, 05Ch, 024h, 0F8h, 058h, 028h, 0FCh, 058h, 028h, 0FCh, 054h, 02Ch, 0FCh, 050h, 030h, 0FCh	; 3654
	db 04Ch, 030h, 0FCh, 04Ch, 034h, 0FCh, 048h, 038h, 0FCh, 044h, 038h, 0FCh, 044h, 03Ch, 0FCh, 040h	; 3664
	db 040h, 0FCh, 03Ch, 040h, 0FCh, 03Ch, 044h, 0FCh, 038h, 048h, 0FCh, 034h, 048h, 0FCh, 034h, 04Ch	; 3674
	db 0FCh, 030h, 050h, 0FCh, 02Ch, 050h, 0FCh, 02Ch, 054h, 0FCh, 028h, 058h, 0FCh, 028h, 05Ch, 0F8h	; 3684
	db 024h, 05Ch, 0F8h, 024h, 060h, 0F8h, 020h, 064h, 0F8h, 020h, 068h, 0F8h, 01Ch, 068h, 0F4h, 01Ch	; 3694
	db 06Ch, 0F4h, 018h, 070h, 0F4h, 018h, 074h, 0F0h, 014h, 078h, 0F0h, 014h, 078h, 0F0h, 010h, 07Ch	; 36A4
	db 0ECh, 010h, 080h, 0ECh, 010h, 084h, 0ECh, 00Ch, 084h, 0E8h, 00Ch, 088h, 0E8h, 00Ch, 08Ch, 0E4h	; 36B4
	db 008h, 090h, 0E4h, 008h, 094h, 0E0h, 008h, 094h, 0E0h, 004h, 098h, 0DCh, 004h, 09Ch, 0DCh, 004h	; 36C4
	db 0A0h, 0D8h, 004h, 0A0h, 0D8h, 004h, 0A4h, 0D4h, 000h, 0A8h, 0D4h, 000h, 0ACh, 0D0h, 000h, 0ACh	; 36D4
	db 0CCh, 000h, 0B0h, 0CCh, 000h, 0B4h, 0C8h, 000h, 0B4h, 0C4h, 000h, 0B8h, 0C4h, 000h, 0BCh, 0C0h	; 36E4
	db 000h, 0C0h, 0BCh, 000h, 0C0h, 0BCh, 000h, 0C4h, 0B8h, 000h, 0C4h, 0B4h, 000h, 0C8h, 0B4h, 000h	; 36F4
	db 0CCh, 0B0h, 000h, 0CCh, 0ACh, 000h, 0D0h, 0ACh, 000h, 0D4h, 0A8h, 004h, 0D4h, 0A4h, 004h, 0D8h	; 3704
	db 0A0h, 004h, 0D8h, 0A0h, 004h, 0DCh, 09Ch, 004h, 0DCh, 098h, 008h, 0E0h, 094h, 008h, 0E0h, 094h	; 3714
	db 008h, 0E4h, 090h, 00Ch, 0E4h, 08Ch, 00Ch, 0E8h, 088h, 00Ch, 0E8h, 084h, 010h, 0ECh, 084h, 010h	; 3724
	db 0ECh, 080h, 010h, 0ECh, 07Ch, 014h, 0F0h, 078h, 014h, 0F0h, 078h, 018h, 0F0h, 074h, 018h, 0F4h	; 3734
	db 070h, 01Ch, 0F4h, 06Ch, 01Ch, 0F4h, 068h, 020h, 0F8h, 068h, 020h, 0F8h, 064h, 024h, 0F8h, 060h	; 3744
	db 024h, 0F8h, 05Ch, 028h, 0F8h, 05Ch, 028h, 0FCh, 058h, 02Ch, 0FCh, 054h, 02Ch, 0FCh, 050h, 030h	; 3754
	db 0FCh, 050h, 034h, 0FCh, 04Ch, 034h, 0FCh, 048h, 038h, 0FCh, 048h, 03Ch, 0FCh, 044h, 03Ch, 0FCh	; 3764
	db 040h, 040h, 0FCh, 040h, 044h, 0FCh, 03Ch, 044h, 0FCh, 038h, 048h, 0FCh, 038h, 04Ch, 0FCh, 034h	; 3774
	db 04Ch, 0FCh, 030h, 050h, 0FCh, 030h, 054h, 0FCh, 02Ch, 058h, 0FCh, 028h, 058h, 0FCh, 028h, 05Ch	; 3784
	db 0F8h, 024h, 060h, 0F8h, 024h, 064h, 0F8h, 020h, 064h, 0F8h, 020h, 068h, 0F4h, 01Ch, 06Ch, 0F4h	; 3794
	db 01Ch, 070h, 0F4h, 018h, 074h, 0F4h, 018h, 074h, 0F0h, 014h, 078h, 0F0h, 014h, 07Ch, 0F0h, 014h	; 37A4

	db 000h, 000h, 000h, 000h, 000h, 0A8h, 000h, 0A8h, 000h, 000h, 0A8h, 0A8h, 0A8h, 000h, 000h, 0A8h	; 37B4
	db 000h, 0A8h, 0A8h, 054h, 000h, 0A8h, 0A8h, 0A8h, 054h, 054h, 054h, 054h, 054h, 0FCh, 054h, 0FCh	; 37C4
	db 054h, 054h, 0FCh, 0FCh, 0FCh, 054h, 054h, 0FCh, 054h, 0FCh, 0FCh, 0FCh, 054h, 0FCh, 0FCh, 0FCh	; 37D4
	db 000h, 000h, 000h, 014h, 014h, 014h, 020h, 020h, 020h, 02Ch, 02Ch, 02Ch, 038h, 038h, 038h, 044h	; 37E4
	db 044h, 044h, 050h, 050h, 050h, 060h, 060h, 060h, 070h, 070h, 070h, 080h, 080h, 080h, 090h, 090h	; 37F4
	db 090h, 0A0h, 0A0h, 0A0h, 0B4h, 0B4h, 0B4h, 0C8h, 0C8h, 0C8h, 0E0h, 0E0h, 0E0h, 0FCh, 0FCh, 0FCh	; 3804
	db 000h, 000h, 0FCh, 040h, 000h, 0FCh, 07Ch, 000h, 0FCh, 0BCh, 000h, 0FCh, 0FCh, 000h, 0FCh, 0FCh	; 3814
	db 000h, 0BCh, 0FCh, 000h, 07Ch, 0FCh, 000h, 040h, 0FCh, 000h, 000h, 0FCh, 040h, 000h, 0FCh, 07Ch	; 3824
	db 000h, 0FCh, 0BCh, 000h, 0FCh, 0FCh, 000h, 0BCh, 0FCh, 000h, 07Ch, 0FCh, 000h, 040h, 0FCh, 000h	; 3834
	db 000h, 0FCh, 000h, 000h, 0FCh, 040h, 000h, 0FCh, 07Ch, 000h, 0FCh, 0BCh, 000h, 0FCh, 0FCh, 000h	; 3844
	db 0BCh, 0FCh, 000h, 07Ch, 0FCh, 000h, 040h, 0FCh, 07Ch, 07Ch, 0FCh, 09Ch, 07Ch, 0FCh, 0BCh, 07Ch	; 3854
	db 0FCh, 0DCh, 07Ch, 0FCh, 0FCh, 07Ch, 0FCh, 0FCh, 07Ch, 0DCh, 0FCh, 07Ch, 0BCh, 0FCh, 07Ch, 09Ch	; 3864
	db 0FCh, 07Ch, 07Ch, 0FCh, 09Ch, 07Ch, 0FCh, 0BCh, 07Ch, 0FCh, 0DCh, 07Ch, 0FCh, 0FCh, 07Ch, 0DCh	; 3874
	db 0FCh, 07Ch, 0BCh, 0FCh, 07Ch, 09Ch, 0FCh, 07Ch, 07Ch, 0FCh, 07Ch, 07Ch, 0FCh, 09Ch, 07Ch, 0FCh	; 3884
	db 0BCh, 07Ch, 0FCh, 0DCh, 07Ch, 0FCh, 0FCh, 07Ch, 0DCh, 0FCh, 07Ch, 0BCh, 0FCh, 07Ch, 09Ch, 0FCh	; 3894
	db 0B4h, 0B4h, 0FCh, 0C4h, 0B4h, 0FCh, 0D8h, 0B4h, 0FCh, 0E8h, 0B4h, 0FCh, 0FCh, 0B4h, 0FCh, 0FCh	; 38A4
	db 0B4h, 0E8h, 0FCh, 0B4h, 0D8h, 0FCh, 0B4h, 0C4h, 0FCh, 0B4h, 0B4h, 0FCh, 0C4h, 0B4h, 0FCh, 0D8h	; 38B4
	db 0B4h, 0FCh, 0E8h, 0B4h, 0FCh, 0FCh, 0B4h, 0E8h, 0FCh, 0B4h, 0D8h, 0FCh, 0B4h, 0C4h, 0FCh, 0B4h	; 38C4
	db 0B4h, 0FCh, 0B4h, 0B4h, 0FCh, 0C4h, 0B4h, 0FCh, 0D8h, 0B4h, 0FCh, 0E8h, 0B4h, 0FCh, 0FCh, 0B4h	; 38D4
	db 0E8h, 0FCh, 0B4h, 0D8h, 0FCh, 0B4h, 0C4h, 0FCh, 000h, 000h, 070h, 01Ch, 000h, 070h, 038h, 000h	; 38E4
	db 070h, 054h, 000h, 070h, 070h, 000h, 070h, 070h, 000h, 054h, 070h, 000h, 038h, 070h, 000h, 01Ch	; 38F4
	db 070h, 000h, 000h, 070h, 01Ch, 000h, 070h, 038h, 000h, 070h, 054h, 000h, 070h, 070h, 000h, 054h	; 3904
	db 070h, 000h, 038h, 070h, 000h, 01Ch, 070h, 000h, 000h, 070h, 000h, 000h, 070h, 01Ch, 000h, 070h	; 3914
	db 038h, 000h, 070h, 054h, 000h, 070h, 070h, 000h, 054h, 070h, 000h, 038h, 070h, 000h, 01Ch, 070h	; 3924
	db 038h, 038h, 070h, 044h, 038h, 070h, 054h, 038h, 070h, 060h, 038h, 070h, 070h, 038h, 070h, 070h	; 3934
	db 038h, 060h, 070h, 038h, 054h, 070h, 038h, 044h, 070h, 038h, 038h, 070h, 044h, 038h, 070h, 054h	; 3944
	db 038h, 070h, 060h, 038h, 070h, 070h, 038h, 060h, 070h, 038h, 054h, 070h, 038h, 044h, 070h, 038h	; 3954
	db 038h, 070h, 038h, 038h, 070h, 044h, 038h, 070h, 054h, 038h, 070h, 060h, 038h, 070h, 070h, 038h	; 3964
	db 060h, 070h, 038h, 054h, 070h, 038h, 044h, 070h, 050h, 050h, 070h, 058h, 050h, 070h, 060h, 050h	; 3974
	db 070h, 068h, 050h, 070h, 070h, 050h, 070h, 070h, 050h, 068h, 070h, 050h, 060h, 070h, 050h, 058h	; 3984
	db 070h, 050h, 050h, 070h, 058h, 050h, 070h, 060h, 050h, 070h, 068h, 050h, 070h, 070h, 050h, 068h	; 3994
	db 070h, 050h, 060h, 070h, 050h, 058h, 070h, 050h, 050h, 070h, 050h, 050h, 070h, 058h, 050h, 070h	; 39A4
	db 060h, 050h, 070h, 068h, 050h, 070h, 070h, 050h, 068h, 070h, 050h, 060h, 070h, 050h, 058h, 070h	; 39B4
	db 000h, 000h, 040h, 010h, 000h, 040h, 020h, 000h, 040h, 030h, 000h, 040h, 040h, 000h, 040h, 040h	; 39C4
	db 000h, 030h, 040h, 000h, 020h, 040h, 000h, 010h, 040h, 000h, 000h, 040h, 010h, 000h, 040h, 020h	; 39D4
	db 000h, 040h, 030h, 000h, 040h, 040h, 000h, 030h, 040h, 000h, 020h, 040h, 000h, 010h, 040h, 000h	; 39E4
	db 000h, 040h, 000h, 000h, 040h, 010h, 000h, 040h, 020h, 000h, 040h, 030h, 000h, 040h, 040h, 000h	; 39F4
	db 030h, 040h, 000h, 020h, 040h, 000h, 010h, 040h, 020h, 020h, 040h, 028h, 020h, 040h, 030h, 020h	; 3A04
	db 040h, 038h, 020h, 040h, 040h, 020h, 040h, 040h, 020h, 038h, 040h, 020h, 030h, 040h, 020h, 028h	; 3A14
	db 040h, 020h, 020h, 040h, 028h, 020h, 040h, 030h, 020h, 040h, 038h, 020h, 040h, 040h, 020h, 038h	; 3A24
	db 040h, 020h, 030h, 040h, 020h, 028h, 040h, 020h, 020h, 040h, 020h, 020h, 040h, 028h, 020h, 040h	; 3A34
	db 030h, 020h, 040h, 038h, 020h, 040h, 040h, 020h, 038h, 040h, 020h, 030h, 040h, 020h, 028h, 040h	; 3A44
	db 02Ch, 02Ch, 040h, 030h, 02Ch, 040h, 034h, 02Ch, 040h, 03Ch, 02Ch, 040h, 040h, 02Ch, 040h, 040h	; 3A54
	db 02Ch, 03Ch, 040h, 02Ch, 034h, 040h, 02Ch, 030h, 040h, 02Ch, 02Ch, 040h, 030h, 02Ch, 040h, 034h	; 3A64
	db 02Ch, 040h, 03Ch, 02Ch, 040h, 040h, 02Ch, 03Ch, 040h, 02Ch, 034h, 040h, 02Ch, 030h, 040h, 02Ch	; 3A74
	db 02Ch, 040h, 02Ch, 02Ch, 040h, 030h, 02Ch, 040h, 034h, 02Ch, 040h, 03Ch, 02Ch, 040h, 040h, 02Ch	; 3A84
	db 03Ch, 040h, 02Ch, 034h, 040h, 02Ch, 030h, 040h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 3A94
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 3AA4

	db 048h, 098h, 048h, 0C0h, 060h, 000h, 0A8h, 0A8h, 0A8h, 000h, 000h, 000h	; 3AB4
	db 000h, 000h, 000h, 0C0h, 000h, 000h, 0F8h, 0F8h, 0F8h, 000h, 000h, 000h, 000h, 000h, 000h, 0E0h	; 3AC0
	db 0A8h, 000h, 0F8h, 0F8h, 0F8h, 000h, 000h, 000h, 000h, 000h, 000h, 048h, 070h, 0D0h, 0F8h, 0F8h	; 3AD0
	db 0F8h, 000h, 000h, 000h, 000h, 000h, 000h, 030h, 030h, 030h, 068h, 068h, 070h, 000h, 000h, 000h	; 3AE0
	db 000h, 000h, 000h, 0C0h, 028h, 000h, 0E8h, 0C8h, 080h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 3AF0
	db 000h, 070h, 0F8h, 0F8h, 0F8h, 0C0h, 000h, 000h, 000h, 000h, 000h, 020h, 0C0h, 028h, 0F8h, 0F8h	; 3B00
	db 0F8h, 000h, 000h, 000h, 048h, 098h, 048h, 028h, 028h, 028h, 048h, 038h, 028h, 060h, 048h, 028h	; 3B10
	db 078h, 060h, 038h, 030h, 070h, 030h, 048h, 098h, 048h, 088h, 078h, 048h, 0F8h, 0F8h, 0F8h, 028h	; 3B20
	db 030h, 028h, 070h, 058h, 040h, 098h, 078h, 050h, 0B8h, 098h, 068h, 068h, 038h, 038h, 090h, 050h	; 3B30
	db 050h, 0B8h, 0B0h, 088h, 0F8h, 0F8h, 0F8h, 028h, 028h, 028h, 048h, 038h, 028h, 060h, 048h, 028h	; 3B40
	db 078h, 060h, 038h, 068h, 060h, 028h, 088h, 080h, 040h, 088h, 078h, 048h, 0F8h, 0F8h, 0F8h, 028h	; 3B50
	db 030h, 028h, 050h, 080h, 070h, 078h, 0B8h, 090h, 0B0h, 0E8h, 0B8h, 0D0h, 0F0h, 0D0h, 030h, 070h	; 3B60
	db 030h, 048h, 098h, 048h, 0F8h, 0F8h, 0F8h, 028h, 028h, 028h, 048h, 038h, 028h, 060h, 048h, 028h	; 3B70
	db 078h, 060h, 038h, 060h, 048h, 028h, 088h, 078h, 048h, 088h, 078h, 048h, 0F8h, 0F8h, 0F8h, 028h	; 3B80
	db 028h, 028h, 060h, 050h, 030h, 088h, 070h, 040h, 0A8h, 090h, 060h, 028h, 068h, 040h, 040h, 078h	; 3B90
	db 040h, 028h, 058h, 030h, 0F8h, 0F8h, 0F8h, 028h, 028h, 028h, 050h, 080h, 070h, 078h, 0B8h, 090h	; 3BA0
	db 0B0h, 0E8h, 0B8h, 028h, 058h, 028h, 048h, 098h, 048h, 030h, 0D0h, 030h, 0F8h, 0F8h, 0F8h, 028h	; 3BB0
	db 028h, 028h, 088h, 060h, 038h, 0C8h, 080h, 038h, 0E8h, 0A8h, 048h, 0F8h, 0D0h, 0D0h, 0B8h, 058h	; 3BC0
	db 058h, 0D8h, 080h, 090h, 0F8h, 0F8h, 0F8h, 028h, 028h, 028h, 060h, 050h	; 3BD0

	db 030h, 088h, 070h, 048h	; 3BDC
	db 0A0h, 088h, 060h, 028h, 078h, 038h, 048h, 098h, 048h, 040h, 088h, 048h, 0F8h, 0F8h, 0F8h, 028h	; 3BE0
	db 028h, 028h, 0F8h, 0F8h, 0F8h, 020h, 068h, 078h, 088h, 088h, 088h, 088h, 038h, 038h, 0F8h, 0F8h	; 3BF0
	db 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 028h, 028h, 028h, 030h, 048h, 078h, 038h, 060h, 0A8h	; 3C00
	db 070h, 0B0h, 0F0h, 048h, 038h, 028h, 058h, 080h, 0C0h, 078h, 060h, 038h, 0F8h, 0F8h, 0F8h, 038h	; 3C10
	db 030h, 028h, 078h, 070h, 058h, 0A0h, 098h, 078h, 0E0h, 0D0h, 0C0h, 030h, 070h, 030h, 048h, 098h	; 3C20
	db 048h, 0F8h, 0F8h, 0F0h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 030h, 058h, 018h, 0C0h, 050h, 058h	; 3C30
	db 0E8h, 088h, 088h, 028h, 028h, 028h, 080h, 0A0h, 060h, 058h, 078h, 038h, 0F8h, 0F8h, 0F8h, 028h	; 3C40
	db 028h, 028h, 028h, 028h, 028h, 068h, 060h, 028h, 088h, 080h, 040h, 0A0h, 088h, 060h, 078h, 0B8h	; 3C50
	db 090h, 050h, 080h, 070h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0C8h, 030h, 010h, 038h, 080h, 038h	; 3C60
	db 050h, 0B0h, 090h, 028h, 028h, 028h, 0F8h, 0C8h, 020h, 0F8h, 070h, 030h, 000h, 000h, 000h, 0F8h	; 3C70
	db 0F8h, 0F8h, 0C8h, 058h, 030h, 0B0h, 028h, 028h, 0E0h, 070h, 070h, 028h, 028h, 028h, 0B8h, 0B8h	; 3C80
	db 0C8h, 078h, 078h, 088h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 048h, 050h, 0D0h, 060h, 0B8h, 0C0h	; 3C90
	db 0A0h, 0F8h, 0D8h, 028h, 028h, 028h, 088h, 0D0h, 0F8h, 078h, 090h, 0F8h, 000h, 000h, 000h, 0F8h	; 3CA0
	db 0F8h, 0F8h, 0F8h, 080h, 0B0h, 050h, 068h, 0A8h, 090h, 0A8h, 0E8h, 028h, 028h, 028h, 0F8h, 0B0h	; 3CB0
	db 050h, 0B8h, 060h, 028h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0B0h, 0B8h, 030h, 0B0h, 060h, 028h	; 3CC0
	db 0F0h, 0A0h, 068h, 028h, 028h, 028h, 0F0h, 078h, 080h, 0B8h, 040h, 048h, 000h, 000h, 000h, 028h	; 3CD0
	db 028h, 028h, 028h, 028h, 028h, 028h, 028h, 028h, 028h, 028h, 028h, 028h, 028h, 028h, 028h, 028h	; 3CE0
	db 028h, 028h, 028h, 028h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0D8h, 060h, 060h, 0B0h, 060h, 028h	; 3CF0
	db 0F0h, 0A0h, 068h, 028h, 028h, 028h, 0B0h, 090h, 0F8h, 050h, 070h, 0C8h, 000h, 000h, 000h, 0F8h	; 3D00
	db 0F8h, 0F8h, 0C8h, 030h, 018h, 048h, 090h, 030h, 098h, 0D0h, 070h, 028h, 028h, 028h, 0F8h, 0D0h	; 3D10
	db 038h, 0B8h, 088h, 020h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F0h, 0D8h, 040h, 0A8h, 058h, 020h	; 3D20
	db 0F0h, 0A0h, 068h, 028h, 028h, 028h, 088h, 0D8h, 030h, 000h, 098h, 038h, 000h, 000h, 000h, 0F8h	; 3D30
	db 0C8h, 000h, 0F8h, 0F8h, 0C8h, 000h, 090h, 048h, 0C8h, 0E0h, 0E0h, 038h, 038h, 038h, 0C8h, 0B8h	; 3D40
	db 000h, 098h, 088h, 000h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0F8h, 0C8h, 030h, 010h, 0A8h, 058h, 020h	; 3D50
	db 0F0h, 0A0h, 068h, 028h, 028h, 028h, 0D0h, 0C0h, 040h, 098h, 088h, 018h, 0F8h, 0F8h, 0F8h, 028h	; 3D60
	db 028h, 028h, 050h, 080h, 070h, 028h, 078h, 038h, 048h, 098h, 048h, 0A0h, 088h, 060h, 0B0h, 0E8h	; 3D70
	db 0B8h, 078h, 0B8h, 090h, 000h, 000h, 000h, 0F8h, 0F8h, 0F8h, 0F0h, 0D8h, 040h, 0B8h, 068h, 020h	; 3D80
	db 0F0h, 0A0h, 068h, 028h, 028h, 028h, 0F8h, 078h, 000h, 0C0h, 018h, 020h, 0E8h, 060h, 0B0h, 0B8h	; 3D90
	db 010h, 020h, 0F0h, 058h, 088h, 098h, 078h, 0D8h, 0C8h, 0A8h, 0F8h, 0B0h, 0D8h, 000h, 038h, 088h	; 3DA0
	db 040h, 0C0h, 080h, 0F0h	; 3DB0

	db 000h, 000h, 000h, 048h, 048h, 05Ch, 070h, 070h, 0A0h, 0C0h, 0C0h, 0FFh, 0FFh, 0FFh, 0FFh, 000h	; 3DB4

	db 020h, 000h, 040h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 030h, 000h, 000h, 000h, 009h, 000h	; 3DC4
	db 000h, 000h, 010h, 000h, 000h, 000h, 000h, 000h	; 3DD4

; font
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 3DDC
	db 080h, 002h, 060h, 009h, 060h, 009h, 060h, 009h, 060h, 009h, 080h, 002h, 060h, 009h, 080h, 002h	; 3DEC
	db 020h, 008h, 098h, 026h, 098h, 026h, 098h, 026h, 020h, 008h, 000h, 000h, 000h, 000h, 000h, 000h	; 3DFC
	db 060h, 009h, 098h, 026h, 066h, 099h, 066h, 09Ah, 066h, 099h, 098h, 026h, 060h, 009h, 080h, 002h	; 3E0C
	db 060h, 009h, 058h, 095h, 0A6h, 02Ah, 058h, 025h, 0A8h, 09Ah, 056h, 025h, 068h, 009h, 080h, 002h	; 3E1C
	db 028h, 0A8h, 096h, 096h, 096h, 025h, 068h, 009h, 058h, 02Ah, 096h, 096h, 026h, 096h, 00Ah, 028h	; 3E2C
	db 0A0h, 002h, 058h, 009h, 096h, 025h, 058h, 099h, 096h, 095h, 0A5h, 0A5h, 056h, 095h, 0A8h, 02Ah	; 3E3C
	db 000h, 00Ah, 080h, 025h, 080h, 025h, 060h, 009h, 080h, 002h, 000h, 000h, 000h, 000h, 000h, 000h	; 3E4C
	db 000h, 00Ah, 080h, 025h, 060h, 009h, 060h, 009h, 060h, 009h, 060h, 009h, 080h, 025h, 000h, 00Ah	; 3E5C
	db 080h, 002h, 060h, 009h, 080h, 025h, 080h, 025h, 080h, 025h, 080h, 025h, 060h, 009h, 080h, 002h	; 3E6C
	db 028h, 00Ah, 096h, 025h, 056h, 025h, 058h, 009h, 056h, 025h, 096h, 025h, 028h, 00Ah, 000h, 000h	; 3E7C
	db 080h, 002h, 060h, 009h, 068h, 029h, 056h, 095h, 068h, 029h, 060h, 009h, 080h, 002h, 000h, 000h	; 3E8C
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 00Ah, 080h, 025h, 080h, 025h, 060h, 009h, 080h, 002h	; 3E9C
	db 000h, 000h, 000h, 000h, 0A8h, 02Ah, 056h, 095h, 0A8h, 02Ah, 000h, 000h, 000h, 000h, 000h, 000h	; 3EAC
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 080h, 002h, 060h, 009h, 060h, 009h, 080h, 002h	; 3EBC
	db 000h, 00Ah, 080h, 025h, 060h, 009h, 058h, 002h, 096h, 000h, 026h, 000h, 008h, 000h, 000h, 000h	; 3ECC
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 095h, 056h, 096h, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 3EDC
	db 080h, 002h, 060h, 009h, 058h, 009h, 060h, 009h, 060h, 009h, 060h, 009h, 058h, 025h, 0A0h, 00Ah	; 3EEC
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 0A8h, 096h, 058h, 025h, 096h, 02Ah, 056h, 095h, 0A8h, 02Ah	; 3EFC
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 0A8h, 025h, 0A8h, 096h, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 3F0C
	db 028h, 000h, 096h, 00Ah, 096h, 025h, 096h, 025h, 056h, 095h, 0A8h, 025h, 080h, 025h, 000h, 00Ah	; 3F1C
	db 0A8h, 02Ah, 056h, 095h, 0A6h, 02Ah, 056h, 025h, 0A8h, 096h, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 3F2C
	db 0A0h, 00Ah, 058h, 025h, 096h, 00Ah, 056h, 025h, 096h, 096h, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 3F3C
	db 0A8h, 02Ah, 056h, 095h, 0A8h, 025h, 080h, 025h, 060h, 009h, 060h, 009h, 060h, 009h, 080h, 002h	; 3F4C
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 058h, 025h, 096h, 096h, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 3F5C
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 096h, 058h, 095h, 0A0h, 096h, 058h, 025h, 0A0h, 00Ah	; 3F6C
	db 080h, 002h, 060h, 009h, 060h, 009h, 080h, 002h, 060h, 009h, 060h, 009h, 080h, 002h, 000h, 000h	; 3F7C
	db 080h, 002h, 060h, 009h, 060h, 009h, 080h, 002h, 060h, 009h, 060h, 009h, 060h, 002h, 080h, 000h	; 3F8C
	db 000h, 00Ah, 080h, 025h, 060h, 009h, 058h, 002h, 060h, 009h, 080h, 025h, 000h, 00Ah, 000h, 000h	; 3F9C
	db 0A0h, 02Ah, 058h, 095h, 058h, 095h, 0A0h, 02Ah, 058h, 095h, 058h, 095h, 0A0h, 02Ah, 000h, 000h	; 3FAC
	db 0A0h, 000h, 058h, 002h, 060h, 009h, 080h, 025h, 060h, 009h, 058h, 002h, 0A0h, 000h, 000h, 000h	; 3FBC
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 0A8h, 096h, 060h, 025h, 080h, 00Ah, 060h, 009h, 080h, 002h	; 3FCC
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 095h, 096h, 025h, 096h, 02Ah, 058h, 095h, 0A0h, 02Ah	; 3FDC
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 096h, 056h, 095h, 096h, 096h, 096h, 096h, 028h, 028h	; 3FEC
	db 0A8h, 00Ah, 056h, 025h, 096h, 096h, 056h, 025h, 096h, 096h, 096h, 096h, 056h, 025h, 0A8h, 00Ah	; 3FFC
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 028h, 096h, 028h, 096h, 096h, 05Ah, 025h, 0A8h, 00Ah	; 400C
	db 0A8h, 00Ah, 056h, 025h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 056h, 025h, 0A8h, 00Ah	; 401C
	db 0A8h, 02Ah, 056h, 095h, 096h, 02Ah, 056h, 009h, 096h, 002h, 096h, 02Ah, 056h, 095h, 0A8h, 0AAh	; 402C
	db 0A8h, 02Ah, 056h, 095h, 096h, 02Ah, 056h, 009h, 096h, 002h, 096h, 000h, 096h, 000h, 028h, 000h	; 403C
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 02Ah, 096h, 095h, 096h, 096h, 058h, 0A5h, 0A0h, 02Ah	; 404C
	db 0A8h, 028h, 096h, 096h, 096h, 096h, 056h, 095h, 096h, 096h, 096h, 096h, 096h, 096h, 028h, 028h	; 405C
	db 0A0h, 00Ah, 058h, 025h, 060h, 009h, 060h, 009h, 060h, 009h, 060h, 009h, 058h, 025h, 0A0h, 00Ah	; 406C
	db 0A0h, 02Ah, 058h, 095h, 0A0h, 025h, 080h, 025h, 0A8h, 025h, 096h, 025h, 058h, 009h, 0A0h, 002h	; 407C
	db 028h, 028h, 096h, 096h, 096h, 025h, 056h, 009h, 056h, 009h, 096h, 025h, 096h, 096h, 028h, 028h	; 408C
	db 028h, 000h, 096h, 000h, 096h, 000h, 096h, 000h, 096h, 000h, 096h, 00Ah, 056h, 025h, 0A8h, 00Ah	; 409C
	db 008h, 028h, 026h, 096h, 096h, 095h, 056h, 095h, 066h, 096h, 0A6h, 096h, 026h, 096h, 008h, 028h	; 40AC
	db 028h, 028h, 096h, 096h, 056h, 096h, 056h, 095h, 056h, 095h, 096h, 095h, 096h, 096h, 028h, 028h	; 40BC
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 40CC
	db 0A8h, 00Ah, 056h, 025h, 096h, 096h, 096h, 096h, 056h, 025h, 096h, 00Ah, 096h, 000h, 028h, 000h	; 40DC
	db 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 025h, 058h, 099h, 0A0h, 022h	; 40EC
	db 0A8h, 00Ah, 056h, 025h, 096h, 096h, 096h, 096h, 056h, 025h, 096h, 096h, 096h, 096h, 028h, 028h	; 40FC
	db 0A0h, 00Ah, 058h, 025h, 096h, 09Ah, 058h, 025h, 0A8h, 096h, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 410C
	db 0A8h, 02Ah, 056h, 095h, 068h, 029h, 060h, 009h, 060h, 009h, 060h, 009h, 060h, 009h, 080h, 002h	; 411C
	db 028h, 028h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 412C
	db 028h, 028h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 058h, 025h, 060h, 009h, 080h, 002h	; 413C
	db 008h, 028h, 026h, 096h, 0A6h, 096h, 066h, 096h, 056h, 095h, 096h, 095h, 026h, 096h, 008h, 028h	; 414C
	db 028h, 028h, 096h, 096h, 058h, 025h, 060h, 009h, 058h, 025h, 096h, 096h, 026h, 098h, 008h, 020h	; 415C
	db 028h, 028h, 096h, 096h, 096h, 096h, 058h, 025h, 060h, 009h, 060h, 009h, 060h, 009h, 080h, 002h	; 416C
	db 0A8h, 02Ah, 056h, 095h, 0AAh, 025h, 060h, 009h, 058h, 002h, 096h, 02Ah, 056h, 095h, 0A8h, 02Ah	; 417C
	db 0A0h, 02Ah, 060h, 025h, 060h, 029h, 060h, 009h, 060h, 009h, 060h, 029h, 060h, 025h, 0A0h, 02Ah	; 418C
	db 02Ah, 000h, 096h, 000h, 056h, 002h, 058h, 009h, 060h, 025h, 080h, 095h, 000h, 096h, 000h, 0A8h	; 419C
	db 0A8h, 00Ah, 058h, 009h, 068h, 009h, 060h, 009h, 060h, 009h, 068h, 009h, 058h, 009h, 0A8h, 00Ah	; 41AC
	db 098h, 006h, 028h, 02Ah, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 058h, 095h, 0A0h, 02Ah	; 41BC
	db 0A0h, 002h, 058h, 009h, 096h, 026h, 096h, 025h, 096h, 096h, 096h, 096h, 096h, 025h, 096h, 00Ah	; 41CC
	db 000h, 000h, 0A0h, 00Ah, 058h, 025h, 096h, 00Ah, 096h, 02Ah, 058h, 025h, 0A0h, 009h, 060h, 009h	; 41DC
	db 000h, 000h, 0A0h, 02Ah, 058h, 095h, 096h, 096h, 096h, 096h, 096h, 096h, 058h, 059h, 0A0h, 0A2h	; 41EC
	db 028h, 000h, 096h, 000h, 096h, 00Ah, 056h, 025h, 096h, 096h, 096h, 096h, 056h, 025h, 0A8h, 00Ah	; 41FC
	db 000h, 000h, 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 02Ah, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 420C
	db 000h, 028h, 000h, 096h, 0A0h, 096h, 058h, 095h, 096h, 096h, 096h, 096h, 058h, 095h, 0A0h, 02Ah	; 421C
	db 000h, 000h, 0A0h, 00Ah, 058h, 025h, 096h, 096h, 056h, 025h, 096h, 02Ah, 058h, 095h, 0A0h, 02Ah	; 422C
	db 000h, 02Ah, 080h, 095h, 060h, 029h, 058h, 025h, 060h, 009h, 060h, 009h, 060h, 009h, 080h, 002h	; 423C
	db 000h, 000h, 0A0h, 02Ah, 058h, 095h, 096h, 096h, 056h, 095h, 0A8h, 096h, 058h, 0A5h, 0A0h, 02Ah	; 424C
	db 028h, 000h, 096h, 000h, 096h, 00Ah, 056h, 025h, 096h, 096h, 096h, 096h, 096h, 096h, 028h, 028h	; 425C
	db 080h, 002h, 060h, 009h, 080h, 002h, 060h, 009h, 060h, 009h, 060h, 009h, 060h, 009h, 080h, 002h	; 426C
	db 000h, 00Ah, 080h, 025h, 000h, 00Ah, 080h, 025h, 080h, 025h, 0A8h, 025h, 096h, 025h, 058h, 009h	; 427C
	db 028h, 000h, 096h, 028h, 096h, 096h, 056h, 025h, 056h, 009h, 096h, 025h, 096h, 096h, 028h, 028h	; 428C
	db 0A0h, 000h, 058h, 002h, 058h, 002h, 058h, 002h, 058h, 002h, 058h, 00Ah, 060h, 025h, 080h, 00Ah	; 429C
	db 000h, 000h, 028h, 00Ah, 096h, 025h, 066h, 096h, 066h, 096h, 066h, 096h, 066h, 096h, 08Ah, 028h	; 42AC
	db 000h, 000h, 0A8h, 00Ah, 056h, 025h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 028h, 028h	; 42BC
	db 000h, 000h, 0A0h, 00Ah, 058h, 025h, 096h, 096h, 096h, 096h, 096h, 096h, 058h, 025h, 0A0h, 00Ah	; 42CC
	db 000h, 000h, 0A8h, 00Ah, 056h, 025h, 096h, 096h, 056h, 0A5h, 096h, 00Ah, 096h, 000h, 028h, 000h	; 42DC
	db 000h, 000h, 0A0h, 02Ah, 058h, 095h, 096h, 096h, 05Ah, 095h, 0A0h, 096h, 000h, 096h, 000h, 028h	; 42EC
	db 000h, 000h, 028h, 00Ah, 096h, 025h, 056h, 096h, 096h, 028h, 096h, 000h, 096h, 000h, 028h, 000h	; 42FC
	db 000h, 000h, 0A0h, 00Ah, 058h, 025h, 096h, 00Ah, 058h, 025h, 0A8h, 096h, 056h, 025h, 0A8h, 00Ah	; 430C
	db 0A0h, 000h, 058h, 00Ah, 056h, 025h, 058h, 00Ah, 058h, 02Ah, 058h, 096h, 060h, 025h, 080h, 00Ah	; 431C
	db 000h, 000h, 028h, 028h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 096h, 058h, 059h, 0A0h, 0AAh	; 432C
	db 000h, 000h, 028h, 028h, 096h, 096h, 096h, 096h, 096h, 096h, 058h, 025h, 060h, 009h, 080h, 002h	; 433C
	db 000h, 000h, 088h, 028h, 066h, 096h, 066h, 096h, 066h, 096h, 066h, 096h, 098h, 025h, 020h, 00Ah	; 434C
	db 000h, 000h, 028h, 028h, 096h, 096h, 058h, 025h, 060h, 009h, 058h, 025h, 096h, 096h, 028h, 028h	; 435C
	db 000h, 000h, 028h, 028h, 096h, 096h, 096h, 096h, 056h, 095h, 0A8h, 096h, 058h, 025h, 0A0h, 00Ah	; 436C
	db 000h, 000h, 0A8h, 02Ah, 056h, 095h, 0A8h, 025h, 060h, 009h, 058h, 02Ah, 056h, 095h, 0A8h, 02Ah	; 437C
	db 080h, 02Ah, 060h, 009h, 060h, 009h, 058h, 002h, 058h, 002h, 060h, 009h, 060h, 009h, 080h, 02Ah	; 438C
	db 058h, 002h, 060h, 009h, 0A0h, 00Ah, 058h, 025h, 096h, 025h, 096h, 025h, 058h, 096h, 0A0h, 02Ah	; 439C
	db 0A8h, 002h, 060h, 009h, 060h, 009h, 080h, 025h, 080h, 025h, 060h, 009h, 060h, 009h, 0A8h, 002h	; 43AC

	db 000h, 000h, 000h, 000h	; 43BC
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 004h, 000h, 000h, 000h, 020h, 000h, 000h, 000h	; 43C0
	db 020h, 000h, 000h, 000h, 008h, 000h, 000h, 000h, 080h, 000h, 000h, 000h, 080h, 000h, 000h, 000h	; 43D0

	dd offset L2340	; 43E0
	dd offset L246C	; 43E4
	dd offset Ldata+1449h	; 43E8

	db 000h, 001h, 000h, 000h	; 43EC
	db 000h, 000h, 000h, 000h, 002h, 003h, 000h, 000h, 000h, 000h, 000h, 000h, 004h, 005h, 000h, 000h	; 43F0
	db 000h, 000h, 000h, 000h, 006h, 007h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 4400
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 4410
	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 001h, 001h, 001h, 000h	; 4420
	db 004h, 000h, 000h, 000h, 000h, 000h, 010h	; 4430

	dd offset Ldata+0BDCh	; 4437
	dd offset Ldata+0DC4h	; 443B
	dd offset L1D6E	; 443F

	db 0C8h, 000h, 040h, 001h, 008h, 000h	; 4443

	db "   SNES 4", 0	; 4449
	db "SNES/GB 2", 0	; 4453
	db "    NES 2", 0	; 445D
	db "Mode7 l 8", 0	; 4467
	db "Mode7 i 8", 0	; 4471
	db "FxGfx l 4", 0	; 447B
	db "FxGfx h 4", 0	; 4485
	db "SegaGen 4", 0	; 448F
	db " N64 true", 0	; 4499
	db " N64 high", 0	; 44A3
	db " Linear 2", 0	; 44AD
	db " Linear 4", 0	; 44B7
	db " Linear 8", 0	; 44C1
	db "Vb Tile 2", 0	; 44CB

	db "Could not allocate memory for main environment.$"	; 44D5
	db "Could not load viewing file.$"	; 4505
	db "Not enough memory for file.$"	; 4522
	db "File is empty.$"	; 453E
	db "Unknown palette file type.$"	; 454D
	db "Could not open palette file.$"	; 4568
	db "Unknown parameter.$"	; 4585

; 4598
	db "SpriteView .166 - Savestate/ROM Graphics Viewer", 0Dh, 0Ah
	db "(c)2003 PeekinSo", 9Fh, "t (-? for more info)", 0Dh, 0Ah
	db 0Ah
	db "Usage: sv FileToView [-g HexOffset] [-p SavestatePalette]", 0Dh, 0Ah
	db 0Ah
	db "FileToView can be any file with one of the many console graphics formats in it", 0Ah, 0Dh
	db "that SpriteView supports, including SNES, GB, N64, NES, VB, and Sega Genesis.", 0Ah, 0Dh
	db "Some formats may also reveal game's images from other systems or PC games.", 0Ah, 0Dh
	db 0Ah
	db "SavestatePalette is a ZSNES savestate from a time in the game when it has the", 0Dh, 0Ah
	db "desired palette you want in it. The palette will be automatically loaded from", 0Dh, 0Ah
	db "the FileToView if it is a savestate.", 0Dh, 0Ah
	db "$"

; 47DE
	db "Moving the viewing window:", 81h
	db "  Up Down Left Right  row or tile", 81h
	db "  PgUp PgDn           sixteen rows", 81h
	db "  Ctrl+(Left Right)   single byte", 81h
	db "  Ctrl+(PgUp PgDn)    32k bank", 81h
	db 81h
	db "Changing tile format:", 81h
	db "  1         monochrome bitdepth", 81h
	db "  2,4,8     SNES bitplane / linear", 81h
	db "  3         SNES bitplane / VB", 81h
	db "  5         Sega Genesis  / NES", 81h
	db "  6         fx chip graphics low/high", 81h
	db "  7         mode 7 linear/interleaved", 81h
	db "  9         N64 graphics high/true", 81h
	db "  [ ]  { }  change tile wrap", 81h
	db "  + -  * /  change block width/height", 81h
	db 81h
	db "Other keys:", 81h
	db "  p P       select palette among five", 81h
	db "  , .       change user palette page", 81h
	db "  Esc       see ya!", 0

; 4A36
	db "Built with the NASM compiler and WDOSX extender.", 0Dh, 0Ah
	db "Written by Dwayne Robinson, to spy into game's graphics.", 0Dh, 0Ah
	db 0Ah
	db "    email:    FDwR@hotmail.com", 0Dh, 0Ah
	db "    homepage: http://fdwr.tripod.com/snes.htm", 0Dh, 0Ah
	db "$"

	db 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h	; 4AF3

L2214\
	dd          0

L2508\
	db          1

L2570\
	db          0

L1E60\
	dw          0

.DATA?

Lbss\
	db          8000h dup(?)

;FrameBuffer equ 0A0000h
FrameBuffer equ offset FrameBufferStorage

PUBLIC	FrameBufferStorage

FrameBufferStorage\
	db          64000 dup(?)

END
