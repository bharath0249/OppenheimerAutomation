# Oppenheimer Automation

# Prerequisites
_Install Python 3.9 or above_

_Install pip3_

_Install PyCharm Community edition IDE(https://www.jetbrains.com/pycharm/download/#section=mac)_

# Framework Setup

_Clone framework from git hub (https://github.com/bharath0249/OppenheimerAutomation.git)_

_Select Virtual Environment interpreter in Pycharm(You can see option in bottom right corner of Pycharm)_

_Execute below command in terminal to install required dependencies_

`pip install -r requirements.txt`

_Validate installation by running below command_

`robot --version`

# Test Execution

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

# Note: 
No need of installing any browser drivers like chrome driver or gecko drivers as it is handled by WebDrivermanager Class

# Folders

Execution status and failure reasons can be seen by opening file `RegressionResults.pdf`

Test cases are also uploaded to Test Rail can be found at URL https://oppenheimerdemo.testrail.io/index.php?/runs/view/1&group_by=cases:section_id&group_order=asc 
You can send your mail ID to me so that I can add you to Test Rail to view test cases and execution status.

Test Data like json request bodies and csv file can be found under folder
`inputData`

Python code to instantiate and manage drivers can be found under folder
`lib`

Property files and page object web elements are present under folder
`mappings`

Robot Keywords and implementation of business logic for Test cases are present under folder
`resources`

Test Cases, Test Set UpTear downs are present under folder
`suites`

# Load Test
A basic load testing script for testing REST APIs is added (We can customise later based on requirements) at location
`loadTest/oppenheimerLoadTest.scala`

To Execute load test Download gatling from below URL:
https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/3.8.0/gatling-charts-highcharts-bundle-3.8.0-bundle.zip 

Extract the files

Place our oppenheimerLoadTest.scala file under folder user-files/simulations in gatling

Execute below command
`JAVA_OPTS="-DbaseUrl=${BASEURL} -DendPoint=${ENDPOINT} -DnumUsers=${NUMBER_OF_PARALLEL_USERS} -Xmx50000M" ./bin/gatling.sh -s biz.oppenheimer.OppenheimerLoadTest`

Example: `JAVA_OPTS="-DbaseUrl=http://localhost:8080 -DendPoint=/calculator/taxRelief -DnumUsers=100 -Xmx50000M" ./bin/gatling.sh -s biz.oppenheimer.OppenheimerLoadTest`

Sample results can be seen under folder `loadTest/getTaxReliefLoadTestRsults`
