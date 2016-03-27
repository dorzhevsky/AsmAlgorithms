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

;Валидируем радиус
movss xmm0, real4 ptr [ebp + 8]
xorps xmm1, xmm1
comiss xmm0, xmm1					
setb al
jb Prolog

;Вычисляем площадь поверхности
mulss xmm0, xmm0				;Возводим в квадрат
mulss xmm0, [Four]				;Умножаем на 4
mulss xmm0, [Pi]				;Умножаем на PI
mov ebx, [ebp + 12]				;ebx - адрес переменной, где хранится площадь
movss real4 ptr [ebx], xmm0		;Сохранем площадь поверхности

;Вычисляем объем
movss xmm1, real4 ptr [ebp + 8]			;xmm1 - радиус
mulss xmm0, xmm1				;Возводим в квадрат
divss xmm0, [Three]				;Делим на 3
mov ebx, [ebp + 16]				;ebx - адрес переменной, где хранится объем
movss real4 ptr [ebx], xmm0		;Сохранем объем поверхности

Prolog:
;Epilog
pop ebp
ret

SphereSufraceVolume_ endp

end