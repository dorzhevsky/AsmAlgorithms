.model flat, c

;Функции определены во внешней библиотеке
extern sin:proc, cos:proc

.const
Pi real8 3.141592653589793238462643383
Const_180 real8 180.0

.code 

;ebp + 8 - адрес r
;ebp + 16 - адрес phi
;ebp + 24 - адрес theta
;ebp + 32 - адрес указателя на x
;ebp + 36 - адрес указателя на y
;ebp + 40 - адрес указателя на z

SphericalToRect_ proc

;Пролог
push ebp
mov ebp, esp

sub esp,40

;Вычисляем cos(phi)
vmovsd xmm0, real8 ptr [ebp + 16]		;xmm0 - phi
vmovsd real8 ptr [esp], xmm0
call cos
fstp real8 ptr [ebp - 8]					;cos(phi)
;Вычисляем sin(phi)
call sin
fstp real8 ptr [ebp - 24]				;sin(phi)

;Вычисляем cos(theta)
vmovsd xmm0, real8 ptr [ebp + 24]		;xmm0 - theta
vmovsd real8 ptr [esp], xmm0
call cos
fstp real8 ptr [ebp - 32]				;cos(theta)
;Вычисляем sin(theta)
call sin
fstp real8 ptr [ebp - 16]				;sin(theta)

;Вычисяляем х
vmovsd xmm0, real8 ptr [ebp + 8]		;xmm0 = r
vmovsd xmm1, real8 ptr [ebp - 16]		;xmm1 = sin(theta)
vmovsd xmm2, real8 ptr [ebp - 8]			;xmm1 = cos(phi)
vmulsd xmm3, xmm0, xmm1					;xmm3 = r*sin(theta)
vmulsd xmm4, xmm3, xmm2
mov eax, [ebp + 32]
vmovsd real8 ptr [eax], xmm4

;Вычисяляем y
vmovsd xmm1, real8 ptr [ebp - 24]		;xmm1 = sin(phi)
vmulsd xmm4, xmm3, xmm1
mov eax, [ebp + 36]
vmovsd real8 ptr [eax], xmm4

;Вычисяляем z
vmovsd xmm1, real8 ptr [ebp - 32]		;xmm1 = sin(phi)
vmulsd xmm2, xmm0, xmm1
mov eax, [ebp + 40]
vmovsd real8 ptr [eax], xmm2

;Эпилог
Epilog:
add esp, 40
pop ebp

ret
SphericalToRect_ endp

end