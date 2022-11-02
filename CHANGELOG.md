# Argoflow platform Change Log

---

## [2.15](https://github.com/bear2b/argoflow-k8s/releases/tag/2.15)

### Migration notes

Please follow instructions in [Migrate to 2.15](migration/2.15/Migrate%20to%202.15.md)

### API:
#### Added

#### Fixed

#### Changed


### Reader / Smartlink Creator:
#### Added

#### Fixed

#### Changed


### Manager:
#### Added

#### Fixed

#### Changed


### Editor:
#### Added

#### Fixed

#### Changed


## [2.14](https://github.com/bear2b/argoflow-k8s/releases/tag/2.14)

### Migration notes

Please follow instructions in [Migrate to 2.14](migration/2.14/Migrate%20to%202.14.md)

### API:
#### Added
- WAPI-657: Add ability to not Inherit limits from the parent organization
- WAPI-659: Link AF user to BEAR one if it was not linked before after update
- WAPI-610: Add 'visitor' parameter for stat calls
- WAPI-634: Let provide ttl in POST /token call
- WAPI-642: Ability to prevent entity's files deletion
- WAPI-640: Let Account Manager create Subclients and manage Clients’ and Subclients’ Projects
- WAPI-633: Create a stats call /top-projects 
- WAPI-632: Add view property to get projects call
- WAPI-616: An ability to create subclients for admins
- WAPI-618: Added an account manager role
- WAPI-620: Add an ability to get max or min value of user's property
- WAPI-604: An ability to set strategy for smartlink in POST/PUT/PATCH projects/sl calls
- WAPI-602: [Interaction Engine] Create a storage to keep JSON schemes for IE objects validation
- BAPI-1658: An ability to sort projects by a position of filter value occurrence in the name
- WAPI-593: When deleting a user, add ability to reassign projects to another user
- WAPI-594: Improve "tracking_email" parameter
- WAPI-592: Add 'document_file' parameter to project sl PATCH route

#### Fixed
- WAPI-665: Error when you try to delete PDF organization in the environment where BEAR API is disabled
- WAPI-649: Cannot PATCH subclient PDF Project as Admin, got error
- WAPI-656: Wrong limits of the linked BEAR clents fix
- WAPI-651: Allow to set custom features to sub clients
- WAPI-637: Quota amount issue (sync with old api)
- WAPI-631: New owner(user) of private project doesn’t see it in the list of projects
- ISETO-105: Assets stats page number fix
- WAPI-601: Project duplication error
- WAPI-613: Cannot create User on PDF organization

#### Changed
- ISETO-106: [clicked] property in the response of assets stats endpoint shows amount of click [events] instead of [open] events now
- WAPI-618: The is_admin parameter is deprecated. We have role_id now

### Reader / Smartlink Creator:
#### Added
- WAPI-604: An ability to get strategy from Smartlink's parameters for simple SL creation
- WAPI-594: Improve "tracking_email" parameter

#### Fixed

#### Changed

### Manager:
#### Added
- AM-493: Introduction of "Account manager" user role
- AM-350: Added new dashboard with widgets & two tabs: AR & PDF
- AM-351: Implemented reset-password/set-new-password page
- AM-318: New column 'views' for project tab overview
- AM-411: Add size checker for project uploading
- AM-341: Add specific tags in ARGO webAR standard URL for general settings
- AM-466: Disable "webAR" settings & custom landing page when no project URL is selected for the project
- AM-471: Add possibility to switch between sub-organization for admin of the parent organization
- AM-475: Implement multi-organization & sub-organization
- AM-464: Split projects list in two tabs: AR & PDF
- AM-318: Add columns "owner" & "views" in projects list
- AM-354: Implement csv-zip import
- AM-293: Add possibility to process pdf in background for big files
- AM-343: Add posibility to share webAR project using "share" modal
- AM-346: Add possibility to reassign projects when deleting a user
- AM-358: Add possibility to change underlying document for unpublished projects
- AM-308: Improve "e-mail notification" settings. Now possible to configure multiple e-mails notifications.
- AM-394: Add tooltips on project details for "edit/duplicate/delete" buttons.
- AM-133: Implement "recognition area" selector for AR projects
- AM-191: Re-implement the ability to send messages to native app like on AR manager v1
- AM-303: Add "owner" field in project details view

#### Fixed

- AM-524: Fix problem with user creation & organization selector
- AM-523: Fix error modal that appeared at start
- AM-519: Fix date handler for Safari
- AM-517: Cancel loading tasks when switching to another tab to avoid result conflicts
- AM-397: Improve UI spacings
- AM-477: Fixed not showing subdomain on ui
- AM-366: Fixed styles of projects list page
- AM-413: Fixed bug where we cannot add more than 1 tag in filter
- AM-452: Fix a bug with snack bar when displaying very long messages
- AM-310: Unify aspect of all modals
- AM-396: Fix scroll of left menu bar
- AM-393: Fix bug allowing to change project name while duplicating project
- AM-392: Fix bug which blocked the ability to go back after navigating through tabs in project details
- AM-395: Fix bug with delete/cancel buttons which were still clickable while deleting a project

### Editor:
#### Added
- AE-466: Added IE var for env, hide behaviors menu
- AM-457: Add access to mediaLib when coming from manager V2 which gives bear API token
- AE-442: Implement actions to control video & audio with Interaction Engine (disabled for now)
- AE-433: Implement first version of Interaction Engine UI to create behaviors
#### Fixed
- AE-462: Fix authentication cookie handler
- AE-397: Fix minor graphical issues since major update of libraries
- AE-411: Fix infinite scroll of thumbnail bar
#### Changed
- AE-455: Improve scene lighting with envMap
- AE-406: Do not require API urls parameters anymore, all in configuraitons of the editor
- Major update to Angular 13 with modern project tools
- AE-343: Update HTML editor to have colored syntax & indentation

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