git push origin :v2.9
git tag -d v2.9
git tag v2.9
git push origin master --tags 

IF "%1"=="nopause" GOTO No1
    pause
:No1 