Vim�UnDo� ��DQ� �Dv�)�V}D�b=�W������6   �                                   b�9�     _�                              ����                                                                                                                                                                                                                                                                                                                                                             b�9�     �               �   import time   *from taf_core.robot_library import keyword   )from .splunk_api_helpers import SplunkApi   4from .splunk_selenium_locators import SPLNK_LOCATORS           &class TafTspSplunkKeywords(SplunkApi):       """   d    Keyword module documentation can be added here.  Set "use_documentation_in_taf_api = True" below   4    for this documentation to appear in the TAF API.       """       '    use_documentation_in_taf_api = True       0    def _set_configuration(self, configuration):           """   @        Sets the configuration for the Splunk API configuration.           """       /        self.url = self._get_url(configuration)   E        self.username, self.password = self._get_creds(configuration)   9        self.search_str = self._get_search(configuration)       &    def _get_url(self, configuration):   -        if "url" not in configuration.keys():               return None   #        return configuration['url']       (    def _get_creds(self, configuration):   \        if "username" not in configuration.keys() or "password" not in configuration.keys():   b            self.logger.exception('ERROR: No username or password provided for the Splunk server')   C        return configuration['username'], configuration['password']       )    def _get_search(self, configuration):   ,        if 'search' in configuration.keys():   *            return configuration['search']           return None       *    @keyword(name="SPLNK Hosts Reporting")   /    def hosts_reporting(self, **configuration):           """   R        Returns a list containing all of the names of hosts reporting into Splunk.       :        The ``url`` is the base url to the Splunk web app.   C        The ``username`` is the username needed to login to Splunk.   C        The ``password`` is the password needed to login to Splunk.   5        The ``search`` is the search-string to query.               Examples:   �        |   ${list_of_hosts}=   |   SPLUNK Host Names   |   url=${url}   |   username=${username}   |   password=${password}   |   search=${search}   |           """       .        self._set_configuration(configuration)       <        self.connect(self.url, self.username, self.password)   7        response = self.search('/services/search/jobs',   L                               f'{self.search_str} * | stats count by host')           self.disconnect()       *        hosts = response.json()['results']   s        logger_list = [f'"{host["host"].lower()}" has checked into Splunk {host["count"]} times' for host in hosts]   D        self.logger.info('\n'.join(str(log) for log in logger_list))   <        host_list = [host['host'].lower() for host in hosts]               return host_list            @keyword(name="SPLNK Login")   -    def splkweb_login(self, **configuration):           """   +        Logs into the Splunk web interface.       C        The ``username`` is the username needed to login to Splunk.   C        The ``password`` is the password needed to login to Splunk.               Examples:   S        |   SPLKWEB Login   |   username=${username}   |   password=${password}   |           """       .        self._set_configuration(configuration)       5        # Wait for the 'Username' field to be visible   j        username_field = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.login_username_xpath,   [                                                                      timeout_threshold=60,   o                                                                      msg="Couldn't find the 'username' field")   #        # Enter text into the field           username_field.click()           username_field.clear()   /        username_field.send_keys(self.username)       5        # Wait for the 'Password' field to be visible   j        password_field = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.login_password_xpath,   [                                                                      timeout_threshold=60,   o                                                                      msg="Couldn't find the 'password' field")   #        # Enter text into the field           password_field.click()           password_field.clear()   /        password_field.send_keys(self.password)       1        # Wait for 'Sign In' button to be visible   j        sign_in_button = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.sign_in_button_xpath,   [                                                                      timeout_threshold=60,   m                                                                      msg="Couldn't find the 'Login' button")           sign_in_button.click()       W        # Conditional logic for the modal boxes that Splunk displays when first visited   g        modal_window = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.welcome_modal_xpath,   Y                                                                    timeout_threshold=60,   X                                                                    interaction_delay=5,   j                                                                    msg="Couldn't find the welcome modal")       C        if modal_window.value_of_css_property('display') != 'none':   )            print('Got It button exists')   r            got_it_button = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.modal_got_it_button_xpath,   ]                                                                        timeout_threshold=60,   ]                                                                        interaction_delay=5,    w                                                                        msg="Couldn't find the 'Got it!' modal button")   !            got_it_button.click()       m        if self.selenium_keywords.element_exists_by_xpath(SPLNK_LOCATORS.modal_dont_show_again_button_xpath):   9            print('Don\'t show this again button exists')   �            dont_show_again_button = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.modal_dont_show_again_button_xpath,   f                                                                                  interaction_delay=5,   g                                                                                  timeout_threshold=60,   �                                                                                  msg="Couldn't find the 'Don't show me this again' button")   *            dont_show_again_button.click()       6    @keyword(name="SPLNK Get Hosts From Data Summary")   2    def splkweb_get_hosts_from_data_summary(self):           """   h        Navigates to the Data Summary modal window that displays all of the hosts reporting into Splunk.           """       @        # Wait for the 'Search & Reporting' button to be visible   �        search_and_reporting_button = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.search_and_reporting_button_xpath,   h                                                                                   timeout_threshold=60,   g                                                                                   interaction_delay=5,   �                                                                                   msg="Couldn't find the 'Search & Reporting' button")   +        search_and_reporting_button.click()       W        # Conditional logic for the modal boxes that Splunk displays when first visited           time.sleep(5)   i        modal_window = self.selenium_keywords.element_exists_by_xpath(SPLNK_LOCATORS.welcome_admin_xpath)               if modal_window:   k            modal_window = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.welcome_admin_xpath,   ]                                                                        timeout_threshold=60,   \                                                                        interaction_delay=5,   v                                                                        msg="Couldn't find the 'Welcome Admin' modal")       G            if modal_window.value_of_css_property('display') != 'none':   +                print('Skip button exists')   r                skip_button = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.modal_skip_button_xpath,   `                                                                           timeout_threshold=60,   _                                                                           interaction_delay=5,   w                                                                           msg="Couldn't find the 'Skip' modal button")   #                skip_button.click()       :        # Wait for the 'Data Summary' button to be visible   t        data_summary_button = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.data_summary_button_xpath,   `                                                                           timeout_threshold=60,   _                                                                           interaction_delay=5,   y                                                                           msg="Couldn't find the 'Data Summary' button")   #        data_summary_button.click()       0        # Wait for the 'Hosts' tab to be visible   `        hosts_tab = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.hosts_tab_xpath,   U                                                                 interaction_delay=5,   V                                                                 timeout_threshold=60,   e                                                                 msg="Couldn't find the 'Hosts' tab")           hosts_tab.click()       9        # Wait for the 'Last Update' filter to be visible   q        last_update_filter = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.hosts_last_update_xpath,   _                                                                          timeout_threshold=60,   ^                                                                          interaction_delay=5,   w                                                                          msg="Couldn't find the 'Last Update' filter")   "        last_update_filter.click()       7    @keyword(name="SPLNK Get VM Updating Past 4 Hours")   6    def splkweb_get_vm_updating_past_four_hours(self):           """   q        Navigates to a random VM from the Data Summary modal window and filters its activity by the last 4 hours.           """              W        # Starts from where the "splkweb_get_hosts_from_data_summary" function left off   2        self.splkweb_get_hosts_from_data_summary()          +        # Wait for a random host to display   d        random_host = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.random_host_xpath,   X                                                                   timeout_threshold=60,   W                                                                   interaction_delay=5,   h                                                                   msg="Couldn't find a host to select")           random_host.click()       2        # Wait for the timerange filter to display   n        timerange_filter = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.timerange_filter_xpath,   \                                                                        interaction_delay=5,   ]                                                                        timeout_threshold=60,   q                                                                        msg="Couldn't find the timerange filter")            timerange_filter.click()       7        # Wait for the 'Last 4 hours' option to display   z        last_four_hours_filter = self.selenium_keywords.wait_element_by_xpath(SPLNK_LOCATORS.last_four_hours_filter_xpath,   c                                                                              timeout_threshold=60,   b                                                                              interaction_delay=5,   |                                                                              msg="Couldn't find the 'Last 4 hours' option")   &        last_four_hours_filter.click()5�5��