Param(
    [String]$DirName,
    [string]$ThemeName
)

$RegConnect = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]"CurrentUser", "$env:COMPUTERNAME")
$RegCursors = $RegConnect.OpenSubKey("Control Panel\Cursors", $true)

$basePath = "%SystemRoot%\Cursors\"

function SystemRootReplace([string]$filePath) {
    return $filePath.Replace("%SystemRoot%", $env:SystemRoot)
}

$okFlag = $false
if (!([string]::IsNullorEmpty($DirName)) -And !([string]::IsNullorEmpty($ThemeName))) {
    $tmp = SystemRootReplace ($basePath + $DirName.Trim("`""))
    if (Test-Path $tmp) {
        $okFlag = $true
    }
}

function SetCursors([string]$KeyName, [string]$filePath) {
    $tmp = SystemRootReplace "$($filePath).ani"
    if (Test-Path $tmp) {
        $filePath = "$($filePath).ani"
    }
    else {
        $tmp = SystemRootReplace "$($filePath).cur"
        if (Test-Path $tmp) {
            $filePath = "$($filePath).cur"
        }
    }

    Write-Output "SetCursors: $filePath"
    $RegCursors.SetValue($KeyName, $filePath)
}

# カーソルのテーマ変更
if ($okFlag) {
    # ユーザー設定
    $basePath = $basePath + $DirName.Trim("`"") + "\"

    $RegCursors.SetValue("", $ThemeName.Trim("`""))
    SetCursors "Arrow" "$($basePath)01_通常"
    SetCursors "Help" "$($basePath)02_ヘルプの選択"
    SetCursors "AppStarting" "$($basePath)03_バックグラウンド作業中"
    SetCursors "Wait" "$($basePath)04_待ち状態"
    SetCursors "Crosshair" "$($basePath)05_領域選択"
    SetCursors "IBeam" "$($basePath)06_テキスト選択"
    SetCursors "NWPen" "$($basePath)07_手書き"
    SetCursors "No" "$($basePath)08_利用不可"
    SetCursors "SizeNS" "$($basePath)09_上下に拡大・縮小"
    SetCursors "SizeWE" "$($basePath)10_左右に拡大・縮小"
    SetCursors "SizeNWSE" "$($basePath)11_斜めに拡大・縮小1"
    SetCursors "SizeNESW" "$($basePath)12_斜めに拡大・縮小2"
    SetCursors "SizeAll" "$($basePath)13_移動"
    SetCursors "UpArrow" "$($basePath)14_代替選択"
    SetCursors "Hand" "$($basePath)15_リンク選択"
    SetCursors "Pin" "$($basePath)16_場所の選択"
    SetCursors "Person" "$($basePath)17_人の選択"

}
else {
    # 初期設定
    $RegCursors.SetValue("", "Windows 標準")
    $RegCursors.SetValue("Arrow", $basePath + "aero_arrow.cur") # 通常
    $RegCursors.SetValue("Help", $basePath + "aero_helpsel.cur") # ヘルプの選択
    $RegCursors.SetValue("AppStarting", $basePath + "aero_working.ani") # バックグラウンド作業中
    $RegCursors.SetValue("Wait", $basePath + "aero_busy.ani") # 待ち状態
    $RegCursors.SetValue("Crosshair", $basePath + "lcross.cur") # 領域選択
    $RegCursors.SetValue("IBeam", $basePath + "libeam.cur") # テキスト選択
    $RegCursors.SetValue("NWPen", $basePath + "aero_pen.cur") # 手書き
    $RegCursors.SetValue("No", $basePath + "aero_unavail.cur") # 利用不可
    $RegCursors.SetValue("SizeNS", $basePath + "aero_ns.cur") # 上下に拡大・縮小
    $RegCursors.SetValue("SizeWE", $basePath + "aero_ew.cur") # 左右に拡大・縮小
    $RegCursors.SetValue("SizeNWSE", $basePath + "aero_nwse.cur") # 斜めに拡大・縮小1
    $RegCursors.SetValue("SizeNESW", $basePath + "aero_nesw.cur") # 斜めに拡大・縮小2
    $RegCursors.SetValue("SizeAll", $basePath + "aero_move.cur") # 移動
    $RegCursors.SetValue("UpArrow", $basePath + "aero_up") # 代替選択
    $RegCursors.SetValue("Hand", $basePath + "aero_link.cur") # リンク選択
    $RegCursors.SetValue("Pin", $basePath + "aero_pin.cur") # 場所の選択
    $RegCursors.SetValue("Person", $basePath + "aero_person.cur") # 人の選択
}
$RegCursors.Close()
$RegConnect.Close()

function Update-UserPreferencesMask {
    $Signature = @"
[DllImport("user32.dll", EntryPoint = "SystemParametersInfo")]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, uint pvParam, uint fWinIni);

const int SPI_SETCURSORS = 0x0057;
const int SPIF_UPDATEINIFILE = 0x01;
const int SPIF_SENDCHANGE = 0x02;

public static void UpdateUserPreferencesMask() {
    SystemParametersInfo(SPI_SETCURSORS, 0, 0, SPIF_UPDATEINIFILE | SPIF_SENDCHANGE);
    }
"@
    Add-Type -MemberDefinition $Signature -Name UserPreferencesMaskSPI -Namespace User32
    [User32.UserPreferencesMaskSPI]::UpdateUserPreferencesMask()
}
Update-UserPreferencesMask

