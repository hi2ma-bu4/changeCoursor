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

# �J�[�\���̃e�[�}�ύX
if ($okFlag) {
    # ���[�U�[�ݒ�
    $basePath = $basePath + $DirName.Trim("`"") + "\"

    $RegCursors.SetValue("", $ThemeName.Trim("`""))
    SetCursors "Arrow" "$($basePath)01_�ʏ�"
    SetCursors "Help" "$($basePath)02_�w���v�̑I��"
    SetCursors "AppStarting" "$($basePath)03_�o�b�N�O���E���h��ƒ�"
    SetCursors "Wait" "$($basePath)04_�҂����"
    SetCursors "Crosshair" "$($basePath)05_�̈�I��"
    SetCursors "IBeam" "$($basePath)06_�e�L�X�g�I��"
    SetCursors "NWPen" "$($basePath)07_�菑��"
    SetCursors "No" "$($basePath)08_���p�s��"
    SetCursors "SizeNS" "$($basePath)09_�㉺�Ɋg��E�k��"
    SetCursors "SizeWE" "$($basePath)10_���E�Ɋg��E�k��"
    SetCursors "SizeNWSE" "$($basePath)11_�΂߂Ɋg��E�k��1"
    SetCursors "SizeNESW" "$($basePath)12_�΂߂Ɋg��E�k��2"
    SetCursors "SizeAll" "$($basePath)13_�ړ�"
    SetCursors "UpArrow" "$($basePath)14_��֑I��"
    SetCursors "Hand" "$($basePath)15_�����N�I��"
    SetCursors "Pin" "$($basePath)16_�ꏊ�̑I��"
    SetCursors "Person" "$($basePath)17_�l�̑I��"

}
else {
    # �����ݒ�
    $RegCursors.SetValue("", "Windows �W��")
    $RegCursors.SetValue("Arrow", $basePath + "aero_arrow.cur") # �ʏ�
    $RegCursors.SetValue("Help", $basePath + "aero_helpsel.cur") # �w���v�̑I��
    $RegCursors.SetValue("AppStarting", $basePath + "aero_working.ani") # �o�b�N�O���E���h��ƒ�
    $RegCursors.SetValue("Wait", $basePath + "aero_busy.ani") # �҂����
    $RegCursors.SetValue("Crosshair", $basePath + "lcross.cur") # �̈�I��
    $RegCursors.SetValue("IBeam", $basePath + "libeam.cur") # �e�L�X�g�I��
    $RegCursors.SetValue("NWPen", $basePath + "aero_pen.cur") # �菑��
    $RegCursors.SetValue("No", $basePath + "aero_unavail.cur") # ���p�s��
    $RegCursors.SetValue("SizeNS", $basePath + "aero_ns.cur") # �㉺�Ɋg��E�k��
    $RegCursors.SetValue("SizeWE", $basePath + "aero_ew.cur") # ���E�Ɋg��E�k��
    $RegCursors.SetValue("SizeNWSE", $basePath + "aero_nwse.cur") # �΂߂Ɋg��E�k��1
    $RegCursors.SetValue("SizeNESW", $basePath + "aero_nesw.cur") # �΂߂Ɋg��E�k��2
    $RegCursors.SetValue("SizeAll", $basePath + "aero_move.cur") # �ړ�
    $RegCursors.SetValue("UpArrow", $basePath + "aero_up") # ��֑I��
    $RegCursors.SetValue("Hand", $basePath + "aero_link.cur") # �����N�I��
    $RegCursors.SetValue("Pin", $basePath + "aero_pin.cur") # �ꏊ�̑I��
    $RegCursors.SetValue("Person", $basePath + "aero_person.cur") # �l�̑I��
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

