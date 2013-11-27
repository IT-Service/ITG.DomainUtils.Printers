$CurrentDir = `
	Split-Path `
		-Path $MyInvocation.MyCommand.Path `
		-Parent `
;

Function Import-LocalizedData {
	<#
		.Synopsis
			«агружает локализованные строковые ресурсы.
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
. (	Join-Path -Path $CurrentDir -ChildPath 'ITG.DomainUtils.Printers.ps1' );
. (	Join-Path -Path $CurrentDir -ChildPath 'ITG.DomainUtils.LocalPrinters.ps1' );

Export-ModuleMember -Function Initialize-DomainUtilsPrintersConfiguration;
Export-ModuleMember -Function Test-DomainUtilsPrintersConfiguration;
Export-ModuleMember -Function Get-DomainUtilsPrintersConfiguration;

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

Export-ModuleMember -Function Get-PrintQueue -Alias Get-Printer;
Export-ModuleMember -Function Test-PrintQueue -Alias Test-Printer;

Export-ModuleMember -Function New-PrintQueueGroup -Alias New-PrinterGroup;
Export-ModuleMember -Function Get-PrintQueueGroup -Alias Get-PrinterGroup;
