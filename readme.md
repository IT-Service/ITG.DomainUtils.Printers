ITG.DomainUtils.Printers
========================

Данный модуль предоставляет набор командлет для автоматизации ряда операций с публикацией принтеров в домене Windows.

Тестирование модуля и подготовка к публикации
---------------------------------------------

Для сборки модуля использую проект [psake](https://github.com/psake/psake). Для инициирования сборки используйте сценарий `build.ps1`.
Для модульных тестов использую проект [pester](https://github.com/pester/pester).


Версия модуля: **0.2.0**

ПОДДЕРЖИВАЮТСЯ КОМАНДЛЕТЫ
-------------------------

### ADPrintQueue

#### КРАТКОЕ ОПИСАНИЕ [Get-ADPrintQueue][]

Возвращает один или несколько объектов AD с классом printQueue.

	Get-ADPrintQueue [-Filter <String>] [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

	Get-ADPrintQueue [-Identity] <ADObject> [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

	Get-ADPrintQueue -LDAPFilter <String> [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [Test-ADPrintQueue][]

Определяет существует ли объект AD с классом printQueue с указанными фильтрами.

	Test-ADPrintQueue -Filter <String> [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

	Test-ADPrintQueue [-Identity] <ADObject> [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

	Test-ADPrintQueue -LDAPFilter <String> [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

### ADPrintQueueEnvironment

#### КРАТКОЕ ОПИСАНИЕ [Remove-ADPrintQueueEnvironment][]

Удаляет группы безопасности и объект GPO для указанной очереди печати.

	Remove-ADPrintQueueEnvironment [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] [-WhatIf] [-Confirm] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [Update-ADPrintQueueEnvironment][]

Создаёт (при отсутствии) группы безопасности и объект GPO.

	Update-ADPrintQueueEnvironment [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] [-DefaultPrinterSelectionMode <String>] [-Port <String>] [-AsPersistent] [-WhatIf] [-Confirm] <CommonParameters>

### ADPrintQueueGPO

#### КРАТКОЕ ОПИСАНИЕ [Get-ADPrintQueueGPO][]

Возвращает объект групповой политики, применяемой к пользователям указанного объекта printQueue.

	Get-ADPrintQueueGPO [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [New-ADPrintQueueGPO][]

Создаёт групповую политику, применяемую к пользователям указанного объекта printQueue.

	New-ADPrintQueueGPO [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] [-Force] [-DefaultPrinterSelectionMode <String>] [-Port <String>] [-AsPersistent] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [Test-ADPrintQueueGPO][]

Проверяет наличие объекта групповой политики, применяемой к пользователям указанного объекта printQueue.

	Test-ADPrintQueueGPO [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] <CommonParameters>

### ADPrintQueueGroup

#### КРАТКОЕ ОПИСАНИЕ [Get-ADPrintQueueGroup][]

Возвращает затребованные группы безопасности для указанного объекта printQueue.

	Get-ADPrintQueueGroup [-InputObject] <ADObject> [-GroupType <String[]>] [-Domain <String>] [-Server <String>] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [New-ADPrintQueueGroup][]

Создаёт группы безопасности для указанного объекта printQueue.

	New-ADPrintQueueGroup [-InputObject] <ADObject> [-GroupType <String[]>] [-Domain <String>] [-Server <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

### ADPrintQueuesEnvironment

#### КРАТКОЕ ОПИСАНИЕ [Initialize-ADPrintQueuesEnvironment][]

Создаёт корневой контейнер для контейнеров объектов printQueue.

	Initialize-ADPrintQueuesEnvironment [[-Domain] <String>] [[-Server] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

### DomainUtilsPrintersConfiguration

#### КРАТКОЕ ОПИСАНИЕ [Get-DomainUtilsPrintersConfiguration][]

Получаем объект, содержащий конфигурацию модуля для указанного домена.

	Get-DomainUtilsPrintersConfiguration [[-Domain] <String>] [[-Server] <String>] [-NoCache] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [Initialize-DomainUtilsPrintersConfiguration][]

Инициализация конфигурации модуля.

	Initialize-DomainUtilsPrintersConfiguration [[-Domain] <String>] [[-DomainUtilsBase] <String>] [[-ContainerClass] <String>] [[-Server] <String>] [-Force] [-WhatIf] [-Confirm] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [Test-DomainUtilsPrintersConfiguration][]

Проверяем наличие конфигурации модуля для указанного домена.

	Test-DomainUtilsPrintersConfiguration [[-Domain] <String>] [[-Server] <String>] <CommonParameters>

### PrintQueue

#### КРАТКОЕ ОПИСАНИЕ [Get-PrintQueue][]

Возвращает одну или несколько локальных очередей печати.

	Get-PrintQueue [-PrintQueueTypes <EnumeratedPrintQueueTypes[]>] [-Properties <PrintQueueIndexedProperty[]>] <CommonParameters>

	Get-PrintQueue [-Name] <String> [-PrintQueueTypes <EnumeratedPrintQueueTypes[]>] [-Properties <PrintQueueIndexedProperty[]>] <CommonParameters>

#### КРАТКОЕ ОПИСАНИЕ [Test-PrintQueue][]

Проверяет наличие одной или нескольких локальных очередей печати.

	Test-PrintQueue [-Name] <String> <CommonParameters>

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

	Get-ADPrintQueue [-Filter <String>] [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

	Get-ADPrintQueue [-Identity] <ADObject> [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

	Get-ADPrintQueue -LDAPFilter <String> [-Properties <String[]>] [-ResultPageSize <Int32>] [-ResultSetSize <Int32>] [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

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
	, 'uNCName'
	, 'driverName'
	, 'driverVersion'
	, 'location'
	, 'portName'
	, 'printAttributes'
	, 'printBinNames'
	, 'printCollate'
	, 'printColor'
	, 'printDuplexSupported'
	, 'printFormName'
	, 'printKeepPrintedJobs'
	, 'printLanguage'
	, 'printMACAddress'
	, 'printNetworkAddress'
	, 'printMaxCopies'
	, 'printMaxResolutionSupported'
	, 'printMaxXExtent'
	, 'printMaxYExtent'
	, 'printMinXExtent'
	, 'printMinYExtent'
	, 'printMediaReady'
	, 'printMediaSupported'
	, 'printOrientationsSupported'
	, 'printPagesPerMinute'
	, 'printSpooling'
	, 'printStaplingSupported'
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

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-ADPrintQueue)
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

	Test-ADPrintQueue -Filter <String> [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

	Test-ADPrintQueue [-Identity] <ADObject> [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

	Test-ADPrintQueue -LDAPFilter <String> [-SearchBase <String>] [-SearchScope] [-Server <String>] <CommonParameters>

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

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-ADPrintQueue)
- [Get-ADPrintQueue][]

#### Remove-ADPrintQueueEnvironment

Удаляет группы безопасности и объект GPO для указанной
через InputObject очереди печати.

##### ПСЕВДОНИМЫ

Remove-ADPrinterEnvironment

##### СИНТАКСИС

	Remove-ADPrintQueueEnvironment [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] [-WhatIf] [-Confirm] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] Domain`
	домен
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

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

1. Удаляем группы безопасности и объекты GPO для всех
очередей печати.

		Get-ADPrintQueue | Remove-ADPrintQueueEnvironment -Verbose

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Remove-ADPrintQueueEnvironment)
- [Update-ADPrintQueueEnvironment][]
- [Get-ADPrintQueue][]

#### Update-ADPrintQueueEnvironment

Создаёт (при отсутствии) группы безопасности и объект GPO для указанной
через InputObject очереди печати.

##### ПСЕВДОНИМЫ

Update-ADPrinterEnvironment

##### СИНТАКСИС

	Update-ADPrintQueueEnvironment [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] [-DefaultPrinterSelectionMode <String>] [-Port <String>] [-AsPersistent] [-WhatIf] [-Confirm] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] Domain`
	домен
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] DefaultPrinterSelectionMode`
	Устанавливать ли принтер как принтер по умолчанию при отсутствии локальных принтеров
	* Тип: [System.String][]
	* Псевдонимы: Default
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `DefaultPrinterWhenNoLocalPrintersPresent`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Port`
	Ассоцирировать подключенный принтер с указанным портом
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[SwitchParameter] AsPersistent`
	Устанавливать ли подключение к принтеру как постоянное. В этом случае даже при невозможности применения групповых политик при загрузке
	принтер будет доступен пользователям. В противном случае принтер будет подключаться только после применения групповых политик и только в случае
	возможности применения групповых политик.
	

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

1. Создаём (при отсутствии) группы безопасности и объект GPO для всех
очередей печати

		Get-ADPrintQueue | Update-ADPrintQueueEnvironment -Verbose

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Update-ADPrintQueueEnvironment)
- [New-ADPrintQueueGPO][]
- [New-ADPrintQueueGroup][]
- [Get-ADPrintQueue][]

#### Get-ADPrintQueueGPO

Возвращает объект групповой политики, созданный для "подключения" членам
группы Пользователи принтера указанной
через InputObject очереди печати.

##### ПСЕВДОНИМЫ

Get-ADPrinterGPO

##### СИНТАКСИС

	Get-ADPrintQueueGPO [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].

##### ВЫХОДНЫЕ ДАННЫЕ

- Microsoft.GroupPolicy.Gpo
Возвращает объект групповой политики для указанной очереди печати
либо генерирует ошибку.

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] Domain`
	домен
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
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

1. Возвращает объект групповой политики для очереди печати 'prn001'.

		Get-ADPrintQueue -Filter {name -eq 'prn001'} | Get-ADPrintQueueGPO

2. Удаляем групповые политики для всех обнаруженных
очередей печати.

		Get-ADPrintQueue | Get-ADPrintQueueGPO | Remove-GPO -Verbose

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-ADPrintQueueGPO)
- [Get-ADPrintQueueGPO][]
- [Get-ADPrintQueue][]

#### New-ADPrintQueueGPO

[New-ADPrintQueueGPO][] создаёт объект групповой политики для "подключения" членам
группы Пользователи принтера указанной
через InputObject очереди печати.

##### ПСЕВДОНИМЫ

New-ADPrinterGPO

##### СИНТАКСИС

	New-ADPrintQueueGPO [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] [-Force] [-DefaultPrinterSelectionMode <String>] [-Port <String>] [-AsPersistent] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].

##### ВЫХОДНЫЕ ДАННЫЕ

- Microsoft.GroupPolicy.Gpo
Возвращает созданную групповую политику при выполнении с ключом PassThru.

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] Domain`
	домен
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[SwitchParameter] Force`
	Обновлять ли существующие объекты GPO
	

- `[String] DefaultPrinterSelectionMode`
	Устанавливать ли принтер как принтер по умолчанию при отсутствии локальных принтеров
	* Тип: [System.String][]
	* Псевдонимы: Default
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `DefaultPrinterWhenNoLocalPrintersPresent`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Port`
	Ассоцирировать подключенный принтер с указанным портом
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[SwitchParameter] AsPersistent`
	Устанавливать ли подключение к принтеру как постоянное. В этом случае даже при невозможности применения групповых политик при загрузке
	принтер будет доступен пользователям. В противном случае принтер будет подключаться только после применения групповых политик и только в случае
	возможности применения групповых политик.
	

- `[SwitchParameter] PassThru`
	Передавать ли созданные GPO далее по конвейеру
	

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

1. Создаёт объект групповой политики для очереди печати 'prn001'.

		Get-ADPrintQueue -Filter {name -eq 'prn001'} | New-ADPrintQueueGPO

2. Создаёт групповые политики для всех обнаруженных
очередей печати либо обновляет их (если GPO существуют).

		Get-ADPrintQueue | New-ADPrintQueueGPO -Force

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#New-ADPrintQueueGPO)
- [New-GPO][]
- [Get-ADPrintQueue][]

#### Test-ADPrintQueueGPO

Возвращает `$true` или `$false`, указывая наличие либо отсутствие объекта групповой политики для указанной
через InputObject очереди печати.

##### ПСЕВДОНИМЫ

Test-ADPrinterGPO

##### СИНТАКСИС

	Test-ADPrintQueueGPO [-InputObject] <ADObject> [-Domain <String>] [-Server <String>] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
ADObject класса printQueue, возвращаемый [Get-ADPrintQueue][].

##### ВЫХОДНЫЕ ДАННЫЕ

- Bool
Подтверждает или опровергает факт наличия объекта групповой политики для указанной очереди печати.

##### ПАРАМЕТРЫ

- `[ADObject] InputObject`
	идентификация объекта AD (см. [about_ActiveDirectory_Identity][])
	* Тип: [Microsoft.ActiveDirectory.Management.ADObject][]
	* Требуется? да
	* Позиция? 1
	* Принимать входные данные конвейера? true (ByValue)
	* Принимать подстановочные знаки? нет

- `[String] Domain`
	домен
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
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

1. Проверяем наличие GPO для очереди печати 'prn001'.

		Get-ADPrintQueue -Filter {name -eq 'prn001'} | Test-ADPrintQueueGPO

2. Создаём недостающие объекты политик.

		Get-ADPrintQueue | ? { -not ( $_ | Test-ADPrintQueueGPO ) } | New-ADPrintQueueGPO -Verbose

##### ПРИМЕЧАНИЯ

Этот командлет не работает со снимками Active Directory.

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-ADPrintQueueGPO)
- [Test-ADPrintQueueGPO][]
- [Get-ADPrintQueueGPO][]
- [Get-ADPrintQueue][]

#### Get-ADPrintQueueGroup

[Get-ADPrintQueueGroup][] возвращает группы безопасности
(Пользователи принтера, Операторы принтера) для указанного
через InputObject объекта printQueue.

##### ПСЕВДОНИМЫ

Get-ADPrinterGroup

##### СИНТАКСИС

	Get-ADPrintQueueGroup [-InputObject] <ADObject> [-GroupType <String[]>] [-Domain <String>] [-Server <String>] <CommonParameters>

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

- `[String] Domain`
	домен
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
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

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-ADPrintQueueGroup)
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

	New-ADPrintQueueGroup [-InputObject] <ADObject> [-GroupType <String[]>] [-Domain <String>] [-Server <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

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

- `[String] Domain`
	домен
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
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

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#New-ADPrintQueueGroup)
- [New-ADObject][]
- [New-ADGroup][]
- [Get-ADPrintQueue][]

#### Initialize-ADPrintQueuesEnvironment

Создаёт корневой контейнер для контейнеров объектов printQueue.
Данную функцию следует вызывать однократно для создания необходимых
контейнеров и объектов.

##### СИНТАКСИС

	Initialize-ADPrintQueuesEnvironment [[-Domain] <String>] [[-Server] <String>] [-PassThru] [-WhatIf] [-Confirm] <CommonParameters>

##### ВЫХОДНЫЕ ДАННЫЕ

- [Microsoft.ActiveDirectory.Management.ADObject][]
Возвращает корневой контейнер при ключе -PassThru.

##### ПАРАМЕТРЫ

- `[String] Domain`
	домен, в котором инициализируем окружение для очередей печати
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 1
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 2
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

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Initialize-ADPrintQueuesEnvironment)
- [Get-ADObject][]

#### Get-DomainUtilsPrintersConfiguration

Получаем объект, содержащий конфигурацию модуля для указанного домена.

##### СИНТАКСИС

	Get-DomainUtilsPrintersConfiguration [[-Domain] <String>] [[-Server] <String>] [-NoCache] <CommonParameters>

##### ПАРАМЕТРЫ

- `[String] Domain`
	домен, для которого запрашиваем конфигурацию модуля
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 1
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 2
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[SwitchParameter] NoCache`
	Игнорировать кеш и принудительно перечитать конфигурацию из AD
	

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Определяем класс контейнеров, используемых модулем для домена csm.nov.ru.

		( Get-DomainUtilsPrintersConfiguration -Domain 'csm.nov.ru' ).ContainerClass

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-DomainUtilsPrintersConfiguration)

#### Initialize-DomainUtilsPrintersConfiguration

Инициализирует конфигурацию модуля. Конфигурация модуля сохраняется в Active Directory, полный путь
для домена csm.nov.ru будет
`CN=ITG DomainUtils,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=csm,DC=nov,DC=ru`.

Конфигурация сохраняется в AD (и загружается из AD) по ряду причин. В частности, модуль поддерживает
локализацию и поддерживает различные классы контейнеров. Но с момента начала его применения всеми
администраторами домена должна использоваться одна и та же конфигурация модуля, в частности - типы
контейнеров, корневой контейнер для размещения создаваемых вспомогательных групп, и так далее.

В случае наличия конфигурации в AD её можно принудительно перезаписать, используя ключ `-Force`,
однако этот шаг не приведёт к фактическому изменению типов контейнеров, их местоположения,
аттрибутов созданных групп. Поэтому пользоваться этой возможностью следует с особой осторожностью.

##### СИНТАКСИС

	Initialize-DomainUtilsPrintersConfiguration [[-Domain] <String>] [[-DomainUtilsBase] <String>] [[-ContainerClass] <String>] [[-Server] <String>] [-Force] [-WhatIf] [-Confirm] <CommonParameters>

##### ПАРАМЕТРЫ

- `[String] Domain`
	Домен, для которого инициализируем конфигурацию модуля. Если не указан - домен пользователя, от имени которого запущен сценарий.
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 1
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] DomainUtilsBase`
	Путь (DN) к контейнеру AD, в котором расположены все контейнеры, используемые утилитами данного модуля.
	Указывается без DN домена.
	Например, для `CN=ITG,DC=csm,DC=nov,DC=ru` следует указать `CN=ITG`.
		По умолчанию в качестве корневого контейнера используется корневой контейнер домена.
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 2
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] ContainerClass`
	Класс контейнеров, используемых данным модулем
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 3
	* Значение по умолчанию `container`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory. Если не указан явно - используется эмулятор роли PDC в указанном домене.
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 4
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[SwitchParameter] Force`
	Перезаписывать ли конфигурацию в случае её наличия
	

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

1. Инициализируем конфигурацию модуля для домена пользователя, от имени которого выполнен командлет.

		Initialize-DomainUtilsPrintersConfiguration

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Initialize-DomainUtilsPrintersConfiguration)

#### Test-DomainUtilsPrintersConfiguration

Проверяем наличие конфигурации модуля для указанного домена.

##### СИНТАКСИС

	Test-DomainUtilsPrintersConfiguration [[-Domain] <String>] [[-Server] <String>] <CommonParameters>

##### ПАРАМЕТРЫ

- `[String] Domain`
	домен, для которого проверяем наличие конфигурации модуля
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 1
	* Значение по умолчанию `( ( Get-ADDomain ).DNSRoot )`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[String] Server`
	Контроллер домена Active Directory
	* Тип: [System.String][]
	* Требуется? нет
	* Позиция? 2
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Проверяем существование конфигурации для домена csm.nov.ru.

		Test-DomainUtilsPrintersConfiguration -Domain 'csm.nov.ru'

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-DomainUtilsPrintersConfiguration)

#### Get-PrintQueue

[Get-PrintQueue][] возвращает объект PrintQueue или выполняет поиск для выявления множества
объектов PrintQueue на локальном сервере печати.

##### ПСЕВДОНИМЫ

Get-Printer

##### СИНТАКСИС

	Get-PrintQueue [-PrintQueueTypes <EnumeratedPrintQueueTypes[]>] [-Properties <PrintQueueIndexedProperty[]>] <CommonParameters>

	Get-PrintQueue [-Name] <String> [-PrintQueueTypes <EnumeratedPrintQueueTypes[]>] [-Properties <PrintQueueIndexedProperty[]>] <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- System.Printing.PrintQueue
Очередь печати.
- [System.String][]
Имя (Name) очереди печати.

##### ВЫХОДНЫЕ ДАННЫЕ

- System.Printing.PrintQueue
Возвращает один или несколько объектов "принтеров" PrintQueue.

##### ПАРАМЕТРЫ

- `[String] Name`
	идентификация объекта PrintQueue - имя "принтера"
	* Тип: [System.String][]
	* Псевдонимы: Identity
	* Требуется? да
	* Позиция? 2
	* Принимать входные данные конвейера? true (ByValue, ByPropertyName)
	* Принимать подстановочные знаки? нет

- `[EnumeratedPrintQueueTypes[]] PrintQueueTypes`
	типы запрашиваемых очередей печати
	* Тип: System.Printing.EnumeratedPrintQueueTypes[]
	* Псевдонимы: Types
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `@(
	[System.Printing.EnumeratedPrintQueueTypes]::Local `
	)`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `[PrintQueueIndexedProperty[]] Properties`
	Перечень свойств объекта printQueue, значения которых необходимо запросить
	* Тип: System.Printing.PrintQueueIndexedProperty[]
	* Требуется? нет
	* Позиция? named
	* Значение по умолчанию `@(
	[System.Printing.PrintQueueIndexedProperty]::Name `
	, [System.Printing.PrintQueueIndexedProperty]::Comment `
	, [System.Printing.PrintQueueIndexedProperty]::Description `
	, [System.Printing.PrintQueueIndexedProperty]::Location `
	, [System.Printing.PrintQueueIndexedProperty]::HostingPrintServer `
	, [System.Printing.PrintQueueIndexedProperty]::ShareName `
	)`
	* Принимать входные данные конвейера? false
	* Принимать подстановочные знаки? нет

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Возвращает все **локальные** очереди печати.

		Get-PrintQueue -PrintQueueTypes Local

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Get-PrintQueue)
- System.Printing.LocalPrintServer

#### Test-PrintQueue

[Get-PrintQueue][] возвращает объект PrintQueue или выполняет поиск для выявления множества
объектов PrintQueue на локальном сервере печати.

##### ПСЕВДОНИМЫ

Test-Printer

##### СИНТАКСИС

	Test-PrintQueue [-Name] <String> <CommonParameters>

##### ВХОДНЫЕ ДАННЫЕ

- System.Printing.PrintQueue
Очередь печати.
- [System.String][]
Имя (Name) очереди печати.

##### ВЫХОДНЫЕ ДАННЫЕ

- System.Bool
Подтверждает наличие либо отсутствие указанной очереди печати на локальном сервере печати.

##### ПАРАМЕТРЫ

- `[String] Name`
	идентификация объекта PrintQueue - имя "принтера"
	* Тип: [System.String][]
	* Псевдонимы: Identity
	* Требуется? да
	* Позиция? 2
	* Принимать входные данные конвейера? true (ByValue, ByPropertyName)
	* Принимать подстановочные знаки? нет

- `<CommonParameters>`
	Этот командлет поддерживает общие параметры: Verbose, Debug,
	ErrorAction, ErrorVariable, WarningAction, WarningVariable,
	OutBuffer и OutVariable. Для получения дополнительных сведений см. раздел
	[about_CommonParameters][].


##### ПРИМЕРЫ

1. Проверяет наличие на локальном сервере печати очереди печати с именем P00001.

		Test-PrintQueue -Name 'P00001'

##### ССЫЛКИ ПО ТЕМЕ

- [Интернет версия](https://github.com/IT-Service/ITG.DomainUtils.Printers#Test-PrintQueue)
- System.Printing.LocalPrintServer


[about_ActiveDirectory_Filter]: http://technet.microsoft.com/library/hh531527.aspx 
[about_ActiveDirectory_Identity]: http://technet.microsoft.com/library/hh531526.aspx 
[about_CommonParameters]: http://go.microsoft.com/fwlink/?LinkID=113216 "Describes the parameters that can be used with any cmdlet."
[Get-ADGroup]: <http://go.microsoft.com/fwlink/?linkid=219302> "Gets one or more Active Directory groups."
[Get-ADObject]: <http://go.microsoft.com/fwlink/?linkid=219298> "Gets one or more Active Directory objects."
[Get-ADPrintQueue]: <#get-adprintqueue> "Возвращает один или несколько объектов AD с классом printQueue."
[Get-ADPrintQueueGPO]: <#get-adprintqueuegpo> "Возвращает объект групповой политики, применяемой к пользователям указанного объекта printQueue."
[Get-ADPrintQueueGroup]: <#get-adprintqueuegroup> "Возвращает затребованные группы безопасности для указанного объекта printQueue."
[Get-DomainUtilsPrintersConfiguration]: <#get-domainutilsprintersconfiguration> "Получаем объект, содержащий конфигурацию модуля для указанного домена."
[Get-PrintQueue]: <#get-printqueue> "Возвращает одну или несколько локальных очередей печати."
[Initialize-ADPrintQueuesEnvironment]: <#initialize-adprintqueuesenvironment> "Создаёт корневой контейнер для контейнеров объектов printQueue."
[Initialize-DomainUtilsPrintersConfiguration]: <#initialize-domainutilsprintersconfiguration> "Инициализация конфигурации модуля."
[Microsoft.ActiveDirectory.Management.ADGroup]: <http://msdn.microsoft.com/ru-ru/library/microsoft.activedirectory.management.adgroup.aspx> "ADGroup Class (Microsoft.ActiveDirectory.Management)"
[Microsoft.ActiveDirectory.Management.ADObject]: <http://msdn.microsoft.com/ru-ru/library/microsoft.activedirectory.management.adobject.aspx> "ADObject Class (Microsoft.ActiveDirectory.Management)"
[Microsoft.ActiveDirectory.Management.ADSearchScope]: <http://msdn.microsoft.com/ru-ru/library/microsoft.activedirectory.management.adsearchscope.aspx> "ADSearchScope Class (Microsoft.ActiveDirectory.Management)"
[New-ADGroup]: <http://go.microsoft.com/fwlink/?linkid=219326> "Creates an Active Directory group."
[New-ADObject]: <http://go.microsoft.com/fwlink/?linkid=219323> "Creates an Active Directory object."
[New-ADPrintQueueGPO]: <#new-adprintqueuegpo> "Создаёт групповую политику, применяемую к пользователям указанного объекта printQueue."
[New-ADPrintQueueGroup]: <#new-adprintqueuegroup> "Создаёт группы безопасности для указанного объекта printQueue."
[New-GPO]: <http://go.microsoft.com/fwlink/?linkid=216711> "Creates a new GPO."
[Remove-ADPrintQueueEnvironment]: <#remove-adprintqueueenvironment> "Удаляет группы безопасности и объект GPO для указанной очереди печати."
[System.Int32]: <http://msdn.microsoft.com/ru-ru/library/system.int32.aspx> "Int32 Class (System)"
[System.String]: <http://msdn.microsoft.com/ru-ru/library/system.string.aspx> "String Class (System)"
[Test-ADPrintQueue]: <#test-adprintqueue> "Определяет существует ли объект AD с классом printQueue с указанными фильтрами."
[Test-ADPrintQueueGPO]: <#test-adprintqueuegpo> "Проверяет наличие объекта групповой политики, применяемой к пользователям указанного объекта printQueue."
[Test-DomainUtilsPrintersConfiguration]: <#test-domainutilsprintersconfiguration> "Проверяем наличие конфигурации модуля для указанного домена."
[Test-PrintQueue]: <#test-printqueue> "Проверяет наличие одной или нескольких локальных очередей печати."
[Update-ADPrintQueueEnvironment]: <#update-adprintqueueenvironment> "Создаёт (при отсутствии) группы безопасности и объект GPO."

---------------------------------------

Генератор: [ITG.Readme](https://github.com/IT-Service/ITG.Readme "Модуль PowerShell для генерации readme для модулей PowerShell").

