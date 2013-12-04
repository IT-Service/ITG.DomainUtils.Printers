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
