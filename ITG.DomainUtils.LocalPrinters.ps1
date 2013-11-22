Function Get-PrintQueue {
<#
.Synopsis
	Возвращает одну или несколько локальных очередей печати. 
.Description
	Get-PrintQueue возвращает объект PrintQueue или выполняет поиск для выявления множества
	объектов PrintQueue на локальном сервере печати.
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
	Проверяет наличие одной или нескольких локальных очередей печати. 
.Description
	Get-PrintQueue возвращает объект PrintQueue или выполняет поиск для выявления множества
	объектов PrintQueue на локальном сервере печати.
.Inputs
	System.Printing.PrintQueue
	Очередь печати.
.Inputs
	System.String
	Имя (Name) очереди печати.
.Outputs
	System.Bool
	Подтверждает наличие либо отсутствие указанной очереди печати на локальном сервере печати.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueue
.Link
	System.Printing.LocalPrintServer
.Example
	Test-PrintQueue -Name 'P00001'
	Проверяет наличие на локальном сервере печати очереди печати с именем P00001.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueue'
	)]

	param (
		# идентификация объекта PrintQueue - имя "принтера"
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

