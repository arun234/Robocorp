*** Settings ***
Library           RPA.Browser.Selenium
Library           RPA.Excel.Files
Library           RPA.HTTP

*** Variables ***
${URL}            https://rpachallenge.com/
${DOWNLOAD_URL}   https://rpachallenge.com/assets/downloadFiles/challenge.xlsx
${EXCEL_PATH}     challenge.xlsx
${EXCEL_SHEET}    Sheet1

*** Keywords ***
Open The Website
    [Documentation]    Opens the RPA Challenge website
    Open Available Browser    ${URL}

Download The Excel File
    [Documentation]    Downloads the Excel file for the challenge    
    Http Get    ${DOWNLOAD_URL}    ${EXCEL_PATH}

Fill The Form
    [Arguments]    ${row}
    Input Text    //input[@ng-reflect-name='labelFirstName']    ${row['First Name']}
    Input Text    //input[@ng-reflect-name='labelLastName']    ${row['Last Name']}
    Input Text    //input[@ng-reflect-name='labelCompanyName']    ${row['Company Name']}
    Input Text    //input[@ng-reflect-name='labelRole']    ${row['Role in Company']}
    Input Text    //input[@ng-reflect-name='labelAddress']    ${row['Address']}
    Input Text    //input[@ng-reflect-name='labelEmail']    ${row['Email']}
    Input Text    //input[@ng-reflect-name='labelPhone']    ${row['Phone Number']}
    Click Button    //input[@type='submit']

Process Excel File
    [Documentation]    Processes each row in the Excel file to fill the form
    Open The Website
    Open Workbook    ${EXCEL_PATH}
    ${rows}=    Read Worksheet As Table    header=${TRUE}
    FOR    ${row}    IN    @{rows}
        Fill The Form    ${row}
        Sleep    1s
        
    END
    Close Workbook

*** Tasks ***
Complete RPA Challenge
    Download The Excel File
    # Process Excel File

# *** Test Cases ***
# RPA Challenge Test
#     Complete RPA Challenge

*** Comments ***
# This script follows the structure provided for the RPA Challenge website.
# It opens the website, downloads the Excel file, processes each row, and fills the form accordingly.
# Adjust the Excel download URL and the element locators if needed.
