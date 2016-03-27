.model flat,c

.const
Double_Size real8 8.0
EvenOddMask dword 00000001h
.code

ComputeLeastSquareRoots_ proc

;������
push ebp
mov ebp, esp

mov esi, [ebp + 8]				;esi - ��������� �� ������ ������� x
mov edi, [ebp + 12]				;edi - ��������� �� ������ ������� y
mov eax, [ebp + 16]				;eax - ���-�� ��������� � �������

;���� ���-�� ��������� ������� = 0, �� ��������� ���������
cmp eax, 0
je Epilog

;������� �������� ����
xorpd xmm0, xmm0				;� xmm0 ������ sum_x
xorpd xmm1, xmm1				;� xmm1 ������ sum_y
xorpd xmm2, xmm2				;� xmm2 ������ sum_xx
xorpd xmm3, xmm3				;� xmm3 ������ sum_xy
xor ecx, ecx					;������� �����

;���������, �������� �� ���-�� ��������� �������� ������ ��� ��������
mov ebx, eax
and ebx, [EvenOddMask]
jz @F

;���� �������
movsd xmm0, real8 ptr [esi]
movsd xmm1, real8 ptr [edi]
movsd xmm2, xmm0
mulsd xmm2, xmm2
movsd xmm3, xmm0
mulsd xmm3, xmm1
add esi, 8
add edi, 8
inc ecx

@@:
cmp ecx, eax
jge @F
movupd xmm4, xmmword ptr [esi]
movupd xmm5, xmm4
addpd xmm0, xmm4
mulpd xmm4, xmm4
addpd xmm2, xmm4
movupd xmm4, xmmword ptr [edi]
addpd xmm1, xmm4
mulpd xmm4, xmm5 
addpd xmm3, xmm4
add esi, 16
add edi, 16
add ecx,2
jmp @B

@@:
haddpd xmm0, xmm0
haddpd xmm1, xmm1
haddpd xmm2, xmm2
haddpd xmm3, xmm3

;��������� �����������
movsd xmm4, xmm2						;xmm4 - sum_xx
cvtsi2sd xmm5, eax						;xmm5 - n
mulsd xmm4, xmm5						;xmm4 - sum_xx*n
movsd xmm5, xmm0						;xmm5 - sum_x
mulsd xmm5, xmm5						;xmm5 - sum_x*sum_x
subsd xmm4, xmm5						;xmm4 - �����������

;��������� m
movsd xmm5, xmm3
cvtsi2sd xmm6, eax						;xmm5 - n
mulsd xmm5, xmm6
movsd xmm6, xmm0
movsd xmm7, xmm1
mulsd xmm6, xmm7
subsd xmm5, xmm6						;xmm5 - ���������

divsd xmm5, xmm4						;xmm5 - m

;��������� m
mov edx, [ebp + 20]
movq real8 ptr [edx], xmm5

;��������� b
movsd xmm5, xmm2
movsd xmm6, xmm1
mulsd xmm5, xmm6
movsd xmm6, xmm0
movsd xmm7, xmm3
mulsd xmm6, xmm7
subsd xmm5, xmm6

divsd xmm5, xmm4

mov edx, [ebp + 24]
movq real8 ptr [edx], xmm5

Epilog:
pop ebp

ret

ComputeLeastSquareRoots_ endp

end