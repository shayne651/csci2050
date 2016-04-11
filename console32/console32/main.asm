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

	mov ebx ,SIZEOF plainText
	mov edi , 0
encrypt:
	lea eax , [key + edi]
	push eax
    call letterSwitch
	inc edi 
	cmp ebx,0
	je finish
	dec ebx 
	jmp encrypt

finish:
	ret
main endp


letterSwitch proc

	mov ecx,0
	mov dl , 0
	mov cl , [key]
plainAdd:
	mov al , [plainText]

keyAdd:
	mov bl ,[alph]
	cmp bl,cl
	je check
	inc dl 
	loop keyAdd

check:
	add dl,al
	cmp dl, 7Ah
	jle finish
	sub dl,26

finish:

	mov jkd , dl
	lea eax, jkd
	invoke StdOut,ADDR jkd

letterSwitch endp

end main