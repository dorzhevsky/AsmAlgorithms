.model flat,c

.const
Four real4 4.0
Three real4 3.0
Pi   real4 3.14159265358979323846

.code

SphereSufraceVolume_ proc

;Prolog
push ebp
mov ebp, esp

;���������� ������
movss xmm0, real4 ptr [ebp + 8]
xorps xmm1, xmm1
comiss xmm0, xmm1					
setb al
jb Prolog

;��������� ������� �����������
mulss xmm0, xmm0				;�������� � �������
mulss xmm0, [Four]				;�������� �� 4
mulss xmm0, [Pi]				;�������� �� PI
mov ebx, [ebp + 12]				;ebx - ����� ����������, ��� �������� �������
movss real4 ptr [ebx], xmm0		;�������� ������� �����������

;��������� �����
movss xmm1, real4 ptr [ebp + 8]			;xmm1 - ������
mulss xmm0, xmm1				;�������� � �������
divss xmm0, [Three]				;����� �� 3
mov ebx, [ebp + 16]				;ebx - ����� ����������, ��� �������� �����
movss real4 ptr [ebx], xmm0		;�������� ����� �����������

Prolog:
;Epilog
pop ebp
ret

SphereSufraceVolume_ endp

end