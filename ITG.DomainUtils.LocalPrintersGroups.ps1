Function New-PrintQueueGroup {
<#
.Synopsis
	������ ��������� ������ ������������ ��� ���������� ������� printQueue. 
.Description
	New-PrintQueueGroup ������ ������ ������������
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
	https://github.com/IT-Service/ITG.DomainUtils.Printers#New-PrintQueueGroup
.Link
	Get-PrintQueue
.Example
	Get-PrintQueue 'P00001' | New-PrintQueueGroup
	������ ������ ������������ ��� ������� ������ 'p00001' �� ��������� ������� ������.
.Example
	Get-PrintQueue | New-PrintQueueGroup -GroupType Users
	������ ��������� ������ ������������ "������������ ��������" ��� ���� ������������
	��������� ���������.
#>
	[CmdletBinding(
		SupportsShouldProcess = $true
		, ConfirmImpact = 'Medium'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#New-PrintQueueGroup'
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

New-Alias -Name New-PrinterGroup -Value New-PrintQueueGroup -Force;

Function Get-PrintQueueGroup {
<#
.Synopsis
	���������� ������������� ������ ������������ ��� ��������� ��������� ������� ������. 
.Description
	Get-PrintQueueGroup ���������� ������ ������������
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
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrintQueueGroup
.Link
	Get-PrintQueue
.Example
	Get-PrintQueue -Name 'P00001' | Get-PrintQueueGroup -GroupType Users
	���������� ������ ������������ ������������ �������� ��� ������� ������ 'P00001'.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrintQueueGroup'
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

New-Alias -Name Get-PrinterGroup -Value Get-PrintQueueGroup -Force;

Function Test-PrintQueueGroup {
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
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueueGroup
.Example
	Get-Printer 'P00001' | Test-PrinterGroup -GroupType Users
	��������� ������� ������ ������������ ������������ �������� ��� ������� ������ 'P00001'.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueueGroup'
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

New-Alias -Name Test-PrinterGroup -Value Test-PrintQueueGroup -Force;
