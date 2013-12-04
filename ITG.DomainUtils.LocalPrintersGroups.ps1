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
	ADObject ������ printQueue, ������������ Get-PrintQueue.
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
		# ������ ������� ������
		[Parameter(
			Mandatory = $true
			, Position = 0
			, ValueFromPipeline = $true
		)]
		[System.Printing.PrintQueue]
		[Alias( 'PrintQueue' )]
		[Alias( 'Printer' )]
		$InputObject
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
						-Name ( [String]::Format( $Config."printQueue$( $SingleGroupType )Group", $InputObject.Name ) ) `
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
	������ ������� ������, ������������ Get-PrintQueue.
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
		# ������ ������� ������
		[Parameter(
			Mandatory = $true
			, Position = 0
			, ValueFromPipeline = $true
		)]
		[System.Printing.PrintQueue]
		[Alias( 'PrintQueue' )]
		[Alias( 'Printer' )]
		$InputObject
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
						-Name ( [String]::Format( $Config."printQueue$( $SingleGroupType )Group", $InputObject.Name ) ) `
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
