.model flat,c

.code

MmxSum_ proc

;Prolog
push ebp
mov ebp, esp
push esi

;��������� ������ �������� � mm0 �������
movq mm0,[ebp+8]
;��������� ������ �������� � mm1 �������
movq mm1,[ebp+16]

paddb mm0,mm1

movd eax,mm0
pshufw mm1, mm0, 01001110b
movd edx, mm1

;Epilog
pop esi
pop ebp
emms

ret

MmxSum_ endp

end