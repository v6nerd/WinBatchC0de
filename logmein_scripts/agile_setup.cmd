@echo off
mode con:cols=75 lines=20
REM ==============================================================
REM Description:AgileC0nnect SETUP Utility
REM	
REM Type: BatchScript
REM
REM Version: 2.5 - Added Fix "for Additional info is needed"
REM
REM Author: Mohammed Habib - mhabib1981@hp.com
REM ==============================================================
echo.
echo.
echo **************************************************
echo :     P^&G WiFi Connection SETUP Utility v2       :
echo :   ------------------------------------------   :
echo :   This Tool will configure AgileC0nnect WiFi   :
echo :    on your PC ^& overwrite existing setting     :
echo **************************************************
echo.
:config_create
(
echo ^<?xml version="1.0"?^>
echo ^<WLANProfile xmlns="http://www.microsoft.com/networking/WLAN/profile/v1"^>
echo 	^<name^>AgileC0nnect^</name^>
echo 	^<SSIDConfig^>
echo 		^<SSID^>
echo 			^<hex^>4167696C6543306E6E656374^</hex^>
echo 			^<name^>AgileC0nnect^</name^>
echo 		^</SSID^>
echo 		^<nonBroadcast^>true^</nonBroadcast^>
echo 	^</SSIDConfig^>
echo 	^<connectionType^>ESS^</connectionType^>
echo 	^<connectionMode^>auto^</connectionMode^>
echo 	^<autoSwitch^>false^</autoSwitch^>
echo 	^<MSM^>
echo 		^<security^>
echo 			^<authEncryption^>
echo 				^<authentication^>WPA^</authentication^>
echo 				^<encryption^>TKIP^</encryption^>
echo 				^<useOneX^>true^</useOneX^>
echo 			^</authEncryption^>
echo 			^<OneX xmlns="http://www.microsoft.com/networking/OneX/v1"^>
echo 				^<cacheUserData^>false^</cacheUserData^>
echo 				^<authMode^>machineOrUser^</authMode^>
echo 				^<EAPConfig^>^<EapHostConfig xmlns="http://www.microsoft.com/provisioning/EapHostConfig"^>^<EapMethod^>^<Type xmlns="http://www.microsoft.com/provisioning/EapCommon"^>25^</Type^>^<VendorId xmlns="http://www.microsoft.com/provisioning/EapCommon"^>0^</VendorId^>^<VendorType xmlns="http://www.microsoft.com/provisioning/EapCommon"^>0^</VendorType^>^<AuthorId xmlns="http://www.microsoft.com/provisioning/EapCommon"^>0^</AuthorId^>^</EapMethod^>^<Config xmlns="http://www.microsoft.com/provisioning/EapHostConfig"^>^<Eap xmlns="http://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"^>^<Type^>25^</Type^>^<EapType xmlns="http://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV1"^>^<ServerValidation^>^<DisableUserPromptForServerValidation^>false^</DisableUserPromptForServerValidation^>^<ServerNames^>^^.*\.pg\.com$^</ServerNames^>^<TrustedRootCA^>99 a6 9b e6 1a fe 88 6b 4d 2b 82 00 7c b8 54 fc 31 7e 15 39 ^</TrustedRootCA^>^<TrustedRootCA^>4e b6 d5 78 49 9b 1c cf 5f 58 1e ad 56 be 3d 9b 67 44 a5 e5 ^</TrustedRootCA^>^<TrustedRootCA^>85 37 1c a6 e5 50 14 3d ce 28 03 47 1b de 3a 09 e8 f8 77 0f ^</TrustedRootCA^>^</ServerValidation^>^<FastReconnect^>true^</FastReconnect^>^<InnerEapOptional^>false^</InnerEapOptional^>^<Eap xmlns="http://www.microsoft.com/provisioning/BaseEapConnectionPropertiesV1"^>^<Type^>26^</Type^>^<EapType xmlns="http://www.microsoft.com/provisioning/MsChapV2ConnectionPropertiesV1"^>^<UseWinLogonCredentials^>true^</UseWinLogonCredentials^>^</EapType^>^</Eap^>^<EnableQuarantineChecks^>false^</EnableQuarantineChecks^>^<RequireCryptoBinding^>false^</RequireCryptoBinding^>^<PeapExtensions^>^<PerformServerValidation xmlns="http://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2"^>true^</PerformServerValidation^>^<AcceptServerName xmlns="http://www.microsoft.com/provisioning/MsPeapConnectionPropertiesV2"^>true^</AcceptServerName^>^</PeapExtensions^>^</EapType^>^</Eap^>^</Config^>^</EapHostConfig^>^</EAPConfig^>
echo 			^</OneX^>
echo 		^</security^>
echo 	^</MSM^>
echo ^</WLANProfile^>
) > AgileC0nnect.xml

:proceed 
netsh wlan add profile AgileC0nnect.xml
del /Q agile_setup.bat & del /Q AgileC0nnect.xml
exit /b