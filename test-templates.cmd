set WORKDIR=C:\tmp\tpl-classlib
rmdir /s /q %WORKDIR%
mkdir %WORKDIR%

set TPLDIR="%~dp0src\templates"

dotnet new -u %TPLDIR%
dotnet new -i %TPLDIR%

call :test_template LibAll "--namespace-prefix=Alphacloud.Common. -repo=UberTemplate"
call :test_template test_template LibBasic ""

goto :eof

:test_template
cd C:\tmp\tpl-classlib
C:

mkdir %1
cd %1

echo Testing %1 (%2)

dotnet new ac-github-classlib --force --no-restore --coveralls-key=COVERALLSKEY --github-key=GITHUBKEY --nuget-key=NUGETKEY %~2
cd src

dotnet restore -v q
dotnet build -v q --no-restore
dotnet test --no-build
exit /b

