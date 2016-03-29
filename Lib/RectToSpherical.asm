.model flat, c

;Функции определены во внешней библиотеке
extern atan:proc, acos:proc

.const
Pi real8 3.141592653589793238462643383
Const_180 real8 180.0

.code 

RectToSpherical_ proc

;Пролог
push ebp
mov ebp, esp

;ebp + 8 - адрес x
;ebp + 16 - адрес y
;ebp + 24 - адрес z
;ebp + 32 - адрес указателя на r
;ebp + 36 - адрес указателя на phi
;ebp + 40 - адрес указателя на teta

sub esp, 8								;Память под рез-т вызова atan

;Вычисляем r
vxorpd xmm1, xmm1, xmm1					;xmm1 = 0

vmovsd xmm0, real8 ptr [ebp + 8]		;xmm0 = x
vmulsd xmm0, xmm0, xmm0					;xmm0 = x*x
vaddsd xmm1, xmm1, xmm0					;xmm1 = x*x

vmovsd xmm0, real8 ptr [ebp + 16]		;xmm0 = y
vmulsd xmm0, xmm0, xmm0					;xmm0 = y*y
vaddsd xmm1, xmm1, xmm0					;xmm1 = x*x + y*y

vmovsd xmm0, real8 ptr [ebp + 24]		;xmm0 = z
vmulsd xmm0, xmm0, xmm0					;xmm0 = z*z
vaddsd xmm1, xmm1, xmm0					;xmm1 = x*x+y*y+z*z

vsqrtsd xmm1, xmm1, xmm1				;xmm1 = sqrt(x*x+y*y+z*z)

mov eax, [ebp + 32]
vmovsd real8 ptr [eax], xmm1			;r = xmm1

vxorpd xmm0, xmm0, xmm0
vcomisd xmm1, xmm0						;Проверяем, что r > 0
jbe RZero

;Вычисляем phi
vmovsd xmm0, real8 ptr [ebp + 16]		;xmm0 = y
vmovsd xmm2, real8 ptr [ebp + 8]		;xmm2 = x
vdivsd xmm0, xmm0, xmm2					;xmm0 = y/x

sub esp, 8								;Память под аргумент ф-ции atan
vmovsd real8 ptr [esp], xmm0			;Загружаем в аргумент y/x
call atan
add esp, 8
fstp real8 ptr [ebp - 8]
vmovsd xmm0, real8 ptr [ebp - 8]

mov eax, [ebp + 36]
vmovsd real8 ptr [eax], xmm0

;Вычисляем theta
mov eax, [ebp + 32]
vmovsd xmm0, real8 ptr [ebp + 24]		;xmm0 = z
vmovsd xmm1, real8 ptr [eax]
vdivsd xmm0, xmm0, xmm1					;xmm0 = z/r


sub esp, 8								;Память под аргумент ф-ции atan
vmovsd real8 ptr [esp], xmm0			;Загружаем в аргумент y/x
call acos
add esp, 8
fstp real8 ptr [ebp - 8]
vmovsd xmm0, real8 ptr [ebp - 8]

mov eax, [ebp + 40]
vmovsd real8 ptr [eax], xmm0

jmp Epilog

RZero:
vxorpd xmm1, xmm1, xmm1
mov eax, [ebp + 36]
vmovsd real8 ptr [eax], xmm1
mov eax, [ebp + 40]
vmovsd real8 ptr [eax], xmm1

;Эпилог
Epilog:
add esp, 8
pop ebp

ret
RectToSpherical_ endp

end