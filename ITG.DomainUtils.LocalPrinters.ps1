$null = [System.Reflection.Assembly]::Load('System.Printing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35');

Function Get-PrintQueue {
<#
.Synopsis
	���������� ���� ��� ��������� ��������� �������� ������. 
.Description
	Get-PrintQueue ���������� ������ PrintQueue ��� ��������� ����� ��� ��������� ���������
	�������� PrintQueue �� ��������� ������� ������.
.Notes
	��� �������� ��������� `-Name` (� ��� ����� - � ���� �������� �� ���������) ����� ����
	���������� **������ ���������** ��������.
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
			, ParameterSetName = 'Filter'
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
					return $PrintServer.GetPrintQueue( $Name, $Properties );
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

