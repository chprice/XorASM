;Channon Price
;CS301 2010
;Project 1, finalish draft

;This is a program for encrypting a string by sequentially xoring it with a ;password, character by character. The last input is for a bit to determine if the string should be encoded (1) or decrypted (0) by the password.
;input is:
;	String to be encoded
;	Password
;	Encoding bit

extern gets 
mov rdi,pass_phrase ;input passphrase
call gets
mov rdi, key ;input key
call gets
mov rdi, encode_bit ;determines if we are encoding or unencoding ;set to 1 by default
call gets
	; we're going to use define to make it all cleaner
%define countP edx ; counter for phrase
%define countK rdi ; counter for key
;%define process r8
mov countP,0
mov countK,0

xorLoop:
mov cl, BYTE[pass_phrase+countP]
cmp cl,0 ;if I have reached the end of the phrase, print it
je print

keyBegin:
mov al, BYTE[key+countK]
cmp al,0
jne cont_it ;if my string has not hit the end, keep going normally

mov countK, 0; else reset back to the beginning of the key
mov al, BYTE[key+countK] ; and grab the start of the key

cont_it:
cmp BYTE[encode_bit], 49
je encrypt
jne decrypt

encrypt:
xor cl, al ;xor the two letters
add cl, 50 ;add 50 to bring it back to normal/visible symbols
jmp conti

decrypt: ;invert what encrypt does, in reverse order
sub cl, 50
xor cl, al

conti:
mov BYTE[pass_phrase+countP], cl ;store it
add countP, 1
add countK, 1

jmp xorLoop


print:
mov rdi, pass_phrase
extern puts
call puts


exit:
mov al, BYTE[encode_bit]
ret


section .data
key:
	times 100 db 0
pass_phrase:
	times 100 db 0

encode_bit:
	db '1',0
