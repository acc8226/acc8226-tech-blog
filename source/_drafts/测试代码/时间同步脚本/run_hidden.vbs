Set ws = CreateObject("WScript.Shell")

' 检查是否已经提升权限（避免无限循环）
If WScript.Arguments.Count = 0 Then
    ' 没有参数，请求管理员权限
    Set objShell = CreateObject("Shell.Application")
    objShell.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ uac", "", "runas", 0
    WScript.Quit
End If

' 已经有参数（已提权），运行批处理（隐藏窗口）
ws.Run "C:\Users\kai\Desktop\时间同步.cmd hide", 0
Set ws = Nothing