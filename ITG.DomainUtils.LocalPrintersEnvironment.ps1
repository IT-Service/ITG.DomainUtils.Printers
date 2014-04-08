Function Update-PrinterEnvironment {
<#
.Synopsis
	���������, ������ / ��������� ����������� ��������� ��� ��������� �������� ������.
.Description
	Update-PrinterEnvironment ��������� � ������ (��� ����������) ��������� ������ ������������
    ��� ���������� ��������, �������� ����� ������� � �������� (������������� ����� ������ �� ������
    �������� ������ ��������� ������� ������������ �������� � �������������� ��������,
    ������������� ����� ���������� ����� ����������� � ������� ������ �������������� ��������
    � ��������� ������ ��������������).
    
    �����, ������������ ����� ������ � ��������, ��������� ��� � AD, ��������� ��� ���� ��������� � AD,
    � �������� �������� ������ ������������� � ��������������� ����� �������� � ��� ��������� ������.
.Notes
	��������� ���������� ������������� ��� ������ � ���������� ��������� ������.
	��� �� ������� ������������ ��� ������������ ������� ���������.
.Inputs
	System.Printing.PrintQueue
	������ ������� ������.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	������ ������� ������, ������������ Get-Printer.
.Outputs
	System.Printing.PrintQueue
	�������� ������ �������� ��� ���������� � ������ PassThru.
.Outputs
	Microsoft.Management.Infrastructure.CimInstance
	�������� ������ �������� ��� ���������� � ������ PassThru.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Update-PrinterEnvironment
.Link
	Get-Printer
.Link
	New-PrinterGroup
.Example
	Get-Printer 'P00001' | Update-PrinterEnvironment
	������ / ��������� ��������� ��� ��������� ������� ������ 'P00001'.
.Example
	Get-Printer | Update-PrinterEnvironment
	������ / ��������� ��������� ��� ���� ��������� ���������.
#>
	[CmdletBinding(
		SupportsShouldProcess = $true
		, ConfirmImpact = 'Medium'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Update-PrinterEnvironment'
	)]

	param (
		# ��� ��������� ������� ������
		[Parameter(
			Mandatory = $true
			, Position = 0
			, ValueFromPipelineByPropertyName = $true
		)]
		[String]
		$Name
	,
		# ���������� �� ������ �������� ����� �� ���������
		[Switch]
		$PassThru
	)

	process {
		try {
			$Config = Get-DomainUtilsPrintersConfiguration;
			foreach ( $SingleGroupType in $GroupType ) {
				try {
					New-Group `
						-Name ( [String]::Format( $Config."printQueue$( $SingleGroupType )Group", $Name ) ) `
						-Description ( [String]::Format(
							$loc."printQueue$( $SingleGroupType )GroupDescription"
							, $InputObject.Name
							, $InputObject.ShareName
						) ) `
						-WhatIf:$WhatIfPreference `
						-Verbose:$VerbosePreference `
						-PassThru:$PassThru `
					;
				} catch {
					Write-Error `
						-ErrorRecord $_ `
					;
				};
			};
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
}

New-Alias -Name Update-PrintQueueEnvironment -Value Update-PrinterEnvironment -Force;
