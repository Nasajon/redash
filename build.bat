@SET PYTHONPATH=%CD%
@SET PARAMS=-y --clean^
 --onefile^
 -p %PYTHONPATH%^
 --name "nsDash"^
 --add-data "client;client"^
 --add-data "redis-server.exe;."^
 --additional-hooks-dir "."^
 --icon nsDash.ico^
 --hidden-import "pkg_resources.py2_warn"^
 --hidden-import "sqlalchemy.ext.baked"^
 --distpath "%NSBIN%"^
 --workpath "%NSDCU%"
@SET PARAMS2=-y --clean^
 --onefile^
 -p %PYTHONPATH%^
 --name "nsDashCreateUser"^
 --additional-hooks-dir "."^
 --icon nsDash.ico^
 --hidden-import "pkg_resources.py2_warn"^
 --hidden-import "sqlalchemy.ext.baked"^
 --distpath "%NSBIN%"^
 --workpath "%NSDCU%"

@SET NPM="C:\Program Files\nodejs\npm"             
@IF DEFINED JENKINS_HOME (
	@SET PARAMS=%PARAMS% --version-file "%WORKSPACE%\output\VersionInfo2"
)

@IF EXIST venv (
  @CALL @%CD%\venv\Scripts\deactivate.bat
)

@ECHO ##### Criando o ambiente virtual #####

@python -m venv --clear venv

@ECHO ##### Compilando o projeto #####

@CMD "/c @%CD%\venv\Scripts\activate.bat && @pip install -r requirements.txt && @pyinstaller %PARAMS% main.py && @pyinstaller %PARAMS2% create_user.py && @%CD%\venv\Scripts\deactivate.bat"