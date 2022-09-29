# Oppenheimer Automation

# Prerequisites
_Install Python 3.9 or above_

_Install pip3_

_Install PyCharm Community edition IDE(https://www.jetbrains.com/pycharm/download/#section=mac)_

#Framework Setup

_Clone framework from git hub (https://github.com/bharath0249/OppenheimerAutomation.git)_

_Select Virtual Environment interpreter in Pycharm(You can see option in bottom right corner of Pycharm)_

_Execute below command in terminal to install required dependencies_

`pip install -r requirements.txt`

_Validate installation by running below command_

`robot --version`

#Test Execution

_You can use below command to execute test cases_

All Tests:
`robot suites/*`

Specific User Story: `robot -i US${number} suites/*` Example: `robot -i US1 suites/*`

Command to change server and port (default are localhost and 8080):
`robot --variable SERVER:${SERVER_NAME} --variable PORT:${PORT_NUMBER} suites/*` Example: `robot --variable SERVER:oppenheimer --variable PORT:9090 suites/*`

Command to change browser (Chrome and firefox are supported currently):
`robot --variable BROWSER:${BROWSER_NAME} suites/*` Example: `robot --variable BROWSER:chrome suittes/*`

Command to run Smoke Tests only:
`robot -i SMOKE suites/*`

#Note: 
No need of installing any browser drivers like chrome driver or gecko drivers as it is handled by WebDrivermanager Class

