#/bin/sh

set -e -o pipefail

function test_template() {
  cd $SAVEDIR
  mkdir $1
  cd $1
  echo -e "\033[97m******************\nTesting $1 ($2) ..\n******************\033[39m"
  dotnet new ac-github-classlib --force --no-restore --coveralls-key=COVERALLSKEY --github-key=GITHUBKEY --nuget-key=NUGETKEY $2
  cd src
  dotnet restore -v q
  dotnet build -v q --no-restore
  dotnet test --no-build
  dotnet pack -c Release
}

rm -Rf ./temp
mkdir ./temp
cd ./temp
SAVEDIR=$(pwd)

dotnet new -i ../src/templates

test_template LibAll "--namespace-prefix=Alphacloud.Common. -repo=UberTemplate"
test_template LibBasic ""

