def switch_tab
    page.switch_to_window(page.windows[1])
end

def click_css(css_selector)
    find(:css, css_selector).click
end

def select_option(css_selector, value)
    find(:css, css_selector).find(:option, value).select_option
end