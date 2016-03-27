.model flat,c

include TestStruct.inc

extern malloc:proc

.code

; extern "C" TestStruct* CreateTestStruct_(__int8 val8, __int16 val16, __int32 val32, __int64 val64)
;
;
; Returns pointer to newly created and initialized TestStruct structure
CreateTestStruct_ proc

;Prolog
push ebp
mov ebp, esp

;Function body

push sizeof TestStruct
call malloc
add esp,4
cmp eax, 0
jz MallocError

mov dl, [ebp + 8]
mov [eax + TestStruct.Val8], dl

mov dx, [ebp + 12]
mov [eax + TestStruct.Val16], dx

mov edx, [ebp + 16]
mov [eax + TestStruct.Val32], edx

mov edx, [ebp + 20] ;h
mov ecx, [ebp + 24] ;l
mov dword ptr [eax + TestStruct.Val64], edx
mov dword ptr [eax + TestStruct.Val64 + 4], ecx 


MallocError:
;Epilog
pop ebp

ret
CreateTestStruct_ endp
end