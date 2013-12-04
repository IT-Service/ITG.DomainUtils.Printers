Function Test-PrintQueue {
<#
.Synopsis
	��������� ������� ����� ��� ���������� ��������� �������� ������. 
.Description
	Get-PrintQueue ���������� ������ PrintQueue ��� ��������� ����� ��� ��������� ���������
	�������� PrintQueue �� ��������� ������� ������.
.Inputs
	System.Printing.PrintQueue
	������� ������.
.Inputs
	System.String
	��� (Name) ������� ������.
.Outputs
	System.Bool
	������������ ������� ���� ���������� ��������� ������� ������ �� ��������� ������� ������.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueue
.Link
	System.Printing.LocalPrintServer
.Example
	Test-PrintQueue -Name 'P00001'
	��������� ������� �� ��������� ������� ������ ������� ������ � ������ P00001.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueue'
	)]

	param (
		# ������������� ������� PrintQueue - ��� "��������"
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
