Function Test-Printer {
<#
.Synopsis
	Проверяет наличие одной или нескольких локальных очередей печати. 
.Inputs
	System.Printing.PrintQueue
	Очередь печати.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	Объект очереди печати, возвращаемый Get-Printer.
.Outputs
	System.Bool
	Подтверждает наличие либо отсутствие указанной очереди печати на локальном сервере печати.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-Printer
.Example
	Test-Printer -Name 'P00001'
	Проверяет наличие на локальном сервере печати очереди печати с именем P00001.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-Printer'
	)]

	param (
		# идентификация объекта PrintQueue - имя "принтера"
		[Parameter(
			Mandatory = $true
			, Position = 1
			, ValueFromPipelineByPropertyName = $true
		)]
		[String]
		$Name
	)

	process {
		try {
			return [bool] ( Get-Printer `
				-Name $Name `
				-ErrorAction SilentlyContinue `
			);
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
}

New-Alias -Name Test-PrintQueue -Value Test-Printer -Force;
