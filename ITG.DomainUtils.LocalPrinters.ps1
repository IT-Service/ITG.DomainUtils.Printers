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

Function New-PrintQueueGroup {
<#
.Synopsis
	Создаёт локальные группы безопасности для указанного объекта printQueue. 
.Description
	New-PrintQueueGroup создаёт группы безопасности
	(Пользователи принтера, Операторы принтера) для указанного
	через InputObject объекта printQueue на локальном сервере печати.
.Notes
	Командлет разработан исключительно для работы с локальными очередями печати.
	Следует избегать использовать его для подключенных сетевых принтеров.
.Inputs
	System.Printing.PrintQueue
	ADObject класса printQueue, возвращаемый Get-PrintQueue.
.Outputs
	Microsoft.ActiveDirectory.Management.ADGroup[]
	Возвращает созданные группы безопасности при выполнении с ключом PassThru.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#New-PrintQueueGroup
.Link
	Get-PrintQueue
.Example
	Get-PrintQueue 'P00001' | New-PrintQueueGroup
	Создаёт группы безопасности для очереди печати 'p00001' на локальном сервере печати.
.Example
	Get-PrintQueue | New-PrintQueueGroup -GroupType Users
	Создаёт локальные группы безопасности "Пользователи принтера" для всех обнаруженных
	локальных принтеров.
#>
	[CmdletBinding(
		SupportsShouldProcess = $true
		, ConfirmImpact = 'Medium'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#New-PrintQueueGroup'
	)]

	param (
		# Объект очереди печати
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
		# тип группы: Users (группа пользователей), Administrators (группа администраторов).
		# Группа пользователей получит только права печати и управления собственными документами.
		# Группа администраторов получит и право печати, и права на управление всеми документами в очереди.
		[Parameter(
			Mandatory = $false
		)]
		[String[]]
		[ValidateSet( 'Users', 'Administrators' )]
		$GroupType = ( 'Users', 'Administrators' )
	,
		# Передавать ли созданные группы далее по конвейеру
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
