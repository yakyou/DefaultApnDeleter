@echo off
REM �O��F�C���^�[�t�F�C�X�́u�g�ѓd�b�v�ł�����̂Ƃ���B
REM �O��F�������ݒ肵��APN�����ɑ��݂��Ă�����̂Ƃ���B
REM �O��F�����APN��2�̃v���t�@�C����1��APN���\�����Ă�����̂Ƃ���B
REM �O��F�������ݒ肵��APN��name��{}�ň͂��Ă�����̂Ƃ��A�����APN�͈͂��Ă��Ȃ����̂Ƃ���B
setlocal enabledelayedexpansion
set profiles=
for /f "usebackq tokens=*" %%i in (`netsh mbn show profile`) do (
set profiles=!profiles!^
%%i
)
REM echo %profiles%
REM echo %profiles:~0,23%
REM echo %profiles:~23,37%
set str=%profiles%
set len=0
:LOOP
if not "%str%"=="" (
	set str=%str:~1%
	set /a len=%len%+1
	goto :LOOP
)
if %len% LEQ 98 (
	REM echo �����Őݒ肵��APN�������݂��Ȃ��悤�ł�
) else (
	if %profiles:~60,1% == { (
		REM echo %profiles:~60,38%
		REM echo 1�s�ڂ͎����Őݒ肵��APN�Ȃ̂Ŏc��
		REM echo %profiles:~98,36%
		REM echo 2�s�ڂ͊����APN�Ȃ̂ŏ���
		netsh mbn delete profile interface="�g�ѓd�b" name="%profiles:~98,36%"
		REM echo %profiles:~134,36%
		REM echo 3�s�ڂ͊����APN�Ȃ̂ŏ���
		netsh mbn delete profile interface="�g�ѓd�b" name="%profiles:~134,36%"
	) else (
		REM echo %profiles:~60,36%
		REM echo 1�s�ڂ͊����APN�Ȃ̂ŏ���
		netsh mbn delete profile interface="�g�ѓd�b" name="%profiles:~60,36%"
		if %profiles:~96,1% == { (
			REM echo %profiles:~96,38%
			REM echo 2�s�ڂ͎����Őݒ肵��APN�Ȃ̂Ŏc��
			REM echo %profiles:~134,36%
			REM echo 3�s�ڂ͊����APN�Ȃ̂ŏ���
			netsh mbn delete profile interface="�g�ѓd�b" name="%profiles:~134,36%"
		) else (
			REM echo %profiles:~96,36%
			REM echo 2�s�ڂ͊����APN�Ȃ̂ŏ���
			netsh mbn delete profile interface="�g�ѓd�b" name="%profiles:~96,36%"
			REM echo %profiles:~134,38%
			REM echo 3�s�ڂ͎����Őݒ肵��APN�Ȃ̂Ŏc��
		)
	)
)
endlocal
