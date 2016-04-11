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
	mov esi , eax
	invoke StdOut , ADDR getKey
	invoke StdIn , ADDR key,51
;;;;;;;;;done getting the plaintext/key;;;;;;;;

;;;;;;;;;;;padding key;;;;;;;;;;;;;;;;

sub esi , eax
	mov ecx , esi
	mov esi,0
	mov edi,eax
	
padKey:
	mov al , [key+esi]
	mov [key + edi] , al
	inc esi
	inc edi
	loop padKey

;;;;;;;;;;;/end padding key;;;;;;;;


;;;;;;;;;encrypting the message;;;;;;;;;;;;;
	mov esi , 10
	mov edi , 0
encrypt:

    mov ecx,0
	mov dl , 0
	mov cl , [key + edi]
plainAdd:
	mov al , [plainText + edi]

keyAdd:
	mov bl ,[alph]
	cmp bl,cl
	je check
	inc dl 
	loop keyAdd

check:
	add dl,al
	cmp dl, "z"
	jle finish
	sub dl,26

finish:
	
	mov jkd , dl
	invoke StdOut , ADDR [jkd]


	inc edi 
	cmp ebx,0
	je Finish
	dec esi 
	cmp esi , 0
	jnz encrypt

;;;;;;;;;encryption finished;;;;;;;;;;;;;

Finish:
	invoke StdOut , ADDR jkd

	mov eax,0
	ret
main endp
end main