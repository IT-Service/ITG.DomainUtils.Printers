$ModuleName = Split-Path -Path '.' -Leaf -Resolve;
$ModuleDir = Resolve-Path -Path '.';

Describe 'ITG.DomainUtils module' {

	It 'must be imported without errors' {
		{
			Import-Module `
				-Name "$ModuleDir\$ModuleName.psd1" `
				-Force `
			;
		} `
		| Should Not Throw;
	};

};

. "$ModuleDir\$ModuleName.ps1";

Describe 'Get-ADPrintQueue' {

	It ': Get-ADPrinter must exist' {
		'Alias:Get-ADPrinter' | Should Exist;
	};

	<#
	����� � Mock Get-ADObject �� ���������, ������ ��� Proxy ��� ��������� � ����������� �������� ���������� �� ������������.

   	Mock Get-ADObject -verifiable;

	It 'must call Get-ADObject' {
		$result = Get-ADPrintQueue `
			-Filter '*' `
		;
		Assert-MockCalled Get-ADObject 1;
	};

	It 'must pass to Get-ADObject correct Filter' {
		Get-ADPrintQueue `
			-Filter '*' `
		| Should Be "objectClass -eq 'printQueue'";

		Get-ADPrintQueue `
			-Filter "name -like '*00001'" `
		| Should Be "(objectClass -eq 'printQueue') -and (name -like '*00001')";
	};

	#>
};

Describe 'Test-ADPrintQueue' {
	It ': Test-ADPrinter must exist' {
		'Alias:Test-ADPrinter' | Should Exist;
	};
};
