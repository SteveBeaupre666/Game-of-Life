main:

	fim r14 $77

	jms ReadInput

	fim r12 $22
	jms CountNeighborgs
	jms PrintMemory
	
	jun end_prog
	
ReadInput:

	jms ReadCharacter
	jms PrintCharacter
	;jms PrintRegisters
	
	ld  r3
	src r12
	wrm	
		
	clc
	ld  r13
	iac
	xch r13
	clc
	ld  r15
	dac
	xch r15
	jcn c1 ReadInput
	
	jms ReadCharacter
	;fim r2 $20
	jms PrintCharacter
	
	ldm 0
	xch r13
	ldm 7
	xch r15
	
	clc
	ld  r12
	iac
	xch r12
	clc
	ld  r14
	dac
	xch r14
	jcn c1 ReadInput
	
	;jms PrintMemory
	
	bbl 0
	
CountNeighborgs:

	fim r4 $00
	fim r6 $22
	fim r8 $FF
	
	NextOne:
	
	ld  r13
	xch r11
	ld  r12
	xch r10

	clc
	ld  r11
	add r9
	xch r9
	ld  r9
	xch r1
	clc
	ld  r10
	add r8
	xch r8
	ld  r8
	xch r0
	
	jms PrintRegisters
	;bbl 0
	
	src r0
	rdm
	clc
	add r5
	xch r5
	src r12
	wrm	
	
	clc
	ld  r7
	dac
	xch r7
	jcn c1 NextOne
	
	ldm 2
	xch r7
	
	clc
	ld  r6
	dac
	xch r6
	jcn c1 NextOne

	bbl 0
	
ReadCharacter:
	jms $3f0
	bbl 0
	
PrintCharacter:
	jms $3e0
	bbl 0
	
PrintNewLine:
	fim r2 $0D
	jms $3e0
	fim r2 $0A
	jms $3e0
	bbl 0
	
PrintMemory:
	jms PrintNewLine
	jms $3fd
	jms PrintNewLine
	bbl 0
	
PrintRegisters:
	jms $3ff
	bbl 0
	
end_prog:
	jms PrintNewLine
	jms PrintRegisters
