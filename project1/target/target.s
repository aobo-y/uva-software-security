
target/target:	file format Mach-O 64-bit x86-64

Disassembly of section __TEXT,__text:
__text:
; {
10ddc8c90:	55 	pushq	%rbp
10ddc8c91:	48 89 e5 	movq	%rsp, %rbp
10ddc8c94:	48 81 ec 60 02 00 00 	subq	$608, %rsp
10ddc8c9b:	48 8d 05 ee 02 00 00 	leaq	750(%rip), %rax
10ddc8ca2:	48 8b 0d 57 03 00 00 	movq	855(%rip), %rcx
10ddc8ca9:	48 8b 09 	movq	(%rcx), %rcx
10ddc8cac:	48 89 4d f8 	movq	%rcx, -8(%rbp)
10ddc8cb0:	c7 85 fc fd ff ff 00 00 00 00 	movl	$0, -516(%rbp)
10ddc8cba:	89 bd f8 fd ff ff 	movl	%edi, -520(%rbp)
10ddc8cc0:	48 89 b5 f0 fd ff ff 	movq	%rsi, -528(%rbp)
; char* strTestString = "String Test\n";
10ddc8cc7:	48 89 85 e0 fd ff ff 	movq	%rax, -544(%rbp)
; int bGoWrong = (argc > 1);
10ddc8cce:	83 bd f8 fd ff ff 01 	cmpl	$1, -520(%rbp)
10ddc8cd5:	0f 9f c2 	setg	%dl
10ddc8cd8:	80 e2 01 	andb	$1, %dl
10ddc8cdb:	0f b6 fa 	movzbl	%dl, %edi
10ddc8cde:	89 bd d8 fd ff ff 	movl	%edi, -552(%rbp)
; for( i = 0; i < 20; i++ ){
10ddc8ce4:	c7 85 d4 fd ff ff 00 00 00 00 	movl	$0, -556(%rbp)
10ddc8cee:	83 bd d4 fd ff ff 14 	cmpl	$20, -556(%rbp)
10ddc8cf5:	0f 8d 54 00 00 00 	jge	84 <_main+0xBF>
; dblData[i] = (double)rand()/i+1;
10ddc8cfb:	e8 3c 02 00 00 	callq	572
10ddc8d00:	f2 0f 10 05 80 02 00 00 	movsd	640(%rip), %xmm0
10ddc8d08:	f2 0f 2a c8 	cvtsi2sdl	%eax, %xmm1
10ddc8d0c:	f2 0f 2a 95 d4 fd ff ff 	cvtsi2sdl	-556(%rbp), %xmm2
10ddc8d14:	f2 0f 5e ca 	divsd	%xmm2, %xmm1
10ddc8d18:	f2 0f 58 c8 	addsd	%xmm0, %xmm1
10ddc8d1c:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8d23:	f2 0f 11 8c cd 50 ff ff ff 	movsd	%xmm1, -176(%rbp,%rcx,8)
; nCntDbl++;
10ddc8d2c:	8b 85 ec fd ff ff 	movl	-532(%rbp), %eax
10ddc8d32:	83 c0 01 	addl	$1, %eax
10ddc8d35:	89 85 ec fd ff ff 	movl	%eax, -532(%rbp)
; for( i = 0; i < 20; i++ ){
10ddc8d3b:	8b 85 d4 fd ff ff 	movl	-556(%rbp), %eax
10ddc8d41:	83 c0 01 	addl	$1, %eax
10ddc8d44:	89 85 d4 fd ff ff 	movl	%eax, -556(%rbp)
10ddc8d4a:	e9 9f ff ff ff 	jmp	-97 <_main+0x5E>
; for( i = 0; i < 20; i++ ){
10ddc8d4f:	c7 85 d4 fd ff ff 00 00 00 00 	movl	$0, -556(%rbp)
10ddc8d59:	83 bd d4 fd ff ff 14 	cmpl	$20, -556(%rbp)
10ddc8d60:	0f 8d 54 00 00 00 	jge	84 <_main+0x12A>
; flData[i] = (float)rand()/i+1;
10ddc8d66:	e8 d1 01 00 00 	callq	465
10ddc8d6b:	f3 0f 10 05 0d 02 00 00 	movss	525(%rip), %xmm0
10ddc8d73:	f3 0f 2a c8 	cvtsi2ssl	%eax, %xmm1
10ddc8d77:	f3 0f 2a 95 d4 fd ff ff 	cvtsi2ssl	-556(%rbp), %xmm2
10ddc8d7f:	f3 0f 5e ca 	divss	%xmm2, %xmm1
10ddc8d83:	f3 0f 58 c8 	addss	%xmm0, %xmm1
10ddc8d87:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8d8e:	f3 0f 11 8c 8d 00 ff ff ff 	movss	%xmm1, -256(%rbp,%rcx,4)
; nCntFl++;
10ddc8d97:	8b 85 e8 fd ff ff 	movl	-536(%rbp), %eax
10ddc8d9d:	83 c0 01 	addl	$1, %eax
10ddc8da0:	89 85 e8 fd ff ff 	movl	%eax, -536(%rbp)
; for( i = 0; i < 20; i++ ){
10ddc8da6:	8b 85 d4 fd ff ff 	movl	-556(%rbp), %eax
10ddc8dac:	83 c0 01 	addl	$1, %eax
10ddc8daf:	89 85 d4 fd ff ff 	movl	%eax, -556(%rbp)
10ddc8db5:	e9 9f ff ff ff 	jmp	-97 <_main+0xC9>
; for( i = 0; i < strlen(strTestString ); i++ ) {
10ddc8dba:	c7 85 d4 fd ff ff 00 00 00 00 	movl	$0, -556(%rbp)
10ddc8dc4:	48 63 85 d4 fd ff ff 	movslq	-556(%rbp), %rax
10ddc8dcb:	48 8b bd e0 fd ff ff 	movq	-544(%rbp), %rdi
10ddc8dd2:	48 89 85 c0 fd ff ff 	movq	%rax, -576(%rbp)
10ddc8dd9:	e8 64 01 00 00 	callq	356
10ddc8dde:	48 8b bd c0 fd ff ff 	movq	-576(%rbp), %rdi
10ddc8de5:	48 39 c7 	cmpq	%rax, %rdi
10ddc8de8:	0f 83 42 00 00 00 	jae	66 <_main+0x1A0>
; strData[i] = strTestString [i];
10ddc8dee:	48 8b 85 e0 fd ff ff 	movq	-544(%rbp), %rax
10ddc8df5:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8dfc:	8a 14 08 	movb	(%rax,%rcx), %dl
10ddc8dff:	48 63 85 d4 fd ff ff 	movslq	-556(%rbp), %rax
10ddc8e06:	88 94 05 00 fe ff ff 	movb	%dl, -512(%rbp,%rax)
; nStrLen++;
10ddc8e0d:	8b b5 dc fd ff ff 	movl	-548(%rbp), %esi
10ddc8e13:	83 c6 01 	addl	$1, %esi
10ddc8e16:	89 b5 dc fd ff ff 	movl	%esi, -548(%rbp)
; for( i = 0; i < strlen(strTestString ); i++ ) {
10ddc8e1c:	8b 85 d4 fd ff ff 	movl	-556(%rbp), %eax
10ddc8e22:	83 c0 01 	addl	$1, %eax
10ddc8e25:	89 85 d4 fd ff ff 	movl	%eax, -556(%rbp)
10ddc8e2b:	e9 94 ff ff ff 	jmp	-108 <_main+0x134>
; strData[i] = 0;
10ddc8e30:	48 63 85 d4 fd ff ff 	movslq	-556(%rbp), %rax
10ddc8e37:	c6 84 05 00 fe ff ff 00 	movb	$0, -512(%rbp,%rax)
; if( bGoWrong ) {
10ddc8e3f:	83 bd d8 fd ff ff 00 	cmpl	$0, -552(%rbp)
10ddc8e46:	0f 84 91 00 00 00 	je	145 <_main+0x24D>
10ddc8e4c:	48 8d 3d 4a 01 00 00 	leaq	330(%rip), %rdi
; printf("gowrong\n");
10ddc8e53:	b0 00 	movb	$0, %al
10ddc8e55:	e8 dc 00 00 00 	callq	220
10ddc8e5a:	48 8d bd 50 ff ff ff 	leaq	-176(%rbp), %rdi
; char* pbuf = (char*)dblData;
10ddc8e61:	48 89 bd c8 fd ff ff 	movq	%rdi, -568(%rbp)
; for( i = 0; i < strlen(strTestString); i++ ) {
10ddc8e68:	c7 85 d4 fd ff ff 00 00 00 00 	movl	$0, -556(%rbp)
10ddc8e72:	89 85 bc fd ff ff 	movl	%eax, -580(%rbp)
10ddc8e78:	48 63 85 d4 fd ff ff 	movslq	-556(%rbp), %rax
10ddc8e7f:	48 8b bd e0 fd ff ff 	movq	-544(%rbp), %rdi
10ddc8e86:	48 89 85 b0 fd ff ff 	movq	%rax, -592(%rbp)
10ddc8e8d:	e8 b0 00 00 00 	callq	176
10ddc8e92:	48 8b bd b0 fd ff ff 	movq	-592(%rbp), %rdi
10ddc8e99:	48 39 c7 	cmpq	%rax, %rdi
10ddc8e9c:	0f 83 36 00 00 00 	jae	54 <_main+0x248>
; pbuf[i] = strTestString[i];
10ddc8ea2:	48 8b 85 e0 fd ff ff 	movq	-544(%rbp), %rax
10ddc8ea9:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8eb0:	8a 14 08 	movb	(%rax,%rcx), %dl
10ddc8eb3:	48 8b 85 c8 fd ff ff 	movq	-568(%rbp), %rax
10ddc8eba:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8ec1:	88 14 08 	movb	%dl, (%rax,%rcx)
; for( i = 0; i < strlen(strTestString); i++ ) {
10ddc8ec4:	8b 85 d4 fd ff ff 	movl	-556(%rbp), %eax
10ddc8eca:	83 c0 01 	addl	$1, %eax
10ddc8ecd:	89 85 d4 fd ff ff 	movl	%eax, -556(%rbp)
10ddc8ed3:	e9 a0 ff ff ff 	jmp	-96 <_main+0x1E8>
; }
10ddc8ed8:	e9 00 00 00 00 	jmp	0 <_main+0x24D>
10ddc8edd:	48 8d 3d c2 00 00 00 	leaq	194(%rip), %rdi
10ddc8ee4:	48 8d b5 00 fe ff ff 	leaq	-512(%rbp), %rsi
; printf("%f %lf %s\n", dblData[1], flData[2], strData);
10ddc8eeb:	f2 0f 10 85 58 ff ff ff 	movsd	-168(%rbp), %xmm0
10ddc8ef3:	f3 0f 5a 8d 08 ff ff ff 	cvtss2sd	-248(%rbp), %xmm1
10ddc8efb:	b0 02 	movb	$2, %al
10ddc8efd:	e8 34 00 00 00 	callq	52
10ddc8f02:	48 8b 35 f7 00 00 00 	movq	247(%rip), %rsi
10ddc8f09:	48 8b 36 	movq	(%rsi), %rsi
10ddc8f0c:	48 8b 7d f8 	movq	-8(%rbp), %rdi
10ddc8f10:	48 39 fe 	cmpq	%rdi, %rsi
10ddc8f13:	89 85 ac fd ff ff 	movl	%eax, -596(%rbp)
10ddc8f19:	0f 85 0b 00 00 00 	jne	11 <_main+0x29A>
10ddc8f1f:	31 c0 	xorl	%eax, %eax
; return 0;
10ddc8f21:	48 81 c4 60 02 00 00 	addq	$608, %rsp
10ddc8f28:	5d 	popq	%rbp
10ddc8f29:	c3 	retq
10ddc8f2a:	e8 01 00 00 00 	callq	1

_main:
; {
10ddc8c90:	55 	pushq	%rbp
10ddc8c91:	48 89 e5 	movq	%rsp, %rbp
10ddc8c94:	48 81 ec 60 02 00 00 	subq	$608, %rsp
10ddc8c9b:	48 8d 05 ee 02 00 00 	leaq	750(%rip), %rax
10ddc8ca2:	48 8b 0d 57 03 00 00 	movq	855(%rip), %rcx
10ddc8ca9:	48 8b 09 	movq	(%rcx), %rcx
10ddc8cac:	48 89 4d f8 	movq	%rcx, -8(%rbp)
10ddc8cb0:	c7 85 fc fd ff ff 00 00 00 00 	movl	$0, -516(%rbp)
10ddc8cba:	89 bd f8 fd ff ff 	movl	%edi, -520(%rbp)
10ddc8cc0:	48 89 b5 f0 fd ff ff 	movq	%rsi, -528(%rbp)
; char* strTestString = "String Test\n";
10ddc8cc7:	48 89 85 e0 fd ff ff 	movq	%rax, -544(%rbp)
; int bGoWrong = (argc > 1);
10ddc8cce:	83 bd f8 fd ff ff 01 	cmpl	$1, -520(%rbp)
10ddc8cd5:	0f 9f c2 	setg	%dl
10ddc8cd8:	80 e2 01 	andb	$1, %dl
10ddc8cdb:	0f b6 fa 	movzbl	%dl, %edi
10ddc8cde:	89 bd d8 fd ff ff 	movl	%edi, -552(%rbp)
; for( i = 0; i < 20; i++ ){
10ddc8ce4:	c7 85 d4 fd ff ff 00 00 00 00 	movl	$0, -556(%rbp)
10ddc8cee:	83 bd d4 fd ff ff 14 	cmpl	$20, -556(%rbp)
10ddc8cf5:	0f 8d 54 00 00 00 	jge	84 <_main+0xBF>
; dblData[i] = (double)rand()/i+1;
10ddc8cfb:	e8 3c 02 00 00 	callq	572
10ddc8d00:	f2 0f 10 05 80 02 00 00 	movsd	640(%rip), %xmm0
10ddc8d08:	f2 0f 2a c8 	cvtsi2sdl	%eax, %xmm1
10ddc8d0c:	f2 0f 2a 95 d4 fd ff ff 	cvtsi2sdl	-556(%rbp), %xmm2
10ddc8d14:	f2 0f 5e ca 	divsd	%xmm2, %xmm1
10ddc8d18:	f2 0f 58 c8 	addsd	%xmm0, %xmm1
10ddc8d1c:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8d23:	f2 0f 11 8c cd 50 ff ff ff 	movsd	%xmm1, -176(%rbp,%rcx,8)
; nCntDbl++;
10ddc8d2c:	8b 85 ec fd ff ff 	movl	-532(%rbp), %eax
10ddc8d32:	83 c0 01 	addl	$1, %eax
10ddc8d35:	89 85 ec fd ff ff 	movl	%eax, -532(%rbp)
; for( i = 0; i < 20; i++ ){
10ddc8d3b:	8b 85 d4 fd ff ff 	movl	-556(%rbp), %eax
10ddc8d41:	83 c0 01 	addl	$1, %eax
10ddc8d44:	89 85 d4 fd ff ff 	movl	%eax, -556(%rbp)
10ddc8d4a:	e9 9f ff ff ff 	jmp	-97 <_main+0x5E>
; for( i = 0; i < 20; i++ ){
10ddc8d4f:	c7 85 d4 fd ff ff 00 00 00 00 	movl	$0, -556(%rbp)
10ddc8d59:	83 bd d4 fd ff ff 14 	cmpl	$20, -556(%rbp)
10ddc8d60:	0f 8d 54 00 00 00 	jge	84 <_main+0x12A>
; flData[i] = (float)rand()/i+1;
10ddc8d66:	e8 d1 01 00 00 	callq	465
10ddc8d6b:	f3 0f 10 05 0d 02 00 00 	movss	525(%rip), %xmm0
10ddc8d73:	f3 0f 2a c8 	cvtsi2ssl	%eax, %xmm1
10ddc8d77:	f3 0f 2a 95 d4 fd ff ff 	cvtsi2ssl	-556(%rbp), %xmm2
10ddc8d7f:	f3 0f 5e ca 	divss	%xmm2, %xmm1
10ddc8d83:	f3 0f 58 c8 	addss	%xmm0, %xmm1
10ddc8d87:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8d8e:	f3 0f 11 8c 8d 00 ff ff ff 	movss	%xmm1, -256(%rbp,%rcx,4)
; nCntFl++;
10ddc8d97:	8b 85 e8 fd ff ff 	movl	-536(%rbp), %eax
10ddc8d9d:	83 c0 01 	addl	$1, %eax
10ddc8da0:	89 85 e8 fd ff ff 	movl	%eax, -536(%rbp)
; for( i = 0; i < 20; i++ ){
10ddc8da6:	8b 85 d4 fd ff ff 	movl	-556(%rbp), %eax
10ddc8dac:	83 c0 01 	addl	$1, %eax
10ddc8daf:	89 85 d4 fd ff ff 	movl	%eax, -556(%rbp)
10ddc8db5:	e9 9f ff ff ff 	jmp	-97 <_main+0xC9>
; for( i = 0; i < strlen(strTestString ); i++ ) {
10ddc8dba:	c7 85 d4 fd ff ff 00 00 00 00 	movl	$0, -556(%rbp)
10ddc8dc4:	48 63 85 d4 fd ff ff 	movslq	-556(%rbp), %rax
10ddc8dcb:	48 8b bd e0 fd ff ff 	movq	-544(%rbp), %rdi
10ddc8dd2:	48 89 85 c0 fd ff ff 	movq	%rax, -576(%rbp)
10ddc8dd9:	e8 64 01 00 00 	callq	356
10ddc8dde:	48 8b bd c0 fd ff ff 	movq	-576(%rbp), %rdi
10ddc8de5:	48 39 c7 	cmpq	%rax, %rdi
10ddc8de8:	0f 83 42 00 00 00 	jae	66 <_main+0x1A0>
; strData[i] = strTestString [i];
10ddc8dee:	48 8b 85 e0 fd ff ff 	movq	-544(%rbp), %rax
10ddc8df5:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8dfc:	8a 14 08 	movb	(%rax,%rcx), %dl
10ddc8dff:	48 63 85 d4 fd ff ff 	movslq	-556(%rbp), %rax
10ddc8e06:	88 94 05 00 fe ff ff 	movb	%dl, -512(%rbp,%rax)
; nStrLen++;
10ddc8e0d:	8b b5 dc fd ff ff 	movl	-548(%rbp), %esi
10ddc8e13:	83 c6 01 	addl	$1, %esi
10ddc8e16:	89 b5 dc fd ff ff 	movl	%esi, -548(%rbp)
; for( i = 0; i < strlen(strTestString ); i++ ) {
10ddc8e1c:	8b 85 d4 fd ff ff 	movl	-556(%rbp), %eax
10ddc8e22:	83 c0 01 	addl	$1, %eax
10ddc8e25:	89 85 d4 fd ff ff 	movl	%eax, -556(%rbp)
10ddc8e2b:	e9 94 ff ff ff 	jmp	-108 <_main+0x134>
; strData[i] = 0;
10ddc8e30:	48 63 85 d4 fd ff ff 	movslq	-556(%rbp), %rax
10ddc8e37:	c6 84 05 00 fe ff ff 00 	movb	$0, -512(%rbp,%rax)
; if( bGoWrong ) {
10ddc8e3f:	83 bd d8 fd ff ff 00 	cmpl	$0, -552(%rbp)
10ddc8e46:	0f 84 91 00 00 00 	je	145 <_main+0x24D>
10ddc8e4c:	48 8d 3d 4a 01 00 00 	leaq	330(%rip), %rdi
; printf("gowrong\n");
10ddc8e53:	b0 00 	movb	$0, %al
10ddc8e55:	e8 dc 00 00 00 	callq	220
10ddc8e5a:	48 8d bd 50 ff ff ff 	leaq	-176(%rbp), %rdi
; char* pbuf = (char*)dblData;
10ddc8e61:	48 89 bd c8 fd ff ff 	movq	%rdi, -568(%rbp)
; for( i = 0; i < strlen(strTestString); i++ ) {
10ddc8e68:	c7 85 d4 fd ff ff 00 00 00 00 	movl	$0, -556(%rbp)
10ddc8e72:	89 85 bc fd ff ff 	movl	%eax, -580(%rbp)
10ddc8e78:	48 63 85 d4 fd ff ff 	movslq	-556(%rbp), %rax
10ddc8e7f:	48 8b bd e0 fd ff ff 	movq	-544(%rbp), %rdi
10ddc8e86:	48 89 85 b0 fd ff ff 	movq	%rax, -592(%rbp)
10ddc8e8d:	e8 b0 00 00 00 	callq	176
10ddc8e92:	48 8b bd b0 fd ff ff 	movq	-592(%rbp), %rdi
10ddc8e99:	48 39 c7 	cmpq	%rax, %rdi
10ddc8e9c:	0f 83 36 00 00 00 	jae	54 <_main+0x248>
; pbuf[i] = strTestString[i];
10ddc8ea2:	48 8b 85 e0 fd ff ff 	movq	-544(%rbp), %rax
10ddc8ea9:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8eb0:	8a 14 08 	movb	(%rax,%rcx), %dl
10ddc8eb3:	48 8b 85 c8 fd ff ff 	movq	-568(%rbp), %rax
10ddc8eba:	48 63 8d d4 fd ff ff 	movslq	-556(%rbp), %rcx
10ddc8ec1:	88 14 08 	movb	%dl, (%rax,%rcx)
; for( i = 0; i < strlen(strTestString); i++ ) {
10ddc8ec4:	8b 85 d4 fd ff ff 	movl	-556(%rbp), %eax
10ddc8eca:	83 c0 01 	addl	$1, %eax
10ddc8ecd:	89 85 d4 fd ff ff 	movl	%eax, -556(%rbp)
10ddc8ed3:	e9 a0 ff ff ff 	jmp	-96 <_main+0x1E8>
; }
10ddc8ed8:	e9 00 00 00 00 	jmp	0 <_main+0x24D>
10ddc8edd:	48 8d 3d c2 00 00 00 	leaq	194(%rip), %rdi
10ddc8ee4:	48 8d b5 00 fe ff ff 	leaq	-512(%rbp), %rsi
; printf("%f %lf %s\n", dblData[1], flData[2], strData);
10ddc8eeb:	f2 0f 10 85 58 ff ff ff 	movsd	-168(%rbp), %xmm0
10ddc8ef3:	f3 0f 5a 8d 08 ff ff ff 	cvtss2sd	-248(%rbp), %xmm1
10ddc8efb:	b0 02 	movb	$2, %al
10ddc8efd:	e8 34 00 00 00 	callq	52
10ddc8f02:	48 8b 35 f7 00 00 00 	movq	247(%rip), %rsi
10ddc8f09:	48 8b 36 	movq	(%rsi), %rsi
10ddc8f0c:	48 8b 7d f8 	movq	-8(%rbp), %rdi
10ddc8f10:	48 39 fe 	cmpq	%rdi, %rsi
10ddc8f13:	89 85 ac fd ff ff 	movl	%eax, -596(%rbp)
10ddc8f19:	0f 85 0b 00 00 00 	jne	11 <_main+0x29A>
10ddc8f1f:	31 c0 	xorl	%eax, %eax
; return 0;
10ddc8f21:	48 81 c4 60 02 00 00 	addq	$608, %rsp
10ddc8f28:	5d 	popq	%rbp
10ddc8f29:	c3 	retq
10ddc8f2a:	e8 01 00 00 00 	callq	1
Disassembly of section __TEXT,__stubs:
__stubs:
10ddc8f30:	ff 25 e2 00 00 00 	jmpq	*226(%rip)
10ddc8f36:	ff 25 e4 00 00 00 	jmpq	*228(%rip)
10ddc8f3c:	ff 25 e6 00 00 00 	jmpq	*230(%rip)
10ddc8f42:	ff 25 e8 00 00 00 	jmpq	*232(%rip)
Disassembly of section __TEXT,__stub_helper:
__stub_helper:
10ddc8f48:	4c 8d 1d c1 00 00 00 	leaq	193(%rip), %r11
10ddc8f4f:	41 53 	pushq	%r11
10ddc8f51:	ff 25 b1 00 00 00 	jmpq	*177(%rip)
10ddc8f57:	90 	nop
10ddc8f58:	68 00 00 00 00 	pushq	$0
10ddc8f5d:	e9 e6 ff ff ff 	jmp	-26 </var/folders/_r/62612bvj1fb0gw4b1tzs1v0w0000gn/T/target-b056b7.o+0xA4539AFE>
10ddc8f62:	68 18 00 00 00 	pushq	$24
10ddc8f67:	e9 dc ff ff ff 	jmp	-36 </var/folders/_r/62612bvj1fb0gw4b1tzs1v0w0000gn/T/target-b056b7.o+0xA4539AFE>
10ddc8f6c:	68 26 00 00 00 	pushq	$38
10ddc8f71:	e9 d2 ff ff ff 	jmp	-46 </var/folders/_r/62612bvj1fb0gw4b1tzs1v0w0000gn/T/target-b056b7.o+0xA4539AFE>
10ddc8f76:	68 32 00 00 00 	pushq	$50
10ddc8f7b:	e9 c8 ff ff ff 	jmp	-56 </var/folders/_r/62612bvj1fb0gw4b1tzs1v0w0000gn/T/target-b056b7.o+0xA4539AFE>
