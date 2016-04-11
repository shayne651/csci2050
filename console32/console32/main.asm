include \masm32\include\masm32rt.inc

.data
plainText BYTE 51 DUP(0),0
getString db "Please enter a String (1-50 chars): ",0
cipherText BYTE 51 DUP(0),0
key db 51 DUP(0),0
getKey db "please enter a key (has to be the same size as the message): ",0
alph BYTE "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",0
jkd BYTE 51 DUP(0),0
newLine BYTE 0ah,0dh,0

.code 
main proc

test1:
;;;;;;;;This is sending text to the console and getting the key/message;;;;
	invoke StdOut , ADDR getString
	invoke StdIn , ADDR plainText,51
	invoke StdOut , ADDR getKey
	invoke StdIn , ADDR key,51
;;;;;;;;;done getting the plaintext/key;;;;;;;;
	mov ebx , SIZEOF plainText
	mov ecx , 1
    call letterSwitch

	ret
main endp


letterSwitch proc

pop ecx
mov ecx,25
mov al , [plainText]
mov edi , 0
mov esi , 0
PlainText:
	mov bl , [alph+edi]
	cmp bl,al
	je KeyText
	inc edi
	loop PlainText

resetLoop:
	mov ecx, 25
	mov al , [key]

KeyText:
	mov bl , [alph + esi]
	cmp al,bl
	je check
	inc esi
	loop KeyText

check:
	add esi , edi
	cmp esi,25
	jl Finish
	sub esi , 25
	
Finish:
	mov al , [alph + esi]
	;invoke StdOut , ADDR [esi]
	mov [jkd] , al
	invoke StdOut , ADDR [jkd]
letterSwitch endp

end main