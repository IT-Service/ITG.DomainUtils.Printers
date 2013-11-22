Function New-LocalGroup {
<#
.Synopsis
	Создаёт локальную группу безопасности. 
.Description
	New-LocalGroup создаёт локальную группу безопасности с указанными аттрибутами.
.Outputs
	System.DirectoryServices.DirectoryEntry
	Созданная группа безопасности.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#New-LocalGroup
.Example
	New-LocalGroup -Name 'MyUsers' -Description 'Users of my application';
	Создаёт локальную группу безопасности.
#>
	[CmdletBinding(
		SupportsShouldProcess = $true
		, ConfirmImpact = 'Medium'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#New-LocalGroup'
	)]

	param (
		# Идентификатор группы безопасности
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
		# Описание группы безопасности
		[Parameter(
			Mandatory = $false
			, ValueFromPipeline = $false
			, ValueFromPipelineByPropertyName = $true
		)]
		[String]
		$Description
	,
		# Передавать ли созданные группы далее по конвейеру
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
	Возвращает локальную группу безопасности. 
.Description
	Get-LocalGroup возвращает локальную группу (или группы) безопасности с указанными параметрами.
.Outputs
	System.DirectoryServices.DirectoryEntry
	Группа безопасности.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-LocalGroup
.Example
	Get-LocalGroup;
	Возвращает все локальные группы безопасности.
.Example
	Get-LocalGroup -Name 'Пользователи';
	Возвращает все локальные группы безопасности.
#>
	[CmdletBinding(
		DefaultParametersetName = 'Filter'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-LocalGroup'
	)]

	param (
		# Идентификатор группы безопасности
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
	Проверяет наличие локальной группы безопасности. 
.Outputs
	System.Bool
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-LocalGroup
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-LocalGroup'
	)]

	param (
		# Идентификатор группы безопасности
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
