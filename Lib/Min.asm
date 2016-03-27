.model flat,c

.const
StartMinVal qword 0ffffffffffffffffh
Eight		dword 8
StartMin    dword 255

.code
Min_ proc

;ѕролог
push ebp
mov	 ebp, esp
sub esp,16

mov edx, 0
mov eax,[ebp+12]					;eax - количество элементов в массиве
div [Eight]							;ƒелим на 8, чтобы определить кол-во восьмибайтовых блоков
mov [ebp-4], eax						;—охран€ем количество восьмибайтовых блоков
mov [ebp-8], edx						;—охран€ем длину оставшейс€ части массива

;»нициализаци€ начальных значений минимумов
mov ebx,255
mov [ebp-12], ebx					;Ќачальное значение первого минимума (среди восьмибайтовых блоков)
mov [ebp-16], ebx					;Ќачальное значение второго минимума (среди остатка массива)

;≈сли восьмибайтовых блоков нет, то переходим к обычному линейному поиску
mov eax, [ebp-4]
cmp eax, 0
je SIMPLE_SEARCH

;÷икл по группам из 8 чисел
movq xmm0, [StartMinVal] 
xor ecx, ecx						;ecx = 0
mov ebx, [ebp + 8]					;ebx - указатель на начало массива 
@@:
cmp eax,ecx							;if (i < ArrayLength)
jbe @F
movq xmm1, qword ptr [ebx+8*ecx]	;mm1 - очередной восьмибайтовый блок
pminub xmm0,xmm1					;mm0 - минимальные 8 элементов массива
inc ecx								;i++
jmp @B

@@:
;ќсталось 8 минимальных чисел
pshuflw xmm1, xmm0, 01001110b
pminub  xmm0, xmm1
;ќсталось 4 минимальных числа
pshuflw xmm1, xmm0, 11100001b
pminub  xmm0,xmm1
;ќсталось 2 минимальных числа
;Ќаходим минимум из двух оставшихс€ чисел
pextrb  eax, xmm0, 1 
pinsrb  xmm1, eax, 0
pminub  xmm0, xmm1
pextrb  ebx, xmm0, 0
mov [ebp-12], bl		;—охран€ем минимальный элемент


SIMPLE_SEARCH:
mov edx, [ebp-8]
cmp edx, 0
je FINAL_CALC
;Ќаходим минимум в оставшейс€ части массива
mov ebx, [ebp+8]	;ebx - указатель на начало массива
mov eax, [ebp-4]		;eax - количесто восьмибайтовых блоков
mul [Eight]			;”множим их на 8
add ebx, eax		;edx - указатель на остаток массива
;÷икл по оставшейс€ части массива
mov ecx, 0
mov eax, 255
LOOPSTART:
mov edx, [ebp-8]
cmp edx, ecx
jbe LOOPEND
cmp al, byte ptr [ebx + ecx]
jbe @F
mov al, byte ptr [ebx + ecx]
@@:
inc ecx
jmp LOOPSTART
LOOPEND:
mov [ebp-16], eax	;—охран€ем минимум в оставшейс€ части массива


FINAL_CALC:
;¬ычисление минимума из двух чисел
mov eax, [ebp-12]
mov ebx, [ebp-16]
cmp al, bl
jb @F
mov al, bl

@@:
;Epilog
emms
mov esp, ebp
pop ebp

ret

Min_ endp

end