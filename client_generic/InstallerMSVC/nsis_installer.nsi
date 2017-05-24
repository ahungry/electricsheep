; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "Electric Sheep"
!define PRODUCT_SCR_STRING "es.scr"
!define PRODUCT_EXE_STRING "es.exe"
!define PRODUCT_VERSION "3.0"
!define PRODUCT_PUBLISHER "Electricsheep"
!define PRODUCT_WEB_SITE "http://www.electricsheep.org"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\Flam3.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor /SOLID /FINAL zlib
XPStyle	on
;Icon "..\client\app.ico" ; must be 32x32x16
;UninstallIcon "..\client\app.ico"
;AllowSkipFiles off
RequestExecutionLevel admin

; MUI 1.67 compatible ------
!include "MUI.nsh"
!include "readme.nsh"
;!include "addtopath.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME

; Readme page
!insertmacro MUI_PAGE_README	"..\Runtime\Instructions.rtf"

; License page
!insertmacro MUI_PAGE_LICENSE "..\Runtime\License.rtf"

; Directory page
!insertmacro MUI_PAGE_DIRECTORY

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES

; Finish page
;!define MUI_PAGE_CUSTOMFUNCTION_PRE CustomOptions
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES\Electric Sheep"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
	SetOverwrite on
	SetOutPath "$TEMP" ; DirectX SDK components
	File "..\RuntimeMSVC\Jun2010_D3DCompiler_43_x86.cab"
	File "..\RuntimeMSVC\Jun2010_d3dx9_43_x86.cab"
	File "..\RuntimeMSVC\dsetup32.dll"
	File "..\RuntimeMSVC\DSETUP.dll"
	File "..\RuntimeMSVC\dxdllreg_x86.cab"
	File "..\RuntimeMSVC\dxnt.cab"
	File "..\RuntimeMSVC\DXSETUP.exe"
	File "..\RuntimeMSVC\dxupdate.cab"
	
	ExecWait '"$TEMP\DXSETUP.exe" /silent'
	Delete "..\RuntimeMSVC\Jun2010_D3DCompiler_43_x86.cab"
	Delete "..\RuntimeMSVC\Jun2010_d3dx9_43_x86.cab"
	Delete "..\RuntimeMSVC\dsetup32.dll"
	Delete "..\RuntimeMSVC\DSETUP.dll"
	Delete "..\RuntimeMSVC\dxdllreg_x86.cab"
	Delete "..\RuntimeMSVC\dxnt.cab"
	Delete "..\RuntimeMSVC\DXSETUP.exe"
	Delete "..\RuntimeMSVC\dxupdate.cab"
	
	SetOutPath "$WINDIR"
	File "..\RuntimeMSVC\${PRODUCT_EXE_STRING}"
	File "..\RuntimeMSVC\${PRODUCT_SCR_STRING}"
	File "..\RuntimeMSVC\exchndl.dll" ; RPT debugging
	
	File "..\RuntimeMSVC\pthreadGC2.dll" ; for flam3

	File "..\RuntimeMSVC\avcodec-57.dll"   ; for ffmpeg
	File "..\RuntimeMSVC\avformat-57.dll"  ; for ffmpeg
	File "..\RuntimeMSVC\avutil-55.dll"    ; for ffmpeg
	File "..\RuntimeMSVC\swresample-2.dll" ; for ffmpeg
	File "..\RuntimeMSVC\swscale-4.dll"    ; for ffmpeg
	
	SetOutPath "$INSTDIR"
	
	CreateShortCut "$INSTDIR\SheepConfig.lnk" "$INSTDIR\settingsgui.exe"
	
	File "..\RuntimeMSVC\setacl.exe"
	
	File "..\RuntimeMSVC\electricsheep-smile.png"
	File "..\RuntimeMSVC\electricsheep-frown.png"
	File "..\RuntimeMSVC\electricsheep-attr.png"
	File "..\RuntimeMSVC\Instructions.rtf"
	File "..\RuntimeMSVC\License.rtf"
	File "..\RuntimeMSVC\logo.png"
	;exe files
    	File "..\RuntimeMSVC\flam3-animate.exe"
    	File "..\RuntimeMSVC\settingsgui.exe"
	;scripts
	SetOutPath "$INSTDIR\Scripts"
	File "..\RuntimeMSVC\Scripts\class.lua"
	File "..\RuntimeMSVC\Scripts\histogram.lua"
	File "..\RuntimeMSVC\Scripts\playlist.lua"
	File "..\RuntimeMSVC\Scripts\pq.lua"
	File "..\RuntimeMSVC\Scripts\serialize.lua"
	SetOutPath "$INSTDIR\Scripts\logging"
	File "..\RuntimeMSVC\Scripts\logging\console.lua"
	File "..\RuntimeMSVC\Scripts\logging\file.lua"
	File "..\RuntimeMSVC\Scripts\logging\localized.lua"
	File "..\RuntimeMSVC\Scripts\logging\logging.lua"
	File "..\RuntimeMSVC\Scripts\logging\null.lua"
	
	SetShellVarContext all
	CreateDirectory "$APPDATA\ElectricSheep"
	AccessControl::GrantOnFile "$APPDATA\ElectricSheep" "(S-1-1-0)" "FullAccess"
	CreateDirectory "$APPDATA\ElectricSheep\Logs"
	AccessControl::GrantOnFile "$APPDATA\ElectricSheep\Logs" "(S-1-1-0)" "FullAccess"
	CreateDirectory "$APPDATA\ElectricSheep\content"
	AccessControl::GrantOnFile "$APPDATA\ElectricSheep\content" "(S-1-1-0)" "FullAccess"
	AccessControl::GrantOnFile "$WINDIR\${PRODUCT_SCR_STRING}" "(S-1-1-0)" "GenericRead"
	AccessControl::GrantOnFile "$WINDIR\${PRODUCT_SCR_STRING}" "(S-1-1-0)" "GenericExecute"
	;CreateDirectory "$APPDATA\ElectricSheep\content\mpeg"
	;AccessControl::GrantOnFile "$APPDATA\ElectricSheep\content\mpeg" "(S-1-1-0)" "FullAccess"
	
	;SetOutPath "$APPDATA\ElectricSheep\content\mpeg"
	;File "..\flock100mb\00244=02682=02229=02370.avi"
	;File "..\flock100mb\00244=02710=02370=02256.avi"
	;File "..\flock100mb\00244=02719=02373=02371.avi"
	;File "..\flock100mb\00244=02753=02375=02373.avi"
	;File "..\flock100mb\00244=04027=04027=04027.avi"
	;File "..\flock100mb\00244=04668=02603=02619.avi"
	;File "..\flock100mb\00244=04669=02619=02603.avi"
	;File "..\flock100mb\00244=04822=02619=02378.avi"
	;File "..\flock100mb\00244=04846=02378=04843.avi"
	;File "..\flock100mb\00244=04918=02378=02375.avi"
	;File "..\flock100mb\00244=06309=02764=02619.avi"
	;File "..\flock100mb\00244=06748=02767=02619.avi"
	;File "..\flock100mb\00244=06888=02619=02768.avi"
	;File "..\flock100mb\00244=10482=10482=10482.avi"
	;File "..\flock100mb\00244=11008=02768=05036.avi"
	;File "..\flock100mb\00244=11065=03714=04027.avi"
	;File "..\flock100mb\00244=11066=04027=05963.avi"
	;File "..\flock100mb\00244=11105=11103=04027.avi"
	;File "..\flock100mb\00244=11243=04027=11242.avi"
	;File "..\flock100mb\00244=11843=10482=10461.avi"
	;File "..\flock100mb\00244=11844=05963=10478.avi"
	;File "..\flock100mb\00244=12041=10939=10482.avi"
	;File "..\flock100mb\00244=12049=12047=10939.avi"
	;File "..\flock100mb\00244=12097=12097=12097.avi"
	;File "..\flock100mb\00244=12830=12830=12830.avi"
	;File "..\flock100mb\00244=20602=12079=12098.avi"
	;File "..\flock100mb\00244=20611=20609=12098.avi"
	;File "..\flock100mb\00244=20649=12098=12102.avi"
	;File "..\flock100mb\00244=20678=12102=12830.avi"
	;File "..\flock100mb\00244=20695=12097=12832.avi"
	;File "..\flock100mb\00244=20696=12832=12830.avi"
	;File "..\flock100mb\00244=20730=10478=12835.avi"
	;File "..\flock100mb\00244=20731=12830=02370.avi"
	;File "..\flock100mb\00244=20742=20740=12830.avi"
	
	SetShellVarContext current

	SetOutPath "$INSTDIR"
    Call OptionDestopShortcut
    Call OptionCurrentScreensaver

SectionEnd

Section -AdditionalIcons
  SetShellVarContext all
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateDirectory "$SMPROGRAMS\Electric Sheep "
  CreateShortCut "$SMPROGRAMS\Electric Sheep\Settings.lnk" "$INSTDIR\settingsgui.exe"
  CreateShortCut "$SMPROGRAMS\Electric Sheep\Run Fullscreen.lnk" "$WINDIR\${PRODUCT_EXE_STRING}" "-R"
  CreateShortCut "$SMPROGRAMS\Electric Sheep\Run in a window.lnk" "$WINDIR\${PRODUCT_EXE_STRING}" "-X"
  CreateShortCut "$SMPROGRAMS\Electric Sheep\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\Electric Sheep\Uninstall.lnk" "$INSTDIR\uninst.exe"
  SetShellVarContext current
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM SOFTWARE\ElectricSheep "InstallDir" "$INSTDIR"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$WINDIR\es.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
    SetShellVarContext all
	MessageBox MB_YESNO "Would you like to save your sheeps?" IDYES SkipSheepDelete
	RMDir /r "$APPDATA\ElectricSheep"
	SkipSheepDelete:
	
	Delete "$WINDIR\${PRODUCT_EXE_STRING}"
	Delete "$WINDIR\${PRODUCT_SCR_STRING}"
	Delete "$WINDIR\exchndl.dll"
	
	Delete "$WINDIR\pthreadGC2.dll"

;delete ffmpeg;s dll
	Delete "$WINDIR\avcodec-57.dll"
	Delete "$WINDIR\avformat-57.dll"
	Delete "$WINDIR\avutil-55.dll"
	Delete "$WINDIR\swresample-2.dll"
	Delete "$WINDIR\swscale-4.dll"
	
	RMDir /r "$INSTDIR"

;	Push $INSTDIR
;	Call un.RemoveFromPath


	Delete "$APPDATA\ElectricSheep\ElectricSheep.cfg"
	RMDir /r "$APPDATA\ElectricSheep\Logs"
	RMDir /r "$APPDATA\ElectricSheep\Content\xml"
	RMDir /r "$APPDATA\ElectricSheep\Content\jpeg"
	Delete "$APPDATA\ElectricSheep\Content\play_counts.*"
	
	
	Delete	"$DESKTOP\Electric Sheep.lnk"
	Delete "$SMPROGRAMS\Electric Sheep\Settings.lnk"
	Delete "$SMPROGRAMS\Electric Sheep\Run Fullscreen.lnk"
	Delete "$SMPROGRAMS\Electric Sheep\Run in a window.lnk"
	Delete "$SMPROGRAMS\Electric Sheep\Website.lnk"
	Delete "$SMPROGRAMS\Electric Sheep\Uninstall.lnk"
	RMDir "$SMPROGRAMS\Electric Sheep"
	SetShellVarContext current
	
	DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
	DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
	DeleteRegKey HKLM SOFTWARE\ElectricSheep
	SetAutoClose true
SectionEnd

Function OptionDestopShortcut
	MessageBox MB_YESNO "Would you like a shortcut on the desktop to start ElectricSheep screensaver?" IDYES +2
	Return
	SetShellVarContext all
	CreateShortCut "$DESKTOP\Electric Sheep.lnk" "$INSTDIR\settingsgui.exe"
	SetShellVarContext current

FunctionEnd

Function OptionCurrentScreensaver
	MessageBox MB_YESNO "Would you like to make ElectricSheep your current screensaver?" IDYES +2
	Return
	WriteRegStr HKCU "Control Panel\Desktop" "ScreenSaveActive" 1

	call GetWindowsVersion
	Pop $R0
	StrCmp $R0 'Vista' lbl_vista

	StrCpy $R0 "$WINDIR\${PRODUCT_SCR_STRING}"
	StrCpy $R1 ${NSIS_MAX_STRLEN}

	System::Call 'KERNEL32.DLL::GetShortPathNameA(t, t, i) i(R0., .R0, R1) .R2'

	StrCmp $R2 "0" +2
	WriteRegStr HKCU "Control Panel\Desktop" "SCRNSAVE.EXE" "$R0"
	Return

	lbl_vista:
	WriteRegStr HKCU "Control Panel\Desktop" "SCRNSAVE.EXE" "$WINDIR\${PRODUCT_SCR_STRING}"

FunctionEnd

; GetWindowsVersion
;
; Based on Yazno's function, http://yazno.tripod.com/powerpimpit/
; Updated by Joost Verburg
;
; Returns on top of stack
;
; Windows Version (95, 98, ME, NT x.x, 2000, XP, 2003, Vista)
; or
; '' (Unknown Windows Version)
;
; Usage:
;   Call GetWindowsVersion
;   Pop $R0
;   ; at this point $R0 is "NT 4.0" or whatnot

Function GetWindowsVersion

  Push $R0
  Push $R1

  ClearErrors

  ReadRegStr $R0 HKLM \
  "SOFTWARE\Microsoft\Windows NT\CurrentVersion" CurrentVersion

  IfErrors 0 lbl_winnt

  ; we are not NT
  ReadRegStr $R0 HKLM \
  "SOFTWARE\Microsoft\Windows\CurrentVersion" VersionNumber

  StrCpy $R1 $R0 1
  StrCmp $R1 '4' 0 lbl_error

  StrCpy $R1 $R0 3

  StrCmp $R1 '4.0' lbl_win32_95
  StrCmp $R1 '4.9' lbl_win32_ME lbl_win32_98

  lbl_win32_95:
    StrCpy $R0 '95'
  Goto lbl_done

  lbl_win32_98:
    StrCpy $R0 '98'
  Goto lbl_done

  lbl_win32_ME:
    StrCpy $R0 'ME'
  Goto lbl_done

  lbl_winnt:

  StrCpy $R1 $R0 1

  StrCmp $R1 '3' lbl_winnt_x
  StrCmp $R1 '4' lbl_winnt_x

  StrCpy $R1 $R0 3

  StrCmp $R1 '5.0' lbl_winnt_2000
  StrCmp $R1 '5.1' lbl_winnt_XP
  StrCmp $R1 '5.2' lbl_winnt_2003
  StrCmp $R1 '6.0' lbl_winnt_vista
  StrCmp $R1 '6.1' lbl_winnt_vista lbl_error

  lbl_winnt_x:
    StrCpy $R0 "NT $R0" 6
  Goto lbl_done

  lbl_winnt_2000:
    Strcpy $R0 '2000'
  Goto lbl_done

  lbl_winnt_XP:
    Strcpy $R0 'XP'
  Goto lbl_done

  lbl_winnt_2003:
    Strcpy $R0 '2003'
  Goto lbl_done

  lbl_winnt_vista:
    Strcpy $R0 'Vista'
  Goto lbl_done

  lbl_error:
    Strcpy $R0 ''
  lbl_done:

  Pop $R1
  Exch $R0

FunctionEnd





