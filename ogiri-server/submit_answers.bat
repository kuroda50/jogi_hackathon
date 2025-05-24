@echo off
echo 回答投稿スクリプト

:: テーマIDを入力してもらう
set /p themeID="お題のIDを入力してください: "

:: 回答1
echo.
echo 回答1を投稿中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes/%themeID%/answers -Method POST -ContentType 'application/json' -Body '{\"content\":\"「無人島から脱出する方法」という本\",\"created_by\":\"脱出王\"}'"

:: 回答2
echo.
echo 回答2を投稿中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes/%themeID%/answers -Method POST -ContentType 'application/json' -Body '{\"content\":\"毎日ピザを届けてくれるピザ屋の会員証\",\"created_by\":\"食いしん坊\"}'"

:: 回答3
echo.
echo 回答3を投稿中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes/%themeID%/answers -Method POST -ContentType 'application/json' -Body '{\"content\":\"Wifiルーターに見える岩\",\"created_by\":\"通信オタク\"}'"

:: 回答4
echo.
echo 回答4を投稿中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes/%themeID%/answers -Method POST -ContentType 'application/json' -Body '{\"content\":\"電源のない電子レンジ（日焼け防止用の箱として使える）\",\"created_by\":\"美肌マニア\"}'"

:: 全ての回答を表示
echo.
echo 全ての回答を取得中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes/%themeID%/answers -Method GET"

pause
