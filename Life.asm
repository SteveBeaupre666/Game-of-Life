main:

	fim r14 $77
	jms ReadInput

	;jun TEST
	fim r12 $00
	fim r14 $77
	jms CalcNextGen
	;jms PrintMemory
	;jms PrintRegisters
	jun end_prog
	
	TEST:
	fim r12 $33
	fim r14 $77
	jms CountNeighborgs
	;jms PrintRegisters

	jun end_prog
	
ReadInput:

	jms ReadCharacter
	;jms PrintCharacter
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
	;jms PrintCharacter
	
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

	fim r4 $04
	fim r6 $22
	fim r8 $FF
	
	;jms PrintRegisters
	NextOne:
	
	ld  r13
	xch r11
	ld  r12
	xch r10


	clc
	ld  r9
	add r13
	xch r1
	clc
	ld  r8
	add r12
	xch r0

	ld  r5
	dac
	xch r5
	jcn az SkipCell
	
	clc
	ld  r1
	ral
	jcn c1 SkipCell
	clc
	ld  r0
	ral
	jcn c1 SkipCell
	
	src r0
	rdm
	jcn az NotAlive
	ld  r4
	iac
	xch r4
	NotAlive:
	
	;jms PrintRegisters

	SkipCell:
	clc
	ld  r9
	iac
	xch r9
	clc
	ld  r7
	dac
	xch r7
	jcn c1 NextOne
	
	ldm 2
	xch r7
	ldm 15
	xch r9
	
	clc
	ld  r8
	iac
	xch r8
	clc
	ld  r6
	dac
	xch r6
	jcn c1 NextOne
	
	bbl 0
	
CalcNextGen:

	jms CountNeighborgs
	
	jms PrintRegisters

	clc
	ld  r13
	xch r1
	ldm 8
	add r12
	xch r0
	src r0
	ld  r4
	wrm	
	
	clc
	ld  r13
	iac
	xch r13
	clc
	ld  r15
	dac
	xch r15
	jcn c1 CalcNextGen
	
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
	jcn c1 CalcNextGen

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
	
;PrintMemory:
;	jms PrintNewLine
;	jms $3fd
;	jms PrintNewLine
;	bbl 0
	
PrintMemory:
	fim r0 $00
	;fim r2 $30

	NextCell:
	
	;jms PrintRegisters
	
	src r0
	rdm
	xch r3
	ldm 3
	xch r2
	jms PrintCharacter

	clc
	ld  r1
	iac
	xch r1
	jcn c0 NextCell

	ldm 0
	xch r1
	jms PrintNewLine
	
	clc
	ld  r0
	iac
	xch r0
	jcn c0 NextCell

	jms PrintNewLine

	bbl 0
	
PrintRegisters:
	jms $3ff
	bbl 0
	
end_prog:
	jms PrintNewLine
	;jms PrintRegisters
