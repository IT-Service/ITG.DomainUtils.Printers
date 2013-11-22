Function New-LocalGroup {
<#
.Synopsis
	Создаёт локальную группу безопасности. 
.Description
	New-LocalGroup создаёт локальную группу безопасности с указанными аттрибутами.
.Outputs
	System.Printing.PrintQueue
	Созданная группа безопасности.
.Link
	https://github.com/IT-Service/ITG.DomainUtils.Printers#New-LocalGroup
.Example
	New-LocaGroup -Name 'MyUsers' -Description 'Users of my application';
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
