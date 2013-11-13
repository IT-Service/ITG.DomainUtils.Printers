$CurrentDir = `
	Split-Path `
		-Path $MyInvocation.MyCommand.Path `
		-Parent `
;

Function Import-LocalizedData {
	<#
		.Synopsis
			��������� �������������� ��������� �������.
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

Export-ModuleMember `
	-Function `
		Initialize-DomainUtilsConfiguration `
		, Test-DomainUtilsConfiguration `
		, Get-DomainUtilsConfiguration `
		, Get-ADPrintQueue `
		, Test-ADPrintQueue `
		, Initialize-ADPrintQueuesEnvironment `
		, New-ADPrintQueueGroup `
		, Get-ADPrintQueueGroup `
		, New-ADPrintQueueGPO `
		, Get-ADPrintQueueGPO `
		, Test-ADPrintQueueGPO `
		, Update-ADPrintQueueEnvironment `
		, Remove-ADPrintQueueEnvironment `
	-Alias `
		Get-ADPrinter `
		, Test-ADPrinter `
		, New-ADPrinterGroup `
		, Get-ADPrinterGroup `
		, New-ADPrinterGPO `
		, Get-ADPrinterGPO `
		, Test-ADPrinterGPO `
		, Update-ADPrinterEnvironment `
		, Remove-ADPrinterEnvironment `
;