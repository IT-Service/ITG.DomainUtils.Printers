Function Get-PrintQueue {
<#
.Synopsis
	���������� ���� ��� ��������� ��������� �������� ������. 
.Description
	Get-PrintQueue ���������� ������ PrintQueue ��� ��������� ����� ��� ��������� ���������
	�������� PrintQueue �� ��������� ������� ������.
.Inputs
	System.Printing.PrintQueue
	������� ������.
.Inputs
	System.String
	��� (Name) ������� ������.
.Outputs
	System.Printing.PrintQueue
	���������� ���� ��� ��������� �������� "���������" PrintQueue.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrintQueue
.Link
	System.Printing.LocalPrintServer
.Example
	Get-PrintQueue -PrintQueueTypes Local
	���������� ��� **���������** ������� ������.
#>
	[CmdletBinding(
		DefaultParametersetName = 'Filter'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrintQueue'
	)]

	param (
		# ������������� ������� PrintQueue - ��� "��������"
		[Parameter(
			Mandatory = $true
			, Position = 1
			, ValueFromPipeline = $true
			, ValueFromPipelineByPropertyName = $true
			, ParameterSetName = 'Identity'
		)]
		[String]
		[Alias( 'Identity' )]
		$Name
	,
		# ���� ������������� �������� ������
		[Parameter(
			Mandatory = $false
		)]
		[Alias( 'Types' )]
		[System.Printing.EnumeratedPrintQueueTypes[]]
		$PrintQueueTypes = @(
			[System.Printing.EnumeratedPrintQueueTypes]::Local `
		)
	,
		# �������� ������� ������� printQueue, �������� ������� ���������� ���������
		[Parameter(
			Mandatory = $false
		)]
		[System.Printing.PrintQueueIndexedProperty[]]
		$Properties = @(
			[System.Printing.PrintQueueIndexedProperty]::Name `
			, [System.Printing.PrintQueueIndexedProperty]::Comment `
			, [System.Printing.PrintQueueIndexedProperty]::Description `
			, [System.Printing.PrintQueueIndexedProperty]::Location `
			, [System.Printing.PrintQueueIndexedProperty]::HostingPrintServer `
			, [System.Printing.PrintQueueIndexedProperty]::ShareName `
		)
	)

	begin {
		try {
			[System.Printing.LocalPrintServer] $PrintServer = New-Object -TypeName System.Printing.LocalPrintServer;
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
	process {
		try {
			switch ( $PsCmdlet.ParameterSetName ) {
				'Identity' {
					return `
						$PrintServer.GetPrintQueues( $Properties, $PrintQueueTypes ) `
						| ? { $_.Name -eq $Name } `
					;
				}
				'Filter' {
					return $PrintServer.GetPrintQueues( $Properties, $PrintQueueTypes );
				}
			};
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
}

New-Alias -Name Get-Printer -Value Get-PrintQueue -Force;

Function Test-PrintQueue {
<#
.Synopsis
	��������� ������� ����� ��� ���������� ��������� �������� ������. 
.Description
	Get-PrintQueue ���������� ������ PrintQueue ��� ��������� ����� ��� ��������� ���������
	�������� PrintQueue �� ��������� ������� ������.
.Inputs
	System.Printing.PrintQueue
	������� ������.
.Inputs
	System.String
	��� (Name) ������� ������.
.Outputs
	System.Bool
	������������ ������� ���� ���������� ��������� ������� ������ �� ��������� ������� ������.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueue
.Link
	System.Printing.LocalPrintServer
.Example
	Test-PrintQueue -Name 'P00001'
	��������� ������� �� ��������� ������� ������ ������� ������ � ������ P00001.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueue'
	)]

	param (
		# ������������� ������� PrintQueue - ��� "��������"
		[Parameter(
			Mandatory = $true
			, Position = 1
			, ValueFromPipeline = $true
			, ValueFromPipelineByPropertyName = $true
		)]
		[String]
		[Alias( 'Identity' )]
		$Name
	)

	process {
		try {
			return [bool] ( Get-PrintQueue `
				-Name $Name `
				-PrintQueueTypes Local, Connections `
				-Properties Name `
				-ErrorAction SilentlyContinue `
			);
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
}

New-Alias -Name Test-Printer -Value Test-PrintQueue -Force;

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
	Microsoft.ActiveDirectory.Management.ADGroup[]
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
<#
 $Computer = [ADSI]"WinNT://$Env:COMPUTERNAME,Computer"


$objOu = [ADSI]"WinNT://$computer"

$objUser = $objOU.Create("Group", $group)

$objUser.SetInfo()

$objUser.description = "Test Group"

$objUser.SetInfo()


					New-ADGroup `
						-Path ( $Config.PrintQueuesContainer ) `
						-Name ( [String]::Format( $Config."printQueue$( $SingleGroupType )Group", $InputObject.PrinterName ) ) `
						-SamAccountName ( [String]::Format(
							$Config."printQueue$( $SingleGroupType )GroupAccountName"
							, $InputObject.PrinterName
							, $InputObject.ServerName
							, $InputObject.Name
						) ) `
						-GroupCategory Security `
						-GroupScope DomainLocal `
						-Description ( [String]::Format(
							$loc."printQueue$( $SingleGroupType )GroupDescription"
							, $InputObject.PrinterName
							, $InputObject.ServerName
							, $InputObject.Name
							, $InputObject.PrintShareName
						) ) `
						-OtherAttributes @{
							info = ( [String]::Format(
								$loc."printQueue$( $SingleGroupType )GroupInfo"
								, $InputObject.PrinterName
								, $InputObject.ServerName
								, $InputObject.Name
								, $InputObject.PrintShareName
							) );
						} `
						@Params `
						-Verbose:$VerbosePreference `
						-PassThru:$PassThru `
					;
#>
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
