Function Update-PrinterEnvironment {
<#
.Synopsis
	Проверяет, создаёт / обновляет необходимое окружение для локальных очередей печати.
.Description
	Update-PrinterEnvironment проверяет и создаёт (при отсутствии) локальные группы безопасности
    для указанного принтера, изменяет права доступа к принтеру (предоставляет права печати на данном
    принтере только локальным группам Пользователи принтера и Администраторы принтера,
    предоставляет право управления всеми документами в очереди группе Администраторы принтера
    и локальной группе Администраторы).
    
    Далее, обеспечивает общий доступ к принтеру, публикует его в AD, обновляет для него окружение в AD,
    и включает доменные группы Пользователей и Администраторов этого принтера в его локальные группы.
.Notes
	Командлет разработан исключительно для работы с локальными очередями печати.
	Его не следует использовать для подключенных сетевых принтеров.
.Inputs
	System.Printing.PrintQueue
	Объект очереди печати.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	Объект очереди печати, возвращаемый Get-Printer.
.Outputs
	System.Printing.PrintQueue
	Исходный объект принтера при выполнении с ключом PassThru.
.Outputs
	Microsoft.Management.Infrastructure.CimInstance
	Исходный объект принтера при выполнении с ключом PassThru.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Update-PrinterEnvironment
.Link
	Get-Printer
.Link
	New-PrinterGroup
.Example
	Get-Printer 'P00001' | Update-PrinterEnvironment
	Создаём / обновляем окружение для локальной очереди печати 'P00001'.
.Example
	Get-Printer | Update-PrinterEnvironment
	Создаём / обновляем окружение для всех локальных принтеров.
#>
	[CmdletBinding(
		SupportsShouldProcess = $true
		, ConfirmImpact = 'Medium'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Update-PrinterEnvironment'
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
		# Передавать ли объект принтера далее по конвейеру
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
