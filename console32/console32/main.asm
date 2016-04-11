include \masm32\include\masm32rt.inc

.data
plainText BYTE 51 DUP(0),0
getString BYTE "please enter a String: ",0
key BYTE 51 DUP(0),0
getKey BYTE "please enter a String ",0
alph BYTE "abcdefghijklmnopqrstuvwxyz",0
getMessageS BYTE "how many characters is your message (max 50)"
addPlain DWORD 0
addKey DWORD 0
messageSize DWORD 0


.code 
getPlain proc

	mov al, [plainText]
	mov ecx , 26

plainLoop:
	mov bl , [alph + ecx]
	cmp bl,al
	push ecx
	pop addPlain
	invoke StdOut , ADDR [ecx]
	je keyLoop
	loop restartLoop

restartLoop:
	mov ecx,26
keyLoop:
	mov bl , [alph + ecx]
	cmp bl,al
	je newLetter
	loop keyLoop


newLetter:
	mov eax , addKey
	add eax , addPlain
	cmp eax , 26
	jle Finish
	jmp Greater

Greater:
	sub eax , 26
	mov ecx , 26

Finish:
	invoke StdOut , ADDR [addKey]
	pop eax
	ret
	
getPlain endp
main proc

	invoke StdOut , ADDR getMessageS
	invoke StdIn , ADDR messageSize,50
	invoke StdOut , ADDR getString
	invoke StdIn , ADDR plainText,50
	invoke StdOut , ADDR getKey
	invoke StdIn , ADDR key,50

;encrypt:
	call getPlain

	;loop enctypt
	
	mov eax,0
	ret
main endp
end main