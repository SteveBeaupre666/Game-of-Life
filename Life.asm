jun main

Offset: db $FF $F0 $F1 $0F $01 $1F $10 $11

main:

	jms ReadInput
	
	;fim r0 $00
	;jms CountNeighbors
	
	jms CalcNextGen
	
	;fim r0 $01
	;ldm 4
	;xch r9
	;jms CalcNewState
	;jms PrintRegs
	
	jms PrintMemory
	jms PrintNewLine
	jms PrintNewLine
	jms PrintRegs

	jun end_prog
	
	
ReadInput:
	fim r0  $00
	fim r14 $88
	jun NextCol2
	
	NextRow2:
		ldm 8
		xch r15
		NextCol2:
			
			jms ReadChar
			
			ld  r3
			src r0
			wrm
			
			clc
			ld  r1
			iac
			xch r1
			clc
			
		isz r15 NextCol2
		
		ldm 0
		xch r1
		
		clc
		ld  r0
		iac
		xch r0
		clc
		
		jms ReadChar
		
	isz r14 NextRow2

	bbl 0
	
CountNeighbors:
	fim r8 $80

	ld  r0
	xch r12
	ld  r1
	xch r13
	
	fim r0 Offset
	
	NextNeighbor:
	
		fin r10
	
		ld  r12
		xch r14
		ld  r13
		xch r15
	
		clc
		ld  r15
		add r11
		xch r15
		clc
		ld  r14
		add r10
		xch r14
	
		ld r15
		ral
		jcn c1 InvalidCell
		ld r14
		ral
		jcn c1 InvalidCell
		
		clc
		src r14
		rdm
		
		clc
		add r9
		xch r9
		
		InvalidCell:
		clc
		ld  r1
		iac
		xch r1
		jcn c0 NextOffset
		
		clc
		ld  r0
		iac
		xch r0
		NextOffset:
		
	isz r8 NextNeighbor
	
	ld  r12
	xch r0
	ld  r13
	xch r1
	
	clc
	ldm 8
	add r13
	xch r13
	
	ld  r9
	src r12
	wrm
	
	bbl 0
	
CalcNextGen:
	fim r0 $00
	fim r4 $88
	
	NextRow3:
	NextCol3:
	
	jms CountNeighbors
	
	jms CalcNewState	
	xch r7
	jms PrintRegs
	
	clc
	ldm 8
	add r0
	xch r0
	src r0
	ld  r7
	wrm
	clc
	ldm 8
	add r0
	xch r0
	
	clc
	ld  r1
	iac
	xch r1
	isz r5 NextCol3
	
	ldm 0
	xch r1
	ldm 8
	xch r5
	
	clc
	ld  r0
	iac
	xch r0
	isz r4 NextRow3

	bbl 0
	
CalcNewState:

	src r0
	rdm
	jcn az Dead
	
	Alive:
	clc
	ldm 14
	add r9
	jcn az StayAlive
		clc
		ldm 13
		add r9
		jcn az StayAlive
		bbl 0
	StayAlive:
		bbl 1
	
	Dead:
		clc
		ldm 13
		add r9
		jcn az Born
		bbl 0	
	Born:	
		bbl 1
	
ReadChar:
    jms $3f0
	bbl 0
	
PrintChar:
    jms $3e0
	bbl 0
	
PrintSpace:
	fim r2 $20
    jms PrintChar
	bbl 0
	
PrintNewLine:
	;fim r2 $0D
	;jms PrintChar
	fim r2 $0A
	jms PrintChar
	bbl 0
	
PrintHex:
	clc
	fim r2 $30
	xch r3
	ld  r3
	daa
	jcn c1 Alpha
	jun NotAlpha
	Alpha:
		clc
		ldm 7
		add r3
		xch r3
		clc
		ld  r2
		iac
		xch r2
	NotAlpha:
		clc
	jms PrintChar
	
	bbl 0
	
PrintMemory:
	fim r0 $00
	jun NextCol
	
	NextRow:
		jms PrintNewLine
		NextCol:
			src r0
			rdm
			jms PrintHex
		isz r1 NextCol
	isz r0 NextRow
		
	bbl 0

PrintRegs:
	jms $3ff
	bbl 0

end_prog:
	nop
