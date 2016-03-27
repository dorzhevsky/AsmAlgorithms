.model flat,c

.code

ConcatStrings_ proc

;������
push ebp
mov ebp, esp
sub esp, 8			;�������� ����� ��� 2 ��������� ���������� - ������� � ������� ����� ������-����������
push ebx
push esi
push edi

;�������� ������� � ������� ����� ������-����������
xor eax,eax
mov [ebp - 4], eax	;�������
mov [ebp - 8], eax	;������� ����� ������ ����������
mov ebx, [ebp + 8]
mov [ebx], al		;*dst = '\0'

mov ebx, [ebp + 16]	;������ ���������� �� ������

;���� �� ������� �������� ����
WordsLoopBegin:
mov eax, [ebp - 4]
cmp eax, [ebp + 20]
je WordsLoopEnd

;��������� ����� i-�� ������
mov ecx, -1
xor al, al
mov edx, [ebp - 4]
mov edi, [ebx + edx*4]
cld
repne scasb
not ecx
dec ecx				;� ecx ������ �������� ����� i-�� ������


;����������� ������� ����� ������-����������
mov eax, [ebp - 8]
add ecx, eax
mov [ebp - 8], ecx

;���� ������� ����� ������-���������� >= ����������� ���������
cmp ecx, [ebp + 12]
jg WordsLoopEnd

;�������� �������� i-�� ������ � ������-����������
mov esi, [ebx + edx*4]
mov edi, [ebp + 8]
add edi, eax
rep movsb


;����������� �������� ��������
mov eax, [ebp - 4]
inc eax
mov [ebp - 4], eax

jmp WordsLoopBegin

WordsLoopEnd:

mov eax, [ebp - 8]
;������
pop edi
pop esi
pop ebx
mov esp,ebp ;����������� ������ �� ��������� ����������
pop ebp

ret

ConcatStrings_ endp
end