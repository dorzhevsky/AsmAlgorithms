.model flat,c
.const
r8_SfFtoC real8 0.5555555556 ; 5 / 9
r8_SfCtoF real8 1.8 ; 9 / 5
i4_32 dword 32
; extern "C" double FtoC_(double f)
;
; Description: Converts a temperature from Fahrenheit to Celsius.
;
; Returns: Temperature in Celsius.
.code
FtoC_ proc
push ebp
mov ebp,esp
fld [r8_SfFtoC] ;load 5/9
fld real8 ptr [ebp+8] ;load 'f'
fild [i4_32] ;load 32
fsubp ;ST(0) = f - 32
fmulp ;ST(0) = (f - 32) * 5/9
pop ebp
ret
FtoC_ endp


CtoF_ proc
push ebp
mov ebp, esp
fild [i4_32]
fld qword ptr [ebp + 8]
fld [r8_SfCtoF]
fmulp
faddp
pop ebp
ret
CtoF_ endp

end