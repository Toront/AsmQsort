.586                                               ;���������, ����������� �� ��� ����������
.model flat, C
option casemap :none

include <C:\masm32\include\kernel32.inc>

includelib <C:\masm32\lib\kernel32.lib>

.code

;=========================================================
;=========================================================

; ������� ����������

         ; ����������� �� ����������� ���������������
         ; (dword) ����� � ��������� ������� ������� �� min �� max;
         ; min - ��������� �� ������� ����� �����;
         ; max - ��������� �� ������� ������ �����

QS proc public uses EAX EBX EDX EDI ESI, \
                  min: ptr dword, max: ptr dword

local dwDiv2: dword          ; ��������� ��������� ����������
mov dwDiv2, 2                ; ����������� �� �������� "2"

mov EDI, min                 ; � EDI - ����� ������
mov ESI, max                 ; � ESI - ����� �������

mov EAX, [EDI]               ; � EAX - �������� (�� �����) ������
add EAX, [ESI]               ; ���������� EAX �� ��������� �������
mov EDX, 0                   ; �������� EDX (�������������� ��� �������)
div dwDiv2                   ; ����� EAX �� "2"
mov EBX, EAX                 ; � EBX - ������� �������� ������ � �������

.WHILE EDI < ESI             ; ���������, ���� ����� ������ < ������ �������

   .WHILE [EDI] < EBX        ; ���������, ���� �������� ������ < �������� ��������
      add EDI, 4             ; ����������� ����� ������ �� 4 �����
   .ENDW
 
   .WHILE [ESI] > EBX        ; ���������, ���� �������� ������� > �������� ��������
      sub ESI, 4             ; ��������� ����� ������� �� 4 �����
   .ENDW

   .IF EDI <= ESI            ; ���� ����� ������ <= ������ �������
      push [EDI]             ; ����� ����� �������� ����� ����
      push [ESI]
      pop [EDI]
      pop [ESI]
      add EDI, 4             ; ����������� ����� ������ �� 4 �����
      sub ESI, 4             ; ��������� ����� ������� �� 4 �����
   .ENDIF

.ENDW

.IF min < ESI                ; �������� �����
   invoke QS, min, ESI
.ENDIF

.IF EDI < max                ; �������� ������
   invoke QS, EDI, max
.ENDIF

ret                          ; ������� �� ���������

QS endp

END