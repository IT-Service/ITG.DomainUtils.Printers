Function New-PrinterGroup {
<#
.Synopsis
	������ ��������� ������ ������������ ��� ���������� ������� printQueue. 
.Description
	New-PrinterGroup ������ ������ ������������
	(������������ ��������, ��������� ��������) ��� ����������
	����� InputObject ������� printQueue �� ��������� ������� ������.
.Notes
	��������� ���������� ������������� ��� ������ � ���������� ��������� ������.
	������� �������� ������������ ��� ��� ������������ ������� ���������.
.Inputs
	System.Printing.PrintQueue
	������ ������� ������.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	������ ������� ������, ������������ Get-Printer.
.Outputs
	System.DirectoryServices.AccountManagement.GroupPrincipal
	���������� ��������� ������ ������������ ��� ���������� � ������ PassThru.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#New-PrinterGroup
.Link
	Get-Printer
.Example
	Get-Printer 'P00001' | New-PrinterGroup
	������ ������ ������������ ��� ������� ������ 'p00001' �� ��������� ������� ������.
.Example
	Get-Printer | New-PrinterGroup -GroupType Users
	������ ��������� ������ ������������ "������������ ��������" ��� ���� ������������
	��������� ���������.
#>
	[CmdletBinding(
		SupportsShouldProcess = $true
		, ConfirmImpact = 'Medium'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#New-PrinterGroup'
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
		# ��� ������: Users (������ �������������), Administrators (������ ���������������).
		# ������ ������������� ������� ������ ����� ������ � ���������� ������������ �����������.
		# ������ ��������������� ������� � ����� ������, � ����� �� ���������� ����� ����������� � �������.
		[Parameter(
			Mandatory = $false
		)]
		[String[]]
		[ValidateSet( 'Users', 'Administrators' )]
		$GroupType = ( 'Users', 'Administrators' )
	,
		# ���������� �� ��������� ������ ����� �� ���������
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

New-Alias -Name New-PrintQueueGroup -Value New-PrinterGroup -Force;

Function Get-PrinterGroup {
<#
.Synopsis
	���������� ������������� ������ ������������ ��� ��������� ��������� ������� ������. 
.Description
	Get-PrinterGroup ���������� ������ ������������
	(������������ ��������, ��������� ��������) ��� ����������
	(�� ���������) ������� ��������� ������� ������.
.Inputs
	System.Printing.PrintQueue
	������ ������� ������.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	������ ������� ������, ������������ Get-Printer.
.Outputs
	System.DirectoryServices.AccountManagement.GroupPrincipal
	���������� ������������� ������ ������������.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrinterGroup
.Link
	Get-Printer
.Example
	Get-Printer -Name 'P00001' | Get-PrinterGroup -GroupType Users
	���������� ������ ������������ ������������ �������� ��� ������� ������ 'P00001'.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrinterGroup'
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
		# ��� ������: Users (������ �������������), Administrators (������ ���������������).
		# ������ ������������� ������� ����� ���������� ��������� �������� ��� ���� ������� ������, � ����� ������.
		# ������ ��������������� �� ������� ����� ���������� GPO, �� ������� ����� ������ � ����� ���������� ����� �����������
		# � ��������� ������� ������.
		[Parameter(
			Mandatory = $false
		)]
		[String[]]
		[ValidateSet( 'Users', 'Administrators' )]
		$GroupType = 'Users'
	)

	process {
		try {
			$Config = Get-DomainUtilsPrintersConfiguration;
			foreach ( $SingleGroupType in $GroupType ) {
				try {
					Get-Group `
						-Name ( [String]::Format( $Config."printQueue$( $SingleGroupType )Group", $Name ) ) `
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

New-Alias -Name Get-PrintQueueGroup -Value Get-PrinterGroup -Force;

Function Test-PrinterGroup {
<#
.Synopsis
	��������� ������� ������������� ����� ������������ ��� ��������� ��������� ������� ������. 
.Inputs
	System.Printing.PrintQueue
	������ ������� ������.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	������ ������� ������, ������������ Get-Printer.
.Outputs
	System.Bool
	`$true` ���� ������ ����������, `$false` - ���� �� ����������.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrinterGroup
.Example
	Get-Printer 'P00001' | Test-PrinterGroup -GroupType Users
	��������� ������� ������ ������������ ������������ �������� ��� ������� ������ 'P00001'.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrinterGroup'
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
		# ��� ������: Users (������ �������������), Administrators (������ ���������������).
		[Parameter(
			Mandatory = $false
		)]
		[String[]]
		[ValidateSet( 'Users', 'Administrators' )]
		$GroupType = 'Users'
	)

	process {
		try {
			$Config = Get-DomainUtilsPrintersConfiguration;
			foreach ( $SingleGroupType in $GroupType ) {
				try {
					Test-Group `
						-Name ( [String]::Format( $Config."printQueue$( $SingleGroupType )Group", $Name ) ) `
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

New-Alias -Name Test-PrintQueueGroup -Value Test-PrinterGroup -Force;
