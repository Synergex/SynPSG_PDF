@echo off
pushd %~dp0

if not "%SYNERGYDE32%" == "" (
  echo Deploying 32-bit libHaru files...
  copy /Y ".\X86\libhpdf.dll"  "%SYNERGYDE32%dbl\bin"
  copy /Y ".\X86\libpng15.dll" "%SYNERGYDE32%dbl\bin"
  copy /Y ".\X86\zlibwapi.dll" "%SYNERGYDE32%dbl\bin"
) else (
  echo NO 32-bit Synergy installation was detected.
)

if not "%SYNERGYDE64%" == "" (
  echo Deploying 64-bit libHaru files...
  copy /Y ".\X64\libhpdf64.dll"   "%SYNERGYDE64%dbl\bin"
  copy /Y ".\X64\libpng15_64.dll" "%SYNERGYDE64%dbl\bin"
  copy /Y ".\X64\zlibwapi64.dll"  "%SYNERGYDE64%dbl\bin"
) else (
  echo NO 64-bit Synergy installation was detected.
)

popd
