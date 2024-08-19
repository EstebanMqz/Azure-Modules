<div style="display: flex; align-items: center; justify-content: center;">
  <h1 style="text-align: center; margin-right: 30px;">Azure-Modules</h1>
  <a href="https://azure.microsoft.com/en-us/">
    <img width="50px" src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Microsoft_Azure.svg" alt="Azure">
  </a>
</div>
<div style="background-color: #0000FF; height: 3px;"></div><br><br>
  
<div style="text-align: center; padding: 10px; background-color: rgba(128, 128, 128, 0.1); font-size: 25px;">
<Details open>
<Summary> <b>Business Inquiries:</b> </Summary>

[<img width="40px" src="https://avatars.githubusercontent.com/u/61430243?s=400&u=147df399bfdec49914850b54cec7c4621e7461c5&v=4">](https://estebanmqz.github.io/EstebanMqz/index.html)
[<img width="40px" src="https://img.icons8.com/?size=512&id=MR3dZdlA53te&format=png">](https://www.linkedin.com/in/estebanmqz/)
[<img width="36px" height="36px" src="https://cdn.worldvectorlogo.com/logos/whatsapp-business-bg.svg" alt="Business">](https://tinyurl.com/BusinessNo)
<a href="https://mail.google.com/mail/?view=cm&fs=1&to=emarquez1895@gmail.com" target="Greetings Esteban I reviewed your work, skills and experience and I wish to schedule a Business Meeting with you." style="text-decoration: none;"><img width="45px" height="45px" style="max-width: 100%; max-height: 100%; margin-bottom: -3px" src="https://www.svgrepo.com/show/530453/mail-reception.svg" alt="Mail">
[<img width="40px" src="https://cdn3d.iconscout.com/3d/free/thumb/free-github-6343501-5220956.png?f=webp">](https://github.com/EstebanMqz?tab=repositories)
[<img width="40px" src="https://img.icons8.com/color/452/gitlab.png">](https://gitlab.com/EstebanMqz)
</Details>
</div></div>

To make sure the Azure beginner's credentials are accomplished &nbsp;
<a href="https://learn.microsoft.com/en-us/credentials/browse/?products=azure&levels=beginner">
<img style="margin-bottom: -5px" width="30px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Logo_windows_simples.svg/2280px-Logo_windows_simples.svg.png?f=webp"></a>
<br><br>

<div align="center" style="font-size: 16px; background: radial-gradient(circle, rgba(0,0,0,0.1), rgba(0,0,0,0.5)); padding: 20px; border-radius: 10px;">
<b>Azure Modules, their cmdlets & their detailed descriptions will be obtained<br>
so we understand Azure's core concepts, services & how to manage them.</b>
</div><br>

<i>The [PS Gallery](https://www.powershellgallery.com/) is the official repository of [PowerShell](https://github.com/PowerShell/PowerShell) modules and as it's the most popular it is officially maintained by [Microsoft](www.microsoft.com), nevertheless, there are other repositories where you can find PowerShell modules.
[Azure](https://portal.azure.com/#allservices/category/All) modules tend to be installed in the [PS Gallery](www.powershellgallery.com) so, while there are 13k+ modules, the following line counts all the [Azure](https://portal.azure.com/#allservices/category/All) modules in the [PS Gallery](www.powershellgallery.com), each with their unique set of [cmdlets](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/cmdlet-overview?view=powershell-7.1) which are the commands you can use in your PowerShell scripts once the Azure module is installed.</i>

```powershell
(Find-Module -Name *Azure* -Repository PSGallery | Measure-Object).Count
# 528 (Azure Modules)
Find-Module -Name *Azure* -Repository PSGallery
# 4.6.1      Azure.Storage                       PSGallery            Microsoft Azure PowerShell - Storage service cmd...
# 5.8.4      AzureRM.profile                     PSGallery            Microsoft Azure PowerShell - Profile credential ...
# 0.5.4      Azure.AnalysisServices              PSGallery            Microsoft Azure PowerShell - Analysis Services s...
# 5.3.1      Azure                               PSGallery            Microsoft Azure PowerShell - Service Management...
```
Before installing Azure modules we must know that PowerShell PATHs are shared so any of the modules will be available in any [PowerShell](https://github.com/PowerShell/PowerShell) .exe or terminal. 

```powershell
# Shared PS Modules paths
$ModulePaths = $env:PSModulePath -split ';' ; Write-Output $ModulePaths
#e.g. 
# C:\Users\Esteban\Documents\WindowsPowerShell\Modules
# C:\Program Files\WindowsPowerShell\Modules
# C:\WINDOWS\system32\WindowsPowerShell\v1.0\Modules
# c:\Users\Esteban\.vscode\extensions\ms-vscode.powershell-2024.2.2\modules
```

Now, with [![Azure](https://img.shields.io/badge/-Azure-0078D4?&logo=azure&logoColor=blue&labelColor=white)](https://github.com/EstebanMqz/Azure-Modules/tree/main/.ps1/Modules_cmdlets.ps1)
 we can make a list of all the modules installed in the PATHs & the cmdlets available in each one of them.<br>
They are contained in [`ModulesAndCommands.csv`](github.com/EstebanMqz/Azure-Modules/.csv/ModulesAndCommands.csv).
Now, we can proceed to describe all [Azure](https://portal.azure.com/#allservices/category/All) modules & their cmdlets and describe them with [PowerShell](https://github.com/PowerShell/PowerShell) or Unix-like terminals like [Git Bash](https://git-scm.com/downloads) from the web directly from the [PS Gallery](https://www.powershellgallery.com/).<br>

+ [Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/new-azureps-module-az?view=azps-7.1.0) is the most straightforward method for managing [Azure](https://portal.azure.com/#allservices/category/All) resources using [PowerShell](https://github.com/PowerShell/PowerShell).<br>
+ [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest) can be seamlessly integrated into [PowerShell](https://github.com/PowerShell/PowerShell), allowing users to utilize both command sets.<br>
+ [Azure SDK](https://github.com/Azure/azure-sdk) modules, cmdlets & commands can be accessed from [Powershell SDK Modules](https://www.powershellgallery.com/profiles/azure-sdk) and they are made specially for Azure developers providing greater capabilities than the user-friendly Portal, which might be faster if our setup isn't designed to code every functionality of Azure without remembering it all to detail.<br> 
While it isn't directly related to [Azure](https://portal.azure.com/#allservices/category/All), [NirCmd](https://www.nirsoft.net) is a command-line utility that performs a variety of tasks in Windows such as updating the [Registries](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/reg), write values into [INI]() files, and more. It
 files related to JSON, XML and Registries files (older versions of Windows) but it can be used for automation in Windows for older types of files such as: 
  + <h3> Registry Editor <a href="https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/reg">
    <img style="margin-bottom: -5px" width="40px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/3/33/Registry.svg/1920px-Registry.svg.png">
  </a></h3>
  + <h3>Extensible Markup Language (XML) <a href="https://developer.mozilla.org/en-US/docs/Web/XML/XML_introduction"><img style="margin-bottom: -10px" width="40px" src="https://www.svgrepo.com/show/354054/mdn.svg">
  </a></h3>
  + <h3>JavaScript Object Notation (JSON) <a href="https://www.json.org/json-en.html">
    <img style="margin-bottom: -10px" width="40px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/JSON_vector_logo.svg/1200px-JSON_vector_logo.svg.png">
  </a></h3>
</div>

For .[`ModulesAndCommands.csv`](github.com/EstebanMqz/Azure-Modules/.csv/ModulesAndCommands.csv) the module [DataGrid](github.com/EstebanMqz/Azure-Modules/libs/DataGrid-0.3.5) refs. 
``` sh
# Collecting wheel unpacked.
sudo python3 -m pip install wheel   
# Updating pkg manager.
sudo apt-get update
# Installing wheel.whl
sudo python3 -m pip install wheel
# Extracting wheel docs
wheel unpack DataGrid-0.3.5-py3-none-any.whl
# DataGrid-0.35.0
```
Unpacking the [repository](https://github.com/RedVentures/DataGrid) files.



 