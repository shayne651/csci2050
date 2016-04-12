include \masm32\include\masm32rt.inc

.data 
guess BYTE "Guess the number(1-50): ",0
wrong BYTE "Wrong guess ",0
newLine BYTE 0ah,0bh,0
guessNum DWORD 0
numTStr BYTE 11 DUP(0)
startAgain BYTE "do you want to play again?",0
startInput BYTE 4 DUP(0),0
correctG BYTE "You guessed Correct",0
number DWORD 0


.code
main proc 

Start:
	
	invoke StdOut , ADDR guess
	invoke StdIn , ADDR numTStr , 10
	invoke atodw , ADDR numTStr
	mov guessNum , eax

	pushd 50

	call randomSeed
	call randomNum
	mov edi , [number]
	cmp guessNum,edi
	jne Wrong
	je Correct

Wrong:
	invoke StdOut, ADDR wrong
	jmp replay
	

Correct:
	invoke StdOut , ADDR correctG
	invoke StdOut , ADDR newLine


replay:
	invoke StdOut , ADDR startAgain
	invoke StdIn , ADDR startInput , 3
	cmp startInput,"y"
	je Loops
	jne Finish

Loops:
jmp Start

Finish:

	mov eax,0
	ret
main endp

randomSeed proc

	invoke GetTickCount
	invoke nseed,eax

	ret
randomSeed endp

randomNum proc

	mov eax,[esp + 4]
	invoke nrandom , eax
	mov number ,eax

	ret

randomNum endp
end main