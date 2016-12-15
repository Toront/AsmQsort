.586                                               ;директива, указывающа€ на тип процессора
.model flat, C
option casemap :none

include <C:\masm32\include\kernel32.inc>

includelib <C:\masm32\lib\kernel32.lib>

.code

;=========================================================
;=========================================================

; Ѕџ—“–јя —ќ–“»–ќ¬ ј

         ; сортируютс€ по возрастанию четырехбайтовые
         ; (dword) числа в диапазоне адресов массива от min до max;
         ; min - указатель на крайнее левое число;
         ; max - указатель на крайнее правое число

QS proc public uses EAX EBX EDX EDI ESI, \
                  min: ptr dword, max: ptr dword

local dwDiv2: dword          ; объ€вл€ем локальную переменную
mov dwDiv2, 2                ; присваиваем ей значение "2"

mov EDI, min                 ; в EDI - адрес левого
mov ESI, max                 ; в ESI - адрес правого

mov EAX, [EDI]               ; в EAX - значение (не адрес) левого
add EAX, [ESI]               ; складываем EAX со значением правого
mov EDX, 0                   ; обнул€ем EDX (подготавливаем дл€ делени€)
div dwDiv2                   ; делим EAX на "2"
mov EBX, EAX                 ; в EBX - среднее значение левого и правого

.WHILE EDI < ESI             ; повтор€ем, пока адрес левого < адреса правого

   .WHILE [EDI] < EBX        ; повтор€ем, пока значение левого < среднего значени€
      add EDI, 4             ; увеличиваем адрес левого на 4 байта
   .ENDW
 
   .WHILE [ESI] > EBX        ; повтор€ем, пока значение правого > среднего значени€
      sub ESI, 4             ; уменьшаем адрес правого на 4 байта
   .ENDW

   .IF EDI <= ESI            ; если адрес левого <= адреса правого
      push [EDI]             ; тогда обмен значений через стек
      push [ESI]
      pop [EDI]
      pop [ESI]
      add EDI, 4             ; увеличиваем адрес левого на 4 байта
      sub ESI, 4             ; уменьшаем адрес правого на 4 байта
   .ENDIF

.ENDW

.IF min < ESI                ; рекурсии влево
   invoke QS, min, ESI
.ENDIF

.IF EDI < max                ; рекурсии вправо
   invoke QS, EDI, max
.ENDIF

ret                          ; возврат из процедуры

QS endp

END