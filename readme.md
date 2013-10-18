﻿ITG.DomainUtils
===============

Данный модуль предоставляет набор командлет для автоматизации ряда операций в домене Windows.

Тестирование модуля и подготовка к публикации
---------------------------------------------

Для сборки модуля использую проект [psake](https://github.com/psake/psake). Для инициирования сборки используйте сценарий `build.ps1`.
Для модульных тестов использую проект [pester](https://github.com/pester/pester).


Версия модуля: **0.1.0**

ПОДДЕРЖИВАЮТСЯ КОМАНДЛЕТЫ
-------------------------

### ADPrintQueue

#### КРАТКОЕ ОПИСАНИЕ [Get-ADPrintQueue][]

Возвращает один или несколько объектов AD с классом printQueue.

	Get-ADPrintQueue [-Filter <String>] [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

	Get-ADPrintQueue [-Identity] <ADObject> [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

	Get-ADPrintQueue -LDAPFilter <String> [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [Test-ADPrintQueue][]

Определяет существует ли объект AD с классом printQueue с указанными фильтрами.

	Test-ADPrintQueue -Filter <String> [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

	Test-ADPrintQueue [-Identity] <ADObject> [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

	Test-ADPrintQueue -LDAPFilter <String> [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

### ADPrintQueueContainer

#### КРАТКОЕ ОПИСАНИЕ [Get-ADPrintQueueContainer][]

Возвращает контейнер AD для объекта printQueue.

	Get-ADPrintQueueContainer [[-InputObject] <ADObject>] [-Properties <String[]>] [-DomainUtilsBase <String>] [-ContainerClass <String>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [New-ADPrintQueueContainer][]

Создаёт контейнер AD для указанного объекта printQueue.

	New-ADPrintQueueContainer [-InputObject] <ADObject> [-DomainUtilsBase <String>] [-ContainerClass <String>] [-Description <String>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [Test-ADPrintQueueContainer][]

Проверяет наличие контейнера AD для указанного объекта printQueue.

	Test-ADPrintQueueContainer [[-InputObject] <ADObject>] [-DomainUtilsBase <String>] [-ContainerClass <String>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

### ADPrintQueueGroup

#### КРАТКОЕ ОПИСАНИЕ [Get-ADPrintQueueGroup][]

Возвращает затребованные группы безопасности для указанного объекта printQueue.

	Get-ADPrintQueueGroup [-InputObject] <ADObject> [-DomainUtilsBase <String>] [-GroupType <String[]>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [New-ADPrintQueueGroup][]

Создаёт группы безопасности для указанного объекта printQueue.

	New-ADPrintQueueGroup [-InputObject] <ADObject> [-DomainUtilsBase <String>] [-GroupType <String[]>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

### ADPrintQueuesEnvironment

#### КРАТКОЕ ОПИСАНИЕ [Initialize-ADPrintQueuesEnvironment][]

Создаёт корневой контейнер для контейнеров объектов printQueue.

	Initialize-ADPrintQueuesEnvironment [[-DomainUtilsBase] <String>] [[-ContainerClass] <String>] [[-Description] <String>] [[-AuthType]] [[-Credential] <PSCredential>] [[-Server] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

ОПИСАНИЕ
--------

#### Get-ADPrintQueue

[Get-ADPrintQueue][] возвращает объект printQueue или выполняет поиск для выявления множества
объектов ADObject класса printQueue.

Параметр `Identity` (см. [about_ActiveDirectory_Identity][]) указывает объект Active Directory класса printQueue.
Вы можете идентифицировать очередь печати через полное имя (DN), GUID, или printQueue имя (CN).
Вы можете указать этот параметр явно или передать его по конвейеру.

Для поиска и возврата нескольких объектов используйте параметры `Filter` или `LDAPFilter`.
Параметр `Filter` использует PowerShell Expression Language для записи строки запроса
для Active Directory (см. [about_ActiveDirectory_Filter][]).
Если Вы уже имеете LDAP запрос, используйте параметр `LDAPFilter`.

##### ПСЕВДОНИМЫ

Get-ADPrinter

##### СИНТАКСИС

	Get-ADPrintQueue [-Filter <String>] [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

	Get-ADPrintQueue [-Identity] <ADObject> [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

	Get-ADPrintQueue -LDAPFilter <String> [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject принимаемый параметром `Identity`.

##### ВЫХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
Возвращает один или несколько объектов класса printQueue.

##### ПАРАМЕТРЫ

- `[String] Filter`
	запрос в синтаксисе PowerShell Expression Language (см. [about_ActiveDirectory_Filter][])
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `*`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADObject] Identity`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 2
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] LDAPFilter`
	Строка запроса в синтаксисе ldap
	* Тип: [System.String][]
	* Требуется? да
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String[]] Properties`
	Перечень свойств объекта printQueue для запроса из ActiveDirectory
	* Тип: [System.String][][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `@(
	'DistinguishedName'
	, 'Name'
	, 'printerName'
	, 'printShareName'
	, 'serverName'
	, 'ObjectClass'
	, 'ObjectGUID'
	)`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[Int32] ResultPageSize`
	Количество объектов, включаемых в одну страницу для ldap ответа
	* Тип: [System.Int32][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `256`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[Int32] ResultSetSize`
	Максимальное количество возвращаемых объектов AD
	* Тип: [System.Int32][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] SearchBase`
	путь к контейнеру AD, в котором требуется осуществить поиск
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADSearchScope] SearchScope`
	область поиска
	* Тип: [Microsoft.ActiveDirectory.Management.ADSearchScope][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Subtree`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADAuthType] AuthType`
	Метод аутентификации
	* Тип: [Microsoft.ActiveDirectory.Management.ADAuthType][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Negotiate`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[PSCredential] Credential`
	Учётные данные для выполнения данной операции
	* Тип: [System.Management.Automation.PSCredential][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Возвращает все очереди печати в контейнере 'OU=Finance,OU=UserAccounts,DC=FABRIKAM,DC=COM'.

		Get-ADPrintQueue -Filter * -SearchBase "OU=Finance,OU=UserAccounts,DC=FABRIKAM,DC=COM"

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils#Get-ADPrintQueue)
- [Get-ADObject][]

#### Test-ADPrintQueue

[Test-ADPrintQueue][] выполняет поиск для выявления множества
объектов ADObject класса printQueue с указанными характеристиками, и возвращает
`$true` если такие объекты есть, и `$false` в противном случае.

Параметр `Identity` (см. [about_ActiveDirectory_Identity][]) указывает объект Active Directory класса printQueue.
Вы можете идентифицировать очередь печати через полное имя (DN), GUID, или printQueue имя (CN).
Вы можете указать этот параметр явно или передать его по конвейеру.

Для поиска и возврата нескольких объектов используйте параметры `Filter` или `LDAPFilter`.
Параметр `Filter` использует PowerShell Expression Language для записи строки запроса
для Active Directory (см. [about_ActiveDirectory_Filter][]).
Если Вы уже имеете LDAP запрос, используйте параметр `LDAPFilter`.

##### ПСЕВДОНИМЫ

Test-ADPrinter

##### СИНТАКСИС

	Test-ADPrintQueue -Filter <String> [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

	Test-ADPrintQueue [-Identity] <ADObject> [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

	Test-ADPrintQueue -LDAPFilter <String> [-SearchBase <String>] [-SearchScope] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject принимаемый параметром `Identity`.

##### ВЫХОДНЫЕ ДАННЫЕ

- bool
истина - объекты, соответствующие указанным ограничениям, существуют;
ложь - не существуют

##### ПАРАМЕТРЫ

- `[String] Filter`
	запрос в синтаксисе PowerShell Expression Language (см. [about_ActiveDirectory_Filter][])
	* Тип: [System.String][]
	* Требуется? да
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADObject] Identity`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 2
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] LDAPFilter`
	Строка запроса в синтаксисе ldap
	* Тип: [System.String][]
	* Требуется? да
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] SearchBase`
	путь к контейнеру AD, в котором требуется осуществить поиск
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADSearchScope] SearchScope`
	область поиска
	* Тип: [Microsoft.ActiveDirectory.Management.ADSearchScope][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Subtree`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADAuthType] AuthType`
	Метод аутентификации
	* Тип: [Microsoft.ActiveDirectory.Management.ADAuthType][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Negotiate`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[PSCredential] Credential`
	Учётные данные для выполнения данной операции
	* Тип: [System.Management.Automation.PSCredential][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Пример

		Test-ADPrintQueue -Filter * -SearchBase "OU=Finance,OU=UserAccounts,DC=FABRIKAM,DC=COM"

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils#Test-ADPrintQueue)
- [Get-ADPrintQueue][]

#### Get-ADPrintQueueContainer

[Get-ADPrintQueueContainer][] возвращает объект контейнера для указанного
через InputObject объекта printQueue.

##### ПСЕВДОНИМЫ

Get-ADPrinterContainer

##### СИНТАКСИС

	Get-ADPrintQueueContainer [[-InputObject] <ADObject>] [-Properties <String[]>] [-DomainUtilsBase <String>] [-ContainerClass <String>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].
Если объект не указан, будут возвращены все контейнеры созданные для очередей печати.

##### ВЫХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
Возвращает контейнер для указанного объекта класса printQueue.

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? нет
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String[]] Properties`
	Перечень свойств объекта контейнера для запроса из ActiveDirectory
	* Тип: [System.String][][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] DomainUtilsBase`
	путь к контейнеру AD, в котором расположены все контейнеры, используемые утилитами данного модуля
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DistinguishedName )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] ContainerClass`
	класс контейнера, создаваемого для каждого принтера
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `container`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADAuthType] AuthType`
	Метод аутентификации
	* Тип: [Microsoft.ActiveDirectory.Management.ADAuthType][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Negotiate`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[PSCredential] Credential`
	Учётные данные для выполнения данной операции
	* Тип: [System.Management.Automation.PSCredential][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Возвращает контейнер для очереди печати 'prn001'.

		Get-ADPrintQueue -Filter {name -eq 'prn001'} | Get-ADPrintQueueContainer

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils#Get-ADPrintQueueContainer)
- [Get-ADObject][]
- [Get-ADPrintQueue][]

#### New-ADPrintQueueContainer

[New-ADPrintQueueContainer][] создаёт объект контейнера для указанного
через InputObject объекта printQueue.

##### ПСЕВДОНИМЫ

New-ADPrinterContainer

##### СИНТАКСИС

	New-ADPrintQueueContainer [-InputObject] <ADObject> [-DomainUtilsBase <String>] [-ContainerClass <String>] [-Description <String>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].

##### ВЫХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
Возвращает контейнер для указанного объекта класса printQueue
при выполнении с ключом PassThru.

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] DomainUtilsBase`
	путь к контейнеру AD, в котором расположены все контейнеры, используемые утилитами данного модуля
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DistinguishedName )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] ContainerClass`
	класс контейнера, создаваемого для каждого принтера
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `container`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Description`
	описание контейнера
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( $loc.PrintQueueContainerDescription )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADAuthType] AuthType`
	Метод аутентификации
	* Тип: [Microsoft.ActiveDirectory.Management.ADAuthType][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Negotiate`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[PSCredential] Credential`
	Учётные данные для выполнения данной операции
	* Тип: [System.Management.Automation.PSCredential][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[SwitchParameter] PassThru`
	Передавать ли созданный контейнер далее по конвейеру
	

- `[SwitchParameter] WhatIf`
	* Псевдонимы: wi

- `[SwitchParameter] Confirm`
	* Псевдонимы: cf

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Создаёт контейнер для очереди печати 'prn001'.

		Get-ADPrintQueue -Filter {name -eq 'prn001'} | New-ADPrintQueueContainer

2. Создаёт контейнеры для всех очередей печати, если они не сущетвуют,
и выполняет для каждого созданного то либо иное действие.
Если контейнер уже существует, он не удаляется и не пересоздаётся, и дополнительных
действий для него выполнено не будет.

		Get-ADPrintQueue | New-ADPrintQueueContainer -PassThru | % { do-something }

3. Создаём только отсутствующие контейнеры для всех зарегистрированных в AD очередей печати.

		Get-ADPrintQueue | ? { -not ( Test-ADPrintQueueContainer $_ ) } | New-ADPrintQueueContainer -Confirm

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils#New-ADPrintQueueContainer)
- [New-ADObject][]
- [Get-ADPrintQueue][]

#### Test-ADPrintQueueContainer

Проверяет наличие контейнера AD для указанного объекта printQueue.

##### ПСЕВДОНИМЫ

Test-ADPrinterContainer

##### СИНТАКСИС

	Test-ADPrintQueueContainer [[-InputObject] <ADObject>] [-DomainUtilsBase <String>] [-ContainerClass <String>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].

##### ВЫХОДНЫЕ ДАННЫЕ

- bool
истина - объекты, соответствующие указанным ограничениям, существуют;
ложь - не существуют

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? нет
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] DomainUtilsBase`
	путь к контейнеру AD, в котором расположены все контейнеры, используемые утилитами данного модуля
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DistinguishedName )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] ContainerClass`
	класс контейнера, создаваемого для каждого принтера
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `container`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADAuthType] AuthType`
	Метод аутентификации
	* Тип: [Microsoft.ActiveDirectory.Management.ADAuthType][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Negotiate`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[PSCredential] Credential`
	Учётные данные для выполнения данной операции
	* Тип: [System.Management.Automation.PSCredential][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Проверяем наличие контейнера для очереди печати 'prn001'.

		Get-ADPrintQueue -Filter {name -eq 'prn001'} | Test-ADPrintQueueContainer

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils#Test-ADPrintQueueContainer)
- [Get-ADPrintQueueContainer][]
- [Get-ADObject][]

#### Get-ADPrintQueueGroup

[Get-ADPrintQueueGroup][] возвращает группы безопасности
(Пользователи принтера, Операторы принтера) для указанного
через InputObject объекта printQueue.

##### ПСЕВДОНИМЫ

Get-ADPrinterGroup

##### СИНТАКСИС

	Get-ADPrintQueueGroup [-InputObject] <ADObject> [-DomainUtilsBase <String>] [-GroupType <String[]>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].

##### ВЫХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADGroup][][]
Возвращает затребованные группы безопасности.

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] DomainUtilsBase`
	путь к контейнеру AD, в котором расположены все контейнеры, используемые утилитами данного модуля
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DistinguishedName )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String[]] GroupType`
	тип группы: Users (группа пользователей), Administrators (группа администраторов).
	Группа пользователей получит право применения групповой политики для этой очереди печати, и право печати.
	Группа администраторов не получит право применения GPO, но получит право печати и право управления всеми документами
	в указанной очереди печати.
	* Тип: [System.String][][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Users`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADAuthType] AuthType`
	Метод аутентификации
	* Тип: [Microsoft.ActiveDirectory.Management.ADAuthType][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Negotiate`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[PSCredential] Credential`
	Учётные данные для выполнения данной операции
	* Тип: [System.Management.Automation.PSCredential][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Возвращает группу безопасности Пользователи принтера для очереди печати 'prn001'.

		Get-ADPrintQueue -Filter {name -eq 'prn001'} | Get-ADPrintQueueGroup -GroupType Users

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils#Get-ADPrintQueueGroup)
- [Get-ADObject][]
- [Get-ADGroup][]
- [Get-ADPrintQueue][]

#### New-ADPrintQueueGroup

[New-ADPrintQueueGroup][] создаёт группы безопасности
(Пользователи принтера, Операторы принтера) для указанного
через InputObject объекта printQueue.

##### ПСЕВДОНИМЫ

New-ADPrinterGroup

##### СИНТАКСИС

	New-ADPrintQueueGroup [-InputObject] <ADObject> [-DomainUtilsBase <String>] [-GroupType <String[]>] [-AuthType] [-Credential <PSCredential>] [-Server <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].

##### ВЫХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADGroup][][]
Возвращает созданные группы безопасности при выполнении с ключом PassThru.

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] DomainUtilsBase`
	путь к контейнеру AD, в котором расположены все контейнеры, используемые утилитами данного модуля
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DistinguishedName )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String[]] GroupType`
	тип группы: Users (группа пользователей), Administrators (группа администраторов).
	Группа пользователей получит право применения групповой политики для этой очереди печати, и право печати.
	Группа администраторов не получит право применения GPO, но получит право печати и право управления всеми документами
	в указанной очереди печати.
	* Тип: [System.String][][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( 'Users', 'Administrators' )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADAuthType] AuthType`
	Метод аутентификации
	* Тип: [Microsoft.ActiveDirectory.Management.ADAuthType][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `Negotiate`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[PSCredential] Credential`
	Учётные данные для выполнения данной операции
	* Тип: [System.Management.Automation.PSCredential][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[SwitchParameter] PassThru`
	Передавать ли созданные группы далее по конвейеру
	

- `[SwitchParameter] WhatIf`
	* Псевдонимы: wi

- `[SwitchParameter] Confirm`
	* Псевдонимы: cf

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Создаёт группы безопасности для очереди печати 'prn001'.

		Get-ADPrintQueue -Filter {name -eq 'prn001'} | New-ADPrintQueueGroup

2. Создаёт группы безопасности "Пользователи принтера" для всех обнаруженных
очередей печати.

		Get-ADPrintQueue | New-ADPrintQueueGroup -GroupType Users

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils#New-ADPrintQueueGroup)
- [New-ADObject][]
- [New-ADGroup][]
- [Get-ADPrintQueue][]

#### Initialize-ADPrintQueuesEnvironment

Создаёт корневой контейнер для контейнеров объектов printQueue.
Данную функцию следует вызывать однократно для создания необходимых
контейнеров и объектов.

##### СИНТАКСИС

	Initialize-ADPrintQueuesEnvironment [[-DomainUtilsBase] <String>] [[-ContainerClass] <String>] [[-Description] <String>] [[-AuthType]] [[-Credential] <PSCredential>] [[-Server] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### ВЫХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
Возвращает корневой контейнер при ключе -PassThru.

##### ПАРАМЕТРЫ

- `[String] DomainUtilsBase`
	путь к контейнеру AD, в котором расположены все контейнеры, используемые утилитами данного модуля
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 1
	* Значение по умолчанию `"$( ( Get-ADDomain ).DistinguishedName )"`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] ContainerClass`
	класс контейнера, создаваемого для каждого принтера
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 2
	* Значение по умолчанию `container`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Description`
	описание контейнера
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 3
	* Значение по умолчанию `( $loc.PrintQueuesContainerDescription )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[ADAuthType] AuthType`
	Метод аутентификации
	* Тип: [Microsoft.ActiveDirectory.Management.ADAuthType][]
	* Требуется? нет
	* Позиция? 4
	* Значение по умолчанию `Negotiate`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[PSCredential] Credential`
	Учётные данные для выполнения данной операции
	* Тип: [System.Management.Automation.PSCredential][]
	* Требуется? нет
	* Позиция? 5
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 6
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[SwitchParameter] PassThru`
	Передавать ли созданный контейнер далее по конвейеру
	

- `[SwitchParameter] WhatIf`
	* Псевдонимы: wi

- `[SwitchParameter] Confirm`
	* Псевдонимы: cf

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Создаёт корневой контейнер с параметрами по умолчанию.

		Initialize-ADPrintQueuesEnvironment

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils#Initialize-ADPrintQueuesEnvironment)
- [Get-ADObject][]


[about_ActiveDirectory_Filter]: http://technet.microsoft.com/library/hh531527.aspx 
[about_ActiveDirectory_Identity]: http://technet.microsoft.com/library/hh531526.aspx 
[about_CommonParameters]: http://go.microsoft.com/fwlink/?LinkID=113216 "Describes the parameters that can be used with any cmdlet."
[Get-ADGroup]: <http://go.microsoft.com/fwlink/?linkid=219302> "Gets one or more Active Directory groups."
[Get-ADObject]: <http://go.microsoft.com/fwlink/?linkid=219298> "Gets one or more Active Directory objects."
[Get-ADPrintQueue]: <#get-adprintqueue> "Возвращает один или несколько объектов AD с классом printQueue."
[Get-ADPrintQueueContainer]: <#get-adprintqueuecontainer> "Возвращает контейнер AD для объекта printQueue."
[Get-ADPrintQueueGroup]: <#get-adprintqueuegroup> "Возвращает затребованные группы безопасности для указанного объекта printQueue."
[Initialize-ADPrintQueuesEnvironment]: <#initialize-adprintqueuesenvironment> "Создаёт корневой контейнер для контейнеров объектов printQueue."
[Microsoft.ActiveDirectory.Management.ADAuthType]: <http://msdn.microsoft.com/ru-ru/library/microsoft.activedirectory.management.adauthtype.aspx> "ADAuthType Class (Microsoft.ActiveDirectory.Management)"
[Microsoft.ActiveDirectory.Management.ADGroup]: <http://msdn.microsoft.com/ru-ru/library/microsoft.activedirectory.management.adgroup.aspx> "ADGroup Class (Microsoft.ActiveDirectory.Management)"
[Microsoft.ActiveDirectory.Management.ADObject]: <http://msdn.microsoft.com/ru-ru/library/microsoft.activedirectory.management.adobject.aspx> "ADObject Class (Microsoft.ActiveDirectory.Management)"
[Microsoft.ActiveDirectory.Management.ADSearchScope]: <http://msdn.microsoft.com/ru-ru/library/microsoft.activedirectory.management.adsearchscope.aspx> "ADSearchScope Class (Microsoft.ActiveDirectory.Management)"
[New-ADGroup]: <http://go.microsoft.com/fwlink/?linkid=219326> "Creates an Active Directory group."
[New-ADObject]: <http://go.microsoft.com/fwlink/?linkid=219323> "Creates an Active Directory object."
[New-ADPrintQueueContainer]: <#new-adprintqueuecontainer> "Создаёт контейнер AD для указанного объекта printQueue."
[New-ADPrintQueueGroup]: <#new-adprintqueuegroup> "Создаёт группы безопасности для указанного объекта printQueue."
[System.Int32]: <http://msdn.microsoft.com/ru-ru/library/system.int32.aspx> "Int32 Class (System)"
[System.Management.Automation.PSCredential]: <http://msdn.microsoft.com/ru-ru/library/system.management.automation.pscredential.aspx> "PSCredential Class (System.Management.Automation)"
[System.String]: <http://msdn.microsoft.com/ru-ru/library/system.string.aspx> "String Class (System)"
[Test-ADPrintQueue]: <#test-adprintqueue> "Определяет существует ли объект AD с классом printQueue с указанными фильтрами."
[Test-ADPrintQueueContainer]: <#test-adprintqueuecontainer> "Проверяет наличие контейнера AD для указанного объекта printQueue."

---------------------------------------

Генератор: [ITG.Readme](https://github.com/IT-Service/ITG.Readme "Модуль PowerShell для генерации readme для модулей PowerShell").

