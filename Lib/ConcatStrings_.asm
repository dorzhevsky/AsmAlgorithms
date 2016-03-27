.model flat,c

.code

ConcatStrings_ proc

;Пролог
push ebp
mov ebp, esp
sub esp, 8			;Выделяем памть под 2 локальных переменных - счетчик и текущую длину строки-назначения
push ebx
push esi
push edi

;Обнуляем счеткик и текущую длину строки-назначения
xor eax,eax
mov [ebp - 4], eax	;Счеткик
mov [ebp - 8], eax	;Текущая длина строки назначения
mov ebx, [ebp + 8]
mov [ebx], al		;*dst = '\0'

mov ebx, [ebp + 16]	;Массив указателей на строки

;Цикл по массиву исходных слов
WordsLoopBegin:
mov eax, [ebp - 4]
cmp eax, [ebp + 20]
je WordsLoopEnd

;Вычисляем длину i-ой строки
mov ecx, -1
xor al, al
mov edx, [ebp - 4]
mov edi, [ebx + edx*4]
cld
repne scasb
not ecx
dec ecx				;В ecx теперь хранится длина i-ой строки


;Увеличиваем счетчик длины строки-назначения
mov eax, [ebp - 8]
add ecx, eax
mov [ebp - 8], ecx

;Если текущая длина строки-назначения >= максимально возможной
cmp ecx, [ebp + 12]
jg WordsLoopEnd

;Копируем исходную i-ую строку в строку-назначение
mov esi, [ebx + edx*4]
mov edi, [ebp + 8]
add edi, eax
rep movsb


;Увеличиваем значение счетчика
mov eax, [ebp - 4]
inc eax
mov [ebp - 4], eax

jmp WordsLoopBegin

WordsLoopEnd:

mov eax, [ebp - 8]
;Эпилог
pop edi
pop esi
pop ebx
mov esp,ebp ;Освобождаем память от локальных переменных
pop ebp

ret

ConcatStrings_ endp
end