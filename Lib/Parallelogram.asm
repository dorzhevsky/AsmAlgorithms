.model flat,c

;�������� ������� ����, ��� ���������� ��������� PData
include PData.inc

;������� ���������� �� ������� ����������
extern sin:proc, cos:proc

.const
Const_180 real8 180.0
NegateMask qword 8000000000000000h
Pi real8 3.141592653589793238462643383
Two real8 2.0

.code

ComputeParallelogramMetrics_ proc

;Prolog
push ebp
mov ebp, esp
push esi

;�������� ������ ��� ��������� ����������
sub esp, 8							;��� ���-� ������ sin � cos
sub esp, 8							;��� A*B
sub esp, 8							;��� 2*A*B*cos(Alpha)
sub esp, 8							;��� A*A + B*B

mov esi, [ebp + 8]					;eax �������� ����� �� ��������� PDATA

;���������� A. A ������ ���� > 0
movsd xmm0, [esi + PDATA.A]
xorpd xmm1, xmm1
comisd xmm0, xmm1
jbe InvalidValues

;���������� B. B ������ ���� > 0
movsd xmm0, [esi + PDATA.B]
comisd xmm0, xmm1
jbe InvalidValues

;���������� Alpha. Alpha ������ ���� > 0
movsd xmm0, [esi + PDATA.Alpha]
comisd xmm0, xmm1
jbe InvalidValues
movsd xmm1, [Const_180]
comisd xmm0, xmm1
jae InvalidValues

;��������� Beta = 180 - Alpha
movsd xmm0, [esi + PDATA.Alpha]		;xmm0 �������� �������� Alpha
movsd xmm1, [NegateMask]			;xmm1 - ����� ��� �������������� �����
xorpd xmm0, xmm1					;����������� ����
addsd xmm0, [Const_180]				;���������� 180
movsd [esi + PDATA.Beta], xmm0		;��������� Beta

;��������� A*B
movsd xmm0, [esi + PDATA.A]
movsd xmm1, [esi + PDATA.B]
mulsd xmm0, xmm1
movsd real8 ptr [ebp - 16], xmm0

;��������� 2*A*B*cos(Alpha)
movsd xmm0, [esi + PDATA.Alpha]		;xmm0 = Alpha
mulsd xmm0, [PI]					;�������� �� PI
divsd xmm0, [Const_180]				;����� �� 180. � ����� �������� �������
sub esp, 8							;�������� ������ ��� �������� �-��� cos
movsd real8 ptr [esp], xmm0			;�������������� ���-� �-��� cos
call  cos							;�������� �-��� cos
add esp, 8							;����������� ������ ����� ������ cos
fstp real8 ptr [ebp - 8]				;��������� ��������� ������ �-��� cos
mov eax, [ebp + 8]					;eax �������� ����� �� ��������� PDATA
movsd xmm0, real8 ptr [ebp - 8]		;xmm0 = cos(Alpha)
movsd xmm1, real8 ptr [ebp - 16]		;xmm1 = A*B
mulsd xmm0, xmm1					;xmm0 = A*B*sin(Alpha)
movsd xmm1, [Two]					;xmm1 = 2
mulsd xmm0, xmm1					;xmm0 = 2*A*B*sin(Alpha)
movsd real8 ptr [ebp - 24], xmm0		;��������� �������� 2*A*B*sin(Alpha)

;��������� A*A + B*B
movsd xmm0, [esi + PDATA.A]
movsd xmm1, [esi + PDATA.A]
mulsd xmm0, xmm1
movsd xmm2, [esi + PDATA.B]
movsd xmm3, [esi + PDATA.B]
mulsd xmm2, xmm3
addsd xmm0, xmm2
movsd real8 ptr [ebp - 32], xmm0

;������� Area
movsd xmm0, [esi + PDATA.Alpha]		;xmm0 = Alpha
mulsd xmm0, [PI]					;�������� �� PI
divsd xmm0, [Const_180]				;����� �� 180. � ����� �������� �������
sub esp, 8							;�������� ������ ��� �������� �-��� sin
movsd real8 ptr [esp], xmm0			;�������������� ���-� �-��� sin
call sin							;�������� �-��� sin
add esp, 8							;����������� ������ ����� ������ sin
fstp real8 ptr [ebp - 8]				;��������� ��������� ������ �-��� sin
mov eax, [ebp + 8]					;eax �������� ����� �� ��������� PDATA
movsd xmm0, real8 ptr [ebp - 8]		;xmm0 = sin(Alpha)
movsd xmm1, real8 ptr [ebp - 16]		;xmm1 = A*B
mulsd xmm0, xmm1					;xmm0 = A*B*sin(Alpha)
movsd [esi + PDATA.Area], xmm0		;��������� �������� Area


;��������� Q
movsd xmm0, real8 ptr [ebp - 32]
movsd xmm1, real8 ptr [ebp - 24]
addsd xmm0, xmm1
sqrtsd xmm1,xmm0
mov eax, [ebp + 8]					;eax �������� ����� �� ��������� PDATA
movsd real8 ptr [esi + PDATA.Q], xmm1

;��������� P
movsd xmm0, real8 ptr [ebp - 32]
movsd xmm1, real8 ptr [ebp - 24]
subsd xmm0, xmm1
sqrtsd xmm1,xmm0
mov eax, [ebp + 8]					;eax �������� ����� �� ��������� PDATA
movsd real8 ptr [esi + PDATA.P], xmm1

;������������ ��������
mov eax, 1
jmp Epilogue

InvalidValues:
mov eax, 0

;Epilog
Epilogue:
add esp, 32
pop esi
pop ebp
ret

ComputeParallelogramMetrics_ endp

end