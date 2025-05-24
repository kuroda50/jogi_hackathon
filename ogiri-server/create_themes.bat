@echo off
echo お題作成スクリプト

:: 最初のお題
echo.
echo お題1を作成中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes -Method POST -ContentType 'application/json' -Body '{\"title\":\"無人島に持っていくと意外と役立つもの\",\"description\":\"無人島に一つだけ持っていくならこれ！ただし普通じゃないものを考えてください\",\"created_by\":\"お題マスター\"}'"

:: 二つ目のお題
echo.
echo お題2を作成中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes -Method POST -ContentType 'application/json' -Body '{\"title\":\"ドラえもんの実はあんまり役に立たない道具\",\"description\":\"ドラえもんの道具で実はあまり使えないものとその理由\",\"created_by\":\"どらファン\"}'"

:: 三つ目のお題
echo.
echo お題3を作成中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes -Method POST -ContentType 'application/json' -Body '{\"title\":\"猫と和解する方法\",\"description\":\"怒っている猫と仲直りするユニークな方法を考えてください\",\"created_by\":\"猫マスター\"}'"

:: 四つ目のお題
echo.
echo お題4を作成中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes -Method POST -ContentType 'application/json' -Body '{\"title\":\"50年後の新しい習慣\",\"description\":\"50年後の日常生活で当たり前になっている驚きの習慣は？\",\"created_by\":\"未来人\"}'"

:: 五つ目のお題
echo.
echo お題5を作成中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes -Method POST -ContentType 'application/json' -Body '{\"title\":\"世界一微妙なスーパーパワー\",\"description\":\"ほとんど役に立たないけど、一応スーパーパワーと呼べる能力\",\"created_by\":\"ヒーロー協会\"}'"

:: 全てのお題を表示
echo.
echo 全てのお題を取得中...
powershell -Command "Invoke-WebRequest -Uri http://localhost:8080/api/themes -Method GET"

pause
