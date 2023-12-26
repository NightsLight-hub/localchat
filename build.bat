@echo off

echo ====== build server ======
call fvm flutter build windows --release

echo ====== build web ======
call fvm flutter build web  --base-href /front/ --release -t lib/web/web_main.dart --web-renderer html

echo ====== copy web static resource ======
rd /s/q build\windows\x64\runner\Release\build\
md build\windows\x64\runner\Release\build\web
xcopy build\web\*.* build\windows\x64\runner\Release\build\web /e /y /h /r /q
xcopy cpplibs\*.* build\windows\x64\runner\Release /e /y /h /r /q
echo release dir is %cd%\build\windows\x64\runner\Release
pause