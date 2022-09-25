from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.firefox import GeckoDriverManager

def get_driver_path_with_browser(browser):
    if browser.lower() == 'chrome':
        driver_path = ChromeDriverManager().install()
    elif browser.lower() == 'firefox':
        driver_path = GeckoDriverManager().install()
    print(driver_path)
    return driver_path