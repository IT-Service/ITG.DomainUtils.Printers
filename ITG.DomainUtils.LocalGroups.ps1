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
	ADSI объект, представляющий группу безопасности.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-LocalGroup
.Example
	Get-LocalGroup;
	Возвращает все локальные группы безопасности.
.Example
	Get-LocalGroup -Name 'Пользователи';
	Возвращает группу безопасности Пользователи.
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
					[System.DirectoryServices.DirectoryEntry] $Group = $Computer.Children.Find( $Name, 'Group' );
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

Function Remove-LocalGroup {
<#
.Synopsis
	Удаляет локальную группу безопасности. 
.Description
	Remove-LocalGroup удаляет локальную группу (или группы) безопасности, переданные по конвейеру.
.Inputs
	System.DirectoryServices.DirectoryEntry
	Группа безопасности.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Remove-LocalGroup
.Example
	Get-LocalGroup -Name 'Пользователи' | Remove-LocalGroup;
	Удаляет группу безопасности 'Пользователи'.
#>
	[CmdletBinding(
		SupportsShouldProcess = $true
		, ConfirmImpact = 'High'
		, HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Remove-LocalGroup'
	)]

	param (
		# Группа безопасности к удалению
		# Идентификатор группы безопасности
		[Parameter(
			Mandatory = $true
			, Position = 1
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
			if ( $PSCmdlet.ShouldProcess( "$Name" ) ) {
				$Computer.Delete( 'Group', $Name );
			};
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
}

Function Get-LocalGroupMember {
<#
.Synopsis
	Возвращает членов локальной группы безопасности. 
.Description
	Get-LocalGroupMember возвращает членов указанной локальной группы безопасности.
	В том числе - и с учётом транзитивности при указании флага `-Recursive`
.Inputs
	System.DirectoryServices.DirectoryEntry
	Группа безопасности.
.Outputs
	System.DirectoryServices.DirectoryEntry
	Члены указанной группы безопасности.
.Outputs
	PSObject
	Для групп типа `NT AUTHORITY/ИНТЕРАКТИВНЫЕ` возвращён будет объект,
	содержащий свойства `Path`, `Name`, `objectSid`, `groupType`.
	`SchemaClassName` будет установлен в `Group`, `AuthenticationType` в `Secure`.
	Дополнительно будет установлен аттрибут `NtAuthority` в `$true`.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-LocalGroupMember
.Example
	Get-LocalGroup -Name Пользователи | Get-LocalGroupMember -Recursive;
	Возвращает всех членов группы Пользователи с учётом транзитивности.
#>
	[CmdletBinding(
		HelpUri = 'https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-LocalGroupMember'
	)]

	param (
		# Группа безопасности
		[Parameter(
			Mandatory = $true
			, Position = 1
			, ValueFromPipeline = $true
		)]
		[System.DirectoryServices.DirectoryEntry]
		[Alias( 'Group' )]
		$Identity
	,
		# Запросить членов группы с учётом транзитивности
		[Switch]
		$Recursive
	)

	process {
		try {
			$Members = (
				$Identity.PSBase.Invoke( 'Members' ) `
				| % { 
					$Member = [ADSI]( $_.GetType().InvokeMember( 'ADsPath', 'GetProperty', $null, $_, $null ) );
					if ( $Member.Path ) { # объект не типа NT AUTHORITY/ИНТЕРАКТИВНЫЕ
						$Member;
					} else {
						New-Object PSObject -Property @{
							Path = ( $_.GetType().InvokeMember( 'ADsPath', 'GetProperty', $null, $_, $null ) );
							Name =  ( $_.GetType().InvokeMember( 'Name', 'GetProperty', $null, $_, $null ) );
							objectSid =  ( $_.GetType().InvokeMember( 'objectSid', 'GetProperty', $null, $_, $null ) );
							groupType = ( $_.GetType().InvokeMember( 'groupType', 'GetProperty', $null, $_, $null ) );
							SchemaClassName = 'Group';
							AuthenticationType = [System.DirectoryServices.AuthenticationTypes]::Secure;
							NtAuthority = $true;
						};
					};
				} `
			);
			if ( -not $Recursive ) {
				return $Members;
			} else {
				$Members `
				| % {
					$_;
					if ( ( $_.SchemaClassName -eq 'Group' ) -and -not ( $_.NtAuthority -eq $true ) ) {
						$_ | Get-LocalGroupMember -Recursive;
					};
				} `
				| Sort-Object `
					-Property 'Path' `
					-Unique `
				;
			};
		} catch {
			Write-Error `
				-ErrorRecord $_ `
			;
		};
	}
}
