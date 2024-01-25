function __init__()

py"""
from time import sleep
import traceback
from playwright.sync_api import sync_playwright

def py_sm(a,b):
    return a + b

def py_playwright_get_summary(UPK_PW,UPK_URL,UPK_USER):
    txt = "Up0Down999Maintenance0Unknown0Pause0"
    with sync_playwright() as p:
        #for browser_type in [p.chromium, p.firefox, p.webkit]:
        #for browser_type in [p.chromium]:
        browser_type = p.chromium
        browser = browser_type.launch()
        page = browser.new_page()
        page.goto(UPK_URL)
        #page.screenshot(path=f'c:/temp/example00-{browser_type.name}.png')

        page.get_by_label("Username").fill(UPK_USER)
        page.get_by_label("Password").fill(UPK_PW)
        page.get_by_role("button" ).click()
        sleep(3)
        
        #page.screenshot(path=f'c:/temp/example01-{browser_type.name}.png')        
        
        #print(page.get_by_text('Quick Stats').text_content())
        #print("ab")

        txt = page.locator("#app > div > main > div > div > div.col-12.col-md-7.col-xl-8.mb-3 > div > div.shadow-box.big-padding.text-center.mb-4 > div").text_content()
        #print(txt)

        #finish
        browser.close()
    return txt

#abc = py_playwright_get_summary(UPK_PW,UPK_URL,UPK_USER)
#print(abc)

"""

end #__init__ function 
