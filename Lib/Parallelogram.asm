.model flat,c

;Инклюдим внешний файл, где определена структура PData
include PData.inc

;Функции определены во внешней библиотеке
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

;Выделяем память под локальные переменные
sub esp, 8							;Под рез-т вызова sin и cos
sub esp, 8							;Под A*B
sub esp, 8							;Под 2*A*B*cos(Alpha)
sub esp, 8							;Под A*A + B*B

mov esi, [ebp + 8]					;eax содержит адрес на структуру PDATA

;Валидируем A. A должно быть > 0
movsd xmm0, [esi + PDATA.A]
xorpd xmm1, xmm1
comisd xmm0, xmm1
jbe InvalidValues

;Валидируем B. B должно быть > 0
movsd xmm0, [esi + PDATA.B]
comisd xmm0, xmm1
jbe InvalidValues

;Валидируем Alpha. Alpha должно быть > 0
movsd xmm0, [esi + PDATA.Alpha]
comisd xmm0, xmm1
jbe InvalidValues
movsd xmm1, [Const_180]
comisd xmm0, xmm1
jae InvalidValues

;Вычисляем Beta = 180 - Alpha
movsd xmm0, [esi + PDATA.Alpha]		;xmm0 содержит значение Alpha
movsd xmm1, [NegateMask]			;xmm1 - маска для инвертирования знака
xorpd xmm0, xmm1					;Инвертируем знак
addsd xmm0, [Const_180]				;Прибавляем 180
movsd [esi + PDATA.Beta], xmm0		;Сохраняем Beta

;Вычисляем A*B
movsd xmm0, [esi + PDATA.A]
movsd xmm1, [esi + PDATA.B]
mulsd xmm0, xmm1
movsd real8 ptr [ebp - 16], xmm0

;Вычисляем 2*A*B*cos(Alpha)
movsd xmm0, [esi + PDATA.Alpha]		;xmm0 = Alpha
mulsd xmm0, [PI]					;Умножаем на PI
divsd xmm0, [Const_180]				;Делим на 180. В итоге получаем радианы
sub esp, 8							;Выделяем память под параметр ф-ции cos
movsd real8 ptr [esp], xmm0			;Инициализируем пар-р ф-ции cos
call  cos							;Вызываем ф-цию cos
add esp, 8							;Освобождаем память после вызова cos
fstp real8 ptr [ebp - 8]				;Сохраняем результат вызова ф-ции cos
mov eax, [ebp + 8]					;eax содержит адрес на структуру PDATA
movsd xmm0, real8 ptr [ebp - 8]		;xmm0 = cos(Alpha)
movsd xmm1, real8 ptr [ebp - 16]		;xmm1 = A*B
mulsd xmm0, xmm1					;xmm0 = A*B*sin(Alpha)
movsd xmm1, [Two]					;xmm1 = 2
mulsd xmm0, xmm1					;xmm0 = 2*A*B*sin(Alpha)
movsd real8 ptr [ebp - 24], xmm0		;Сохраняем значение 2*A*B*sin(Alpha)

;Вычисляем A*A + B*B
movsd xmm0, [esi + PDATA.A]
movsd xmm1, [esi + PDATA.A]
mulsd xmm0, xmm1
movsd xmm2, [esi + PDATA.B]
movsd xmm3, [esi + PDATA.B]
mulsd xmm2, xmm3
addsd xmm0, xmm2
movsd real8 ptr [ebp - 32], xmm0

;Считаем Area
movsd xmm0, [esi + PDATA.Alpha]		;xmm0 = Alpha
mulsd xmm0, [PI]					;Умножаем на PI
divsd xmm0, [Const_180]				;Делим на 180. В итоге получаем радианы
sub esp, 8							;Выделяем память под параметр ф-ции sin
movsd real8 ptr [esp], xmm0			;Инициализируем пар-р ф-ции sin
call sin							;Вызываем ф-цию sin
add esp, 8							;Освобождаем память после вызова sin
fstp real8 ptr [ebp - 8]				;Сохраняем результат вызова ф-ции sin
mov eax, [ebp + 8]					;eax содержит адрес на структуру PDATA
movsd xmm0, real8 ptr [ebp - 8]		;xmm0 = sin(Alpha)
movsd xmm1, real8 ptr [ebp - 16]		;xmm1 = A*B
mulsd xmm0, xmm1					;xmm0 = A*B*sin(Alpha)
movsd [esi + PDATA.Area], xmm0		;Сохраняем значение Area


;Вычисляем Q
movsd xmm0, real8 ptr [ebp - 32]
movsd xmm1, real8 ptr [ebp - 24]
addsd xmm0, xmm1
sqrtsd xmm1,xmm0
mov eax, [ebp + 8]					;eax содержит адрес на структуру PDATA
movsd real8 ptr [esi + PDATA.Q], xmm1

;Вычисляем P
movsd xmm0, real8 ptr [ebp - 32]
movsd xmm1, real8 ptr [ebp - 24]
subsd xmm0, xmm1
sqrtsd xmm1,xmm0
mov eax, [ebp + 8]					;eax содержит адрес на структуру PDATA
movsd real8 ptr [esi + PDATA.P], xmm1

;Возвращаемое значение
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