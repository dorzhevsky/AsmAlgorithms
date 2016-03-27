.model flat,c

.const
StartMinVal qword 0ffffffffffffffffh
Eight		dword 8
StartMin    dword 255

.code
Min_ proc

;������
push ebp
mov	 ebp, esp
sub esp,16

mov edx, 0
mov eax,[ebp+12]					;eax - ���������� ��������� � �������
div [Eight]							;����� �� 8, ����� ���������� ���-�� �������������� ������
mov [ebp-4], eax						;��������� ���������� �������������� ������
mov [ebp-8], edx						;��������� ����� ���������� ����� �������

;������������� ��������� �������� ���������
mov ebx,255
mov [ebp-12], ebx					;��������� �������� ������� �������� (����� �������������� ������)
mov [ebp-16], ebx					;��������� �������� ������� �������� (����� ������� �������)

;���� �������������� ������ ���, �� ��������� � �������� ��������� ������
mov eax, [ebp-4]
cmp eax, 0
je SIMPLE_SEARCH

;���� �� ������� �� 8 �����
movq xmm0, [StartMinVal] 
xor ecx, ecx						;ecx = 0
mov ebx, [ebp + 8]					;ebx - ��������� �� ������ ������� 
@@:
cmp eax,ecx							;if (i < ArrayLength)
jbe @F
movq xmm1, qword ptr [ebx+8*ecx]	;mm1 - ��������� �������������� ����
pminub xmm0,xmm1					;mm0 - ����������� 8 ��������� �������
inc ecx								;i++
jmp @B

@@:
;�������� 8 ����������� �����
pshuflw xmm1, xmm0, 01001110b
pminub  xmm0, xmm1
;�������� 4 ����������� �����
pshuflw xmm1, xmm0, 11100001b
pminub  xmm0,xmm1
;�������� 2 ����������� �����
;������� ������� �� ���� ���������� �����
pextrb  eax, xmm0, 1 
pinsrb  xmm1, eax, 0
pminub  xmm0, xmm1
pextrb  ebx, xmm0, 0
mov [ebp-12], bl		;��������� ����������� �������


SIMPLE_SEARCH:
mov edx, [ebp-8]
cmp edx, 0
je FINAL_CALC
;������� ������� � ���������� ����� �������
mov ebx, [ebp+8]	;ebx - ��������� �� ������ �������
mov eax, [ebp-4]		;eax - ��������� �������������� ������
mul [Eight]			;������� �� �� 8
add ebx, eax		;edx - ��������� �� ������� �������
;���� �� ���������� ����� �������
mov ecx, 0
mov eax, 255
LOOPSTART:
mov edx, [ebp-8]
cmp edx, ecx
jbe LOOPEND
cmp al, byte ptr [ebx + ecx]
jbe @F
mov al, byte ptr [ebx + ecx]
@@:
inc ecx
jmp LOOPSTART
LOOPEND:
mov [ebp-16], eax	;��������� ������� � ���������� ����� �������


FINAL_CALC:
;���������� �������� �� ���� �����
mov eax, [ebp-12]
mov ebx, [ebp-16]
cmp al, bl
jb @F
mov al, bl

@@:
;Epilog
emms
mov esp, ebp
pop ebp

ret

Min_ endp

end