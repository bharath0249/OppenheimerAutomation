*** Settings ***
Resource  common.robot



*** Keywords ***
Insert single record using API
   post on session  ${SESSION_NAME}  url=
