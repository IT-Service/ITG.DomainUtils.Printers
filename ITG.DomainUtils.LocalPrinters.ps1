Function Test-Printer {
<#
.Synopsis
	��������� ������� ����� ��� ���������� ��������� �������� ������. 
.Inputs
	System.Printing.PrintQueue
	������� ������.
.Inputs
	Microsoft.Management.Infrastructure.CimInstance
	������ ������� ������, ������������ Get-Printer.
.Outputs
	System.Bool
	������������ ������� ���� ���������� ��������� ������� ������ �� ��������� ������� ������.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-Printer
.Example
	Test-Printer -Name 'P00001'
	��������� ������� �� ��������� ������� ������ ������� ������ � ������ P00001.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-Printer'
	)]

	param (
		# ������������� ������� PrintQueue - ��� "��������"
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
