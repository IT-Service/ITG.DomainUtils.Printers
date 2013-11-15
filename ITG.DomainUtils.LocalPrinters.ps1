$null = [System.Reflection.Assembly]::Load('System.Printing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35');

Function Get-PrintQueue {
<#
.Synopsis
	Возвращает одну или несколько локальных очередей печати. 
.Description
	Get-PrintQueue возвращает объект PrintQueue или выполняет поиск для выявления множества
	объектов PrintQueue на локальном сервере печати.
.Notes
	При указании параметра `-Name` (в том числе - и путём передачи по конвейеру) могут быть
	возвращены **только локальные** принтеры.
.Inputs
	System.Printing.PrintQueue
	Очередь печати.
.Inputs
	System.String
	Имя (Name) очереди печати.
.Outputs
	System.Printing.PrintQueue
	Возвращает один или несколько объектов "принтеров" PrintQueue.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrintQueue
.Link
	System.Printing.LocalPrintServer
.Example
	Get-PrintQueue -PrintQueueTypes Local
	Возвращает все **локальные** очереди печати.
#>
	[CmdletBinding(
		DefaultParametersetName = 'Filter'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrintQueue'
	)]

	param (
		# идентификация объекта PrintQueue - имя "принтера"
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
		# типы запрашиваемых очередей печати
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
		# Перечень свойств объекта printQueue, значения которых необходимо запросить
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

