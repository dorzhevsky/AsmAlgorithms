.model flat,c
include TestStruct.inc

.code

CalcStructSum_ proc

;Epilog
push ebp
mov ebp, esp
push esi

;Body
xor eax, eax
mov esi, [ebp + 8]
movsx eax, byte ptr [esi + TestStruct.Val8]
movsx ecx, word ptr [esi + TestStruct.Val16] 
add eax, ecx

cdq

add eax, [esi + TestStruct.Val32]
adc edx, 0

add eax, dword ptr [esi + TestStruct.Val64]
adc edx, dword ptr [esi + TestStruct.Val64 + 4]

;Prolog
pop esi
pop ebp
ret

CalcStructSum_ endp

end