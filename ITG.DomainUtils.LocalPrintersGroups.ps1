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
	Объект очереди печати.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	Объект очереди печати, возвращаемый Get-Printer.
.Outputs
	System.DirectoryServices.AccountManagement.GroupPrincipal
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
		# Имя локальной очереди печати
		[Parameter(
			Mandatory = $true
			, Position = 0
			, ValueFromPipelineByPropertyName = $true
		)]
		[String]
		$Name
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
	Возвращает затребованные группы безопасности для указанной локальной очереди печати. 
.Description
	Get-PrintQueueGroup возвращает группы безопасности
	(Пользователи принтера, Операторы принтера) для указанного
	(по конвейеру) объекта локальной очереди печати.
.Inputs
	System.Printing.PrintQueue
	Объект очереди печати.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	Объект очереди печати, возвращаемый Get-Printer.
.Outputs
	System.DirectoryServices.AccountManagement.GroupPrincipal
	Возвращает затребованные группы безопасности.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrintQueueGroup
.Link
	Get-PrintQueue
.Example
	Get-PrintQueue -Name 'P00001' | Get-PrintQueueGroup -GroupType Users
	Возвращает группу безопасности Пользователи принтера для очереди печати 'P00001'.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrintQueueGroup'
	)]

	param (
		# Имя локальной очереди печати
		[Parameter(
			Mandatory = $true
			, Position = 0
			, ValueFromPipelineByPropertyName = $true
		)]
		[String]
		$Name
	,
		# тип группы: Users (группа пользователей), Administrators (группа администраторов).
		# Группа пользователей получит право применения групповой политики для этой очереди печати, и право печати.
		# Группа администраторов не получит право применения GPO, но получит право печати и право управления всеми документами
		# в указанной очереди печати.
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
	Проверяет наличие затребованных групп безопасности для указанной локальной очереди печати. 
.Inputs
	System.Printing.PrintQueue
	Объект очереди печати.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	Объект очереди печати, возвращаемый Get-Printer.
.Outputs
	System.Bool
	`$true` если группа существует, `$false` - если не существует.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueueGroup
.Example
	Get-Printer 'P00001' | Test-PrinterGroup -GroupType Users
	Проверяем наличие группы безопасности Пользователи принтера для очереди печати 'P00001'.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueueGroup'
	)]

	param (
		# Имя локальной очереди печати
		[Parameter(
			Mandatory = $true
			, Position = 0
			, ValueFromPipelineByPropertyName = $true
		)]
		[String]
		$Name
	,
		# тип группы: Users (группа пользователей), Administrators (группа администраторов).
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
