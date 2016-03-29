.model flat, c

;������� ���������� �� ������� ����������
extern atan:proc, acos:proc

.const
Pi real8 3.141592653589793238462643383
Const_180 real8 180.0

.code 

RectToSpherical_ proc

;������
push ebp
mov ebp, esp

;ebp + 8 - ����� x
;ebp + 16 - ����� y
;ebp + 24 - ����� z
;ebp + 32 - ����� ��������� �� r
;ebp + 36 - ����� ��������� �� phi
;ebp + 40 - ����� ��������� �� teta

sub esp, 8								;������ ��� ���-� ������ atan

;��������� r
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
vcomisd xmm1, xmm0						;���������, ��� r > 0
jbe RZero

;��������� phi
vmovsd xmm0, real8 ptr [ebp + 16]		;xmm0 = y
vmovsd xmm2, real8 ptr [ebp + 8]		;xmm2 = x
vdivsd xmm0, xmm0, xmm2					;xmm0 = y/x

sub esp, 8								;������ ��� �������� �-��� atan
vmovsd real8 ptr [esp], xmm0			;��������� � �������� y/x
call atan
add esp, 8
fstp real8 ptr [ebp - 8]
vmovsd xmm0, real8 ptr [ebp - 8]

mov eax, [ebp + 36]
vmovsd real8 ptr [eax], xmm0

;��������� theta
mov eax, [ebp + 32]
vmovsd xmm0, real8 ptr [ebp + 24]		;xmm0 = z
vmovsd xmm1, real8 ptr [eax]
vdivsd xmm0, xmm0, xmm1					;xmm0 = z/r


sub esp, 8								;������ ��� �������� �-��� atan
vmovsd real8 ptr [esp], xmm0			;��������� � �������� y/x
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

;������
Epilog:
add esp, 8
pop ebp

ret
RectToSpherical_ endp

end