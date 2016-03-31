.model flat, c

;������� ���������� �� ������� ����������
extern sin:proc, cos:proc

.const
Pi real8 3.141592653589793238462643383
Const_180 real8 180.0

.code 

;ebp + 8 - ����� r
;ebp + 16 - ����� phi
;ebp + 24 - ����� theta
;ebp + 32 - ����� ��������� �� x
;ebp + 36 - ����� ��������� �� y
;ebp + 40 - ����� ��������� �� z

SphericalToRect_ proc

;������
push ebp
mov ebp, esp

sub esp,40

;��������� cos(phi)
vmovsd xmm0, real8 ptr [ebp + 16]		;xmm0 - phi
vmovsd real8 ptr [esp], xmm0
call cos
fstp real8 ptr [ebp - 8]					;cos(phi)
;��������� sin(phi)
call sin
fstp real8 ptr [ebp - 24]				;sin(phi)

;��������� cos(theta)
vmovsd xmm0, real8 ptr [ebp + 24]		;xmm0 - theta
vmovsd real8 ptr [esp], xmm0
call cos
fstp real8 ptr [ebp - 32]				;cos(theta)
;��������� sin(theta)
call sin
fstp real8 ptr [ebp - 16]				;sin(theta)

;���������� �
vmovsd xmm0, real8 ptr [ebp + 8]		;xmm0 = r
vmovsd xmm1, real8 ptr [ebp - 16]		;xmm1 = sin(theta)
vmovsd xmm2, real8 ptr [ebp - 8]			;xmm1 = cos(phi)
vmulsd xmm3, xmm0, xmm1					;xmm3 = r*sin(theta)
vmulsd xmm4, xmm3, xmm2
mov eax, [ebp + 32]
vmovsd real8 ptr [eax], xmm4

;���������� y
vmovsd xmm1, real8 ptr [ebp - 24]		;xmm1 = sin(phi)
vmulsd xmm4, xmm3, xmm1
mov eax, [ebp + 36]
vmovsd real8 ptr [eax], xmm4

;���������� z
vmovsd xmm1, real8 ptr [ebp - 32]		;xmm1 = sin(phi)
vmulsd xmm2, xmm0, xmm1
mov eax, [ebp + 40]
vmovsd real8 ptr [eax], xmm2

;������
Epilog:
add esp, 40
pop ebp

ret
SphericalToRect_ endp

end