$CurrentDir = `
	Split-Path `
		-Path $MyInvocation.MyCommand.Path `
		-Parent `
;

Function Import-LocalizedData {
	<#
		.Synopsis
			Загружает локализованные строковые ресурсы.
		.ForwardHelpTargetName
			Import-LocalizedData
		.ForwardHelpCategory
			Cmdlet
	#>
	[CmdletBinding(
		HelpUri = 'http://go.microsoft.com/fwlink/?LinkID=113342'
	)]
	param(
		[Parameter(
			Position = 0
			, Mandatory = $false
		)]
		[Alias( 'Variable' )]
		[ValidateNotNullOrEmpty()]
		[String]
		${BindingVariable}
	,
		[Parameter(
			Position = 1
			, Mandatory = $false
		)]
		[System.Globalization.CultureInfo]
		${UICulture} = ( Get-Culture )
	,
		[Parameter(
			Mandatory = $false
		)]
		[String]
		${BaseDirectory}
	,
		[Parameter(
			Mandatory = $false
		)]
		[String]
		${FileName}
	,
		[Parameter(
			Mandatory = $false
		)]
		[String[]]
		${SupportedCommand}
	)

	try {
		$wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand(
			'Import-LocalizedData'
			, [System.Management.Automation.CommandTypes]::Cmdlet
		);
		$loc = & $wrappedCmd @PSBoundParameters;
	} catch {
		throw;
	};
	return $loc;
};

$loc = Import-LocalizedData;

. (	Join-Path -Path $CurrentDir -ChildPath 'ITG.DomainUtils.Printers.Configuration.ps1' );

Export-ModuleMember -Function Initialize-DomainUtilsPrintersConfiguration;
Export-ModuleMember -Function Test-DomainUtilsPrintersConfiguration;
Export-ModuleMember -Function Get-DomainUtilsPrintersConfiguration;

. (	Join-Path -Path $CurrentDir -ChildPath 'ITG.DomainUtils.Printers.ps1' );

Export-ModuleMember -Function Get-ADPrintQueue -Alias Get-ADPrinter;
Export-ModuleMember -Function Test-ADPrintQueue -Alias Test-ADPrinter;

Export-ModuleMember -Function Initialize-ADPrintQueuesEnvironment;
Export-ModuleMember -Function New-ADPrintQueueGroup -Alias New-ADPrinterGroup;
Export-ModuleMember -Function Get-ADPrintQueueGroup -Alias Get-ADPrinterGroup;
Export-ModuleMember -Function New-ADPrintQueueGPO -Alias New-ADPrinterGPO;
Export-ModuleMember -Function Get-ADPrintQueueGPO -Alias Get-ADPrinterGPO;
Export-ModuleMember -Function Test-ADPrintQueueGPO -Alias Test-ADPrinterGPO;
Export-ModuleMember -Function Update-ADPrintQueueEnvironment -Alias Update-ADPrinterEnvironment;
Export-ModuleMember -Function Remove-ADPrintQueueEnvironment -Alias Remove-ADPrinterEnvironment;

. (	Join-Path -Path $CurrentDir -ChildPath 'ITG.DomainUtils.LocalPrinters.ps1' );

Export-ModuleMember -Function Test-Printer -Alias Test-PrintQueue;

. (	Join-Path -Path $CurrentDir -ChildPath 'ITG.DomainUtils.LocalPrintersGroups.ps1' );

Export-ModuleMember -Function New-PrinterGroup -Alias New-PrintQueueGroup;
Export-ModuleMember -Function Get-PrinterGroup -Alias Get-PrintQueueGroup;
Export-ModuleMember -Function Test-PrinterGroup -Alias Test-PrintQueueGroup;

. (	Join-Path -Path $CurrentDir -ChildPath 'ITG.DomainUtils.LocalPrintersEnvironment.ps1' );

Export-ModuleMember -Function Update-PrinterEnvironment -Alias Update-PrintQueueEnvironment;
