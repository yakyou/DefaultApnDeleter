@echo off
REM 前提：インターフェイスは「携帯電話」であるものとする。
REM 前提：自分が設定したAPNが既に存在しているものとする。
REM 前提：既定のAPNは2つのプロファイルで1つのAPNを構成しているものとする。
REM 前提：自分が設定したAPNのnameは{}で囲われているものとし、既定のAPNは囲われていないものとする。
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
	REM echo 自分で設定したAPNしか存在しないようです
) else (
	if %profiles:~60,1% == { (
		REM echo %profiles:~60,38%
		REM echo 1行目は自分で設定したAPNなので残す
		REM echo %profiles:~98,36%
		REM echo 2行目は既定のAPNなので消す
		netsh mbn delete profile interface="携帯電話" name="%profiles:~98,36%"
		REM echo %profiles:~134,36%
		REM echo 3行目は既定のAPNなので消す
		netsh mbn delete profile interface="携帯電話" name="%profiles:~134,36%"
	) else (
		REM echo %profiles:~60,36%
		REM echo 1行目は既定のAPNなので消す
		netsh mbn delete profile interface="携帯電話" name="%profiles:~60,36%"
		if %profiles:~96,1% == { (
			REM echo %profiles:~96,38%
			REM echo 2行目は自分で設定したAPNなので残す
			REM echo %profiles:~134,36%
			REM echo 3行目は既定のAPNなので消す
			netsh mbn delete profile interface="携帯電話" name="%profiles:~134,36%"
		) else (
			REM echo %profiles:~96,36%
			REM echo 2行目は既定のAPNなので消す
			netsh mbn delete profile interface="携帯電話" name="%profiles:~96,36%"
			REM echo %profiles:~134,38%
			REM echo 3行目は自分で設定したAPNなので残す
		)
	)
)
endlocal
