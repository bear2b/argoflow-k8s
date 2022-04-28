# Argoflow platform Change Log

---

## [2.13](https://github.com/bear2b/argoflow-k8s/releases/tag/2.13)

### Migration notes

Please follow instructions in [Migrate to 2.13](migration/2.13/Migrate%20to%202.13.md)

### API:
#### Added
- WAPI-584: Error of duplication users to BEAR
- BAPI-1621: NewRelic monitoring
- WAPI-578: Added Google Tag Manager parameters
- WAPI-547: Add error code to errors
- WAPI-382: Keep Batches in database
- WAPI-532: New parameter config.is_web_ar_enabled in AR project object
- ISETO-78: Added asset name column to asset stats
- WAPI-558: Raw stats calls + implementing jobs and queues
- WAPI-538: Delete documents along with SLs/Projects
- WAPI-564: Add an ability to get projectId in GET a SL call
- WAPI-569: Add ability to group stats result by week, month, year (not only day)
- ISETO-85: Security of Base PDF + SL
- WAPI-469: Allow image to be upload for Augmented PDF
#### Fixed
- WAPI-581: Views by date and Viewing time by date stats appears only on the next day
- ISETO-83: Error by filtering fields of SL project result
- WAPI-575: Remove accents from symbols
#### Changed
- WAPI-252: Some stats column names were updated
- WAPI-531: Generate AR project subdomain without timestamp if available
- WAPI-572: Added header to Base64 content

### Reader / Smartlink Creator:
#### Added
- WAPI-382: Keep Batches in database
- WAPI-564: Added a link to new UI in email templates
- WAPI-520: Added Swagger
- WAPI-566: Added an ability to create SL "on fly": without using DB and storage
#### Fixed
- ISETO-76: Fix print tracking on Firefox
- WAPI-559: Separate stats for generated smartlinks by batch
- WAPI-560: Fix of GA counter in SLs created by batch mode
#### Changed
- WAPI-252: Some stats column names were updated
- WAPI-572: Added header to Base64 favicon content

### Manager:
#### Added
- AM-300: reduced tab bar to fit a line + added tag carousel
- AM-303: added ownership email in project-overview-info
- AM-331: added ability to search tags from start letter
- AM-339: add tooltip for input custom splash screen subdomain
- AM-337: added condition to not show duplicate button for AR project 
- AM-68: add possibility to pass bapi token to medialib link
- AM-302: add ability to reset search parameters
- AM-277: add ability to clear dates in project details diffusion settings
- AM-298: add Google Tag Manager configuration
- ISETO-77: Allow to set specific favicon for organization and/or project
- AM-193 Improved project menu tab bar
- AM-226: Add ability to download raw project statistics
- AM-145: Reimplement custom splashscreen for web AR
- AM-285: implement redirect ability to exact page after login
- AM-137: Add warning modal when leaving not saved project
- AM-147: Open tags dropdown by click (after choosing of any tag)
- AM-35: Add ability to modify avatar
- AM-256: Display the name of your organization in left bar
- AM-235: Allow superadmin to connect as specific organization
#### Fixed
- AM-331: fixed ui not shows new searched values 
- AM-309: fixed possibility to not update favicon if it not changed
- AM-312: reimplemented filter behavior for filter menu to get ability to show picked option
- AM-306: added tooltip locales for AR icons
- AM-305: fix invalid date in charts
- AM-312: fix search projects after reload of page
- AM-248: moved tabs on statistic page, changed webAR icon
- AM-297: fixed disabled behavior of Project search: "Filter by" until page fully loaded  
- AM-258: fixed stats charts view.
- AM-261: add storage listener to avoid errors if you clear local storage data
- AM-271: Added selected project type to saved search
- AM-264: fix size of svg QR code
- AM-254: fixed getting text search results from word beginning
- AM-284: fix save organization setting if specific favicon was added
- ISETO-77: fix a bug which blocked the saving after updating favicon
- AM-230: fix some text colors and bg color in dark mode (text was not visible)
- AM-120: Fix some AR settings
#### Changed
- AM-317: improved test preview window, increased size, changed style of buttons
- AM-340: renamed custom url field in webar diffusion settings
- AM-301: changed ability to search projects from start letter
- AM-342: move webAR settings into webAR design tab
- AM-192: now have infinite scroll in projects list page
- AM-315: fix project default sort option
- AM-270: rewramp authentication architecture to improve UI reactivity
- AM-272: Change option management for WebAR
- AM-203: Keep page number When going back to the project list after clicking on a project
- AM-266: Update the way we include Google Tag Manager

### Editor:
#### Added
- ACM-457: There is no "Key-kolor" block for video assets
#### Fixed
#### Changed
- AE-207: Change "video on texture" behavior

## [2.12](https://github.com/bear2b/argoflow-k8s/releases/tag/2.12)

### API:
#### Added
- ISETO-74: An ability to load custom favicon for organization's Smartlinks
- WAPI-533: Added `is_featured` parameter in `config` object for AR projects
- WAPI-534: Display assets even if they have no stats
#### Fixed
- WAPI-546: It's not possible to enable AR option over `PATCH` method
- WAPI-489: Fix project duplication issues
#### Changed
- WAPI-544: `__or` operator instead of `__find_any_of_fields` parameter in `GET ../all` endpoints
- WAPI-551: WebAR settings will be displayed/saved in the 2nd version
- WAPI-523: `dataId` property in projects always has the `string` type
- WAPI-537: Let work without BEAR token if AR feature is disabled for organization

### Reader / Smartlink Creator:
#### Added
- ISETO-74: Ability to load custom favicon for organization's Smartlinks
#### Fixed
- WR-189: 2D Slider doesn't work for Safari
- WR-140: Fix problem when no background set for asset
- ISETO-69: Vulnerability issues step 2
#### Changed
- ISETO-72: Don't change mouse hover cursor if asset has no actions

### Manager:
#### Added
- AM-186: Create organization's settings
- AM-210: Allow to download project QR code for web AR projects
- AM-162: Add ability to add/remove pages to AR projects
- AM-148: Hide previous search results when starting a new search
#### Fixed
- AM-212: Assets statistics review
- AM-197: Fix editor link for SL projects
- AM-234: Update organization SL permission list
- AM-223: Remove language settings for SL projects
- AM-169: Block web AR settings if organization doesn't have web AR permissions
- AM-232: Fix problem with dropdowns selector & project lock
- ISETO-54: Fix share modal from project tile
- ISETO-62: Fix vulnerability issues
- AM-141: Hide stats email option for non-owners
- AM-243: Fix UI of assets stats when project have no stats
- AM-129: "summary" and "your project visitors" were not updated when date parameter was changed.
- AM-244: Fix UI of "add pages" button
#### Changed
- AM-208: Improve project subdomain feedback messages & add subdomain validation
- AM-239: Use Mb unit for storage values
- AM-116: Make duplicated project unpublished by default
- AM-220: Set default data period for the past month on statistics page
- AM-233: Update FAQ link & update some texts of the dashboard
- AM-200: Update left bar icons
- AM-135: Refresh search results when pasting tag in tag list
- AM-247: Improve tag search. Make it much faster.
- AM-219: Split stats datepicker into 2 date pickers to make it more user friendly
- AM-255: Better handling of API error messages for user creation
- AM-259: Unify tag lists behavior in the whole application

### Editor:
#### Added
- AE-337: Inform about glb support when uploading a glb model
- ISETO-50: Solve HTTPS issue
- AE-335: Convert 3D files into .glb within editor
- AE-335: Conversion error for zips with unknown model
#### Fixed
- WR-180: Fix 2D slider assets
- AE-360: Avoid resaving unmodified slider images
- AE-370: Fixed default icon issue with api v2 caused by AE-339
- WR-189: 2D Slider doesn't work for Safari
#### Changed
- AE-353: Better error handling for GLB conversion
- AE-335: Refresh glb conversion notice when file loaded