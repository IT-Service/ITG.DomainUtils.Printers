Function New-LocalGroup {
<#
.Synopsis
	������ ��������� ������ ������������. 
.Description
	New-LocalGroup ������ ��������� ������ ������������ � ���������� �����������.
.Outputs
	System.DirectoryServices.DirectoryEntry
	��������� ������ ������������.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#New-LocalGroup
.Example
	New-LocalGroup -Name 'MyUsers' -Description 'Users of my application';
	������ ��������� ������ ������������.
#>
	[CmdletBinding(
		SupportsShouldProcess = $true
		, ConfirmImpact = 'Medium'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#New-LocalGroup'
	)]

	param (
		# ������������� ������ ������������
		[Parameter(
			Mandatory = $true
			, Position = 1
			, ValueFromPipeline = $true
			, ValueFromPipelineByPropertyName = $true
		)]
		[String]
		[Alias( 'Identity' )]
		$Name
	,
		# �������� ������ ������������
		[Parameter(
			Mandatory = $false
			, ValueFromPipeline = $false
			, ValueFromPipelineByPropertyName = $true
		)]
		[String]
		$Description
	,
		# ���������� �� ��������� ������ ����� �� ���������
		[Switch]
		$PassThru
	)

	begin {
		try {
			[System.DirectoryServices.DirectoryEntry] $Computer = [ADSI]"WinNT://$Env:COMPUTERNAME,Computer";
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
	process {
		try {
			if ( $PSCmdlet.ShouldProcess( "$Name" ) ) {
				$Group = $Computer.Create( 'Group', $Name );
				$Group.SetInfo();
				$Group.Description = $Description;
				$Group.SetInfo();
				if ( $PassThru ) { return $Group };
			};
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
}

Function Get-LocalGroup {
<#
.Synopsis
	���������� ��������� ������ ������������. 
.Description
	Get-LocalGroup ���������� ��������� ������ (��� ������) ������������ � ���������� �����������.
.Outputs
	System.DirectoryServices.DirectoryEntry
	������ ������������.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-LocalGroup
.Example
	Get-LocalGroup;
	���������� ��� ��������� ������ ������������.
.Example
	Get-LocalGroup -Name '������������';
	���������� ��� ��������� ������ ������������.
#>
	[CmdletBinding(
		DefaultParametersetName = 'Filter'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-LocalGroup'
	)]

	param (
		# ������������� ������ ������������
		[Parameter(
			Mandatory = $true
			, Position = 1
			, ValueFromPipeline = $true
			, ValueFromPipelineByPropertyName = $true
			, ParameterSetName = 'Identity'
		)]
		[String]
		[Alias( 'Identity' )]
		$Name
	)

	begin {
		try {
			[System.DirectoryServices.DirectoryEntry] $Computer = [ADSI]"WinNT://$Env:COMPUTERNAME,Computer";
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
	process {
		try {
			switch ( $PsCmdlet.ParameterSetName ) {
				'Identity' {
					$Group = [System.DirectoryServices.DirectoryEntry] $Group = [ADSI]"WinNT://$Env:COMPUTERNAME/$Name,Group";
                    if ( $Group.Path ) {
                        return $Group;
                    } else {
			            Write-Error `
				            -Message ( [String]::Format( $loc.LocalGroupNotFound, $Name ) ) `
				            -Category ObjectNotFound `
			            ;
                    };
				}
				'Filter' {
					$Computer.Children `
					| ? { $_.SchemaClassName -eq 'Group' } `
					;
				}
			};
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
}

Function Test-LocalGroup {
<#
.Synopsis
	��������� ������� ��������� ������ ������������. 
.Outputs
	System.Bool
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-LocalGroup
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-LocalGroup'
	)]

	param (
		# ������������� ������ ������������
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
			return [Bool] ( Get-LocalGroup -Name $Name -ErrorAction SilentlyContinue );
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
}
