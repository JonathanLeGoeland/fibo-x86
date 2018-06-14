	%define NL 10
	%define temp [ebp-4]
	%define fibo_curr [ebp-8]
	%define fibo_prev [ebp-12]
	%define array [ebp+8]
	%define N [ebp+12]
;;; !!! IT is currently working !!!
	
;;; The first variation prints the numbers
;;; The second variation stores them in an array
	
;;; This function computes the  N First Fibonacci numbers
;;; Takes two parameter :
;;; 	N in ebp + 12
;;;     array ref in ebp + 8
;;; Return code:
;;;     It is set by the assignation of eax
;;; Python Psedocode
	;; fibo_prev = 1
	;; fibo_curr = 1
	;; temp  = 0
	;; f[0] = fibo_prev
	;; f[1] = fibo_curr
	;; for i in range(2, N):
	;; temp = fibo_prev + fibo_curr
	;;     fibo_prev = fibo_curr
	;;     fibo_curr = temp
	;;     f[i] = fibo_curr

	segment .text
	global calc_fibo_1
calc_fibo_1:
	enter 12,0  		; Make space for 3 dwords
	;; pusha			
	push ecx
	push ebx

	;; Read the reference to the array and sotre it in eax.
	mov eax, array
	;; Read the Argument N and store it in ecx.
	mov ecx, N
	sub ecx, 2
	;; Initiate the variables
	;; fibo_prev = 1
	mov ebx, 1
	mov fibo_prev, ebx
	;; fibo_curr = 1
	mov ebx, 1
	mov fibo_curr, ebx
	;; temp = 0
	mov ebx, 0
	mov temp,      ebx
	;; array[0] = fibo_prev
	mov ebx, fibo_prev
	mov [eax], ebx		; Assignation
	add eax, 4		; 0Move the array pointer
	;; array[1] = fibo_curr
	mov ebx, fibo_curr
	mov [eax], ebx
	add eax, 4		; Move the array pointer
	
	;; Perform the loop
loop_start:
	;; temp = fibo_prev + fibo_curr
	mov ebx, fibo_prev
	add ebx, fibo_curr
	;; If we have a carry, we cannot do it on 32 bits anymore.
	jc end_ko			; Exit in case of carry 
	mov temp, ebx
	;;     fibo_prev = fibo_curr
	mov ebx, fibo_curr
	mov fibo_prev, ebx
	;;     fibo_curr = temp
	mov ebx, temp
	mov fibo_curr, ebx
	;; Store fibo_curr : array[i] = fibo_curr
	mov ebx, fibo_curr
	mov [eax], ebx
	add eax, 4 		; i++
	loop loop_start
	jmp end_ok
end_ko:
	mov eax, 1
	jmp end
end_ok:
	mov eax, 0
	jmp end
end:	
	pop ebx
	pop ecx
	leave
	ret
