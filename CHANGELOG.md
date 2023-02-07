# Argoflow platform Change Log

---

## [2.16](https://github.com/bear2b/argoflow-k8s/releases/tag/2.16)

### Migration notes

### API:
#### Added
- WAPI-755: Applications management
- WAPI-744: Implement SL reader template entitiy
- WAPI-751: Active MediaLib for Flow clients also
- WAPI-748: Ability to handle base64 string as files
- WAPI-745: Add an ability to set a hash as a value of the user password parameter
- WAPI-734: Import of the embedded Asset PDF as new Smartlink
- WAPI-717: Collection management
- WAPI-731: Allow possibility to use a project as a Example project

#### Fixed
- ISETO-127: User account cannot be recreated
- WAPI-747: It's not possible to unset the storage folder parameter
- WAPI-743: Error when user duplicates PDF project

#### Changed
- WAPI-740: Optimise smartlink pages
- WAPI-736 Optimize two stats calls: details & assets
- WAPI-722: Smartlink creation takes a long time

### Reader / Smartlink Creator:
#### Added
- WR-226: Make a demo of mobile onboarding popin using IE
- WR-264: Implement ArgoflowReader editor view

#### Fixed
- ISETO-120: Axeptio message is displayed again
- WR-253: include all supported languages in standalone reader
- WAPI-737: SCRIPT_HOST env var is not used in pre-created templates
- WR-294: add posibility to skip steps in onboarding popin
- AM-692: AM-692 - add sidebar header customization & fix "getPropertyValue"
- WR-282: Impossible to close asset which was opened in Modal on device
- WR-285: PDFZ.api not available

#### Changed
- WAPI-722: Smartlink creation takes a long time
- WR-271: Checkbox was too small on Safari and IOS on authorisations

### Manager:
#### Added
AM-615: Add possibility to share a specific page of a webAR project
AM-628 / AM-641: Disable the "publish" button while the marker is being processed
AM-663: Add link to old AR manager
AM-581: Create endpoints constants for api calls
AM-617: Show Alert message of non payment by organisation
AM-606: Implement background mode for AR projects
AM-540: Implement infinite scroll on AR pages view
AM-662: Add possibility to change image preview of a project
AM-673: add the possibility to open MediaLib in WebAR section
AM-667: refresh project list after background mode was completed
AM-692: Allow user to define his own skins for smartlink reader.
AM-685: implement script to force to update CHANGELOG file before push code.
AM-671: implement custom order ability for arPages
AM-674: add tooltip-message while publish/unpublish project
AM-671: implement custom order ability for arPages
AM-668: add possibility to import Aura in PDF
AM-668-2: fix not passed variable to api call
AM-672: add description for image fields in WebAR section
AM-653: add possibility to use a project as example project
AM-728: Enable Medialib for flow organisation that have specific flag
AM-734: Allow superadmin view and edit public projects right from Examples page
AM-723-2: Projects page offer a way to see the full project name

#### Fixed
AM-602: get full info of organization after picking it in org dropdown
AM-476: fix nasty error when trying to publish an AR project
AM-596: fix error when set validity days for AR project
AM-602: fix permission error when switching to another organization
AM-642: fix error while trying to update the thumbnail
AM-649: fix error with cover images
AM-640 / AM-643: refresh web page when AR-page added/deleted
AM-625: make subdomain to not have uppercase letters in request
AM-660: fix bug which allow to add tag to a locked project
AM-647: Fix error in WebAR when the URL already exist
AM-655: Fix handling of webAR parameters when sharing a page
AM-661: Fix infinite loading if custom subdomain already used
AM-676: Ensure that project shortlink is unique
AM-618: fix cannot search by some tags
AM-635: fix cannot found visitor issue on stats page
AM-682: fix cannot change Alert email parameter
AM-684: fix wrong default language
AM-651 / AM - 652: fix error appear when user tries to create project with more than 200 pages
AM-688: fixed stacking upload project notifications
AM-701: fixed download raw data in project stats page
AM-670: desactivated link check faq link in webar-design
AM-704: fixed No AR projects in the list when first connexion
AM-651: fix errorMessage when user tries to create project with more than 200 pages
ISETO-123: remove oldManager links for ISETO
AM-693: fix different tags for projects page and projectOverview page
AM-636: use visitor property for visitors dropdown list
AM-706: fix project list infinite scroll on Safari
AM-711: fix AR project deletion
AM-722: fix editor opening from AR pages view
AM-652: fix issue when user tries to create AR project with more than 200 pages
AM-728-3: Enable Medialib for flow organisation that have specific flag
AM-633: fix csv-zip doesn't work
AM-721: fix background loading widget stay on screen infinitely when I update document
AM-692-2: fix issue with template reader UI
AM-692-3: Add possiblity to customize sidebar header background & icons
AM-739: disable delete button if AR project in processing
AM-740: pass parameters for google_analytics and google_tag_manager
AM-745 : always pass in project PATCH parameters for googleTagManager & googleAnalytics
AM-743 : fix update of google analytics permission for organization edition
AM-793-3: disable delete button on projects-list and ar-pages
AM-730: fix issue with changing thumbnail before sharing for SL
AM-442: Removed redundant calls to /organisations to be more responsive and save the planet.

#### Changed
AM-540: Added infinite-scroll on project ar pages
AM-359: Changed error-message for AR project deletion if it in processing state
AM-260: Improve error handling
AM-359: Change the message for AR project deletion in processing state
AM-644: Hide thumbnail for webAR for now
AM-709: delete links to old Argoflow manager
AM-683: implement paginator instead of infinite scroll on Projects, AR-Pages, SL-Pages, Messages, Users, and Organizations
AM-590-b : fixed projets.service to support google tracking for ar projects
AM-738: Let user see and copy all Examples (organization independant)

### Editor:
#### Added
AE-573: Add beta message in IE modals
AE-449: Allow to undo/redo behaviors & context variable creation, edition & deletion
AE-528: Add "fullscreen" IE actions
AE-576: IE config save failure not handled
AE-557: Handle conditions & context variables when copy/paste assets
AE-578: Added Export Aura in PDF
AE-381: add GLB convertation for medialib
AE-563: Create dedicated "assetService" to handle page/document assets
AE-578: Add possibility to save pdf with interactions as local pdf file.
AE-611: add new format jpeg for guessMimeType method in ContentManager
AE-562: add new section "scripts"

#### Fixed
AE-512 / AE-565: Mobile/desktop only visibility issues
AE-572: Fix error with context variables in AR projects IE config
AE-501: Fix bug with asset rotation: move area was not rotated
Fix animation dropdown
PIC-149: Fix favicon for pic-editor
AE-551: Fix translation for media-toggle IE action
AE-603: handle migrated resources urls
AE-607: fix bug that prevent to save AR project when interaction engine config is empty.
AE-598: fix cannot add some types of assets to ArProject
AE-593: fix drop-down list isn't editable
AE-595: show a correct message when file is big
PIC-234: fix url was modified resulting in misinterpretation by the viewer
AE-618: fix IE config saving after AE-610
AE-587: Fix issue which displayed the editor very small at project opening.
AE-604: Fix issue with assets names
AE-619: fix undo & deleted asset after saved
AE-488: handling gif decoding errors
AE-622: Fix use of medialib for asset video or image in PDFZ project
AE-623: Always use bear API token to open medialib

#### Changed
AE-511 / AE-575: Simplify code handling login & initial api calls
PIC-145: disable IE for PIC-editor + add "app_id" parameter to login
Update PICMedia url for PIC-editor
PIC-122: Display dashed rectangle around marker in PIC-editor
PIC-154: change text of "test" button for PIC-editor
AE-484: Change value Distance by Position for "move_to" assetAction
AE-584: Save IE config in book for AR project instead of in marker
AE-610: Save ie config to AR marker in addition to book until native app is updated (cf AE-584)
AE-615: Enable Medialib for flow organisation that have specific flag
AE-615: Enable Medialib for flow organisation that have specific flag
AE-610: Save ie config to AR marker in addition to book until native app is updated


## [2.15](https://github.com/bear2b/argoflow-k8s/releases/tag/2.15)

### Migration notes

Please follow instructions in [Migrate to 2.15](migration/2.15/Migrate%20to%202.15.md)

### API:
#### Added
- WAPI-713: Payment notification state parameter in organizations
- WAPI-701: Do not return stats for deleted projects
- WAPI-696: Add a new parameter "Embedded PDF" for Organization
- WAPI-662: Add smartlinks.scripts text field to keep array of dynamic scripts
- WAPI-702: Smartlink visitor list
- WAPI-707 Sort tags by popularity
- WAPI-693: Quota check before pdf processing
- WAPI-639: callback_url parameter for background mode
- WAPI-692: Let update project by PUT/PATCH request in the background mode
- ISETO-113: Password reset ability
- WAPI-691: Allow filter stats by visitor on Statistics page (global)
- WAPI-686: Stats without organization_id
- WAPI-289: Logging
- PIC-91: Ability to add a link on the image added to PDF
- WAPI-638: Count only actived SmartLinks in quota consumption
- PIC-50: An ability to create asset with project_id instead of smartlink_id
- WAPI-680: Service to add image to PDF
- WAPI-669: Add new Aura attribute called "showInResponsiveViews"

#### Fixed
- WAPI-664: Correct error code if jwt token is invalid/expired
- WAPI-660: Stats by visitor fix
- PIC-101: Launch QR Code is distorted
- PIC-95: Inconsistency between SL and markers if underlying document is an image
- WAPI-682: User consumption value update
- WAPI-688: Incorrect created date of migrated organizations from BEAR API

#### Changed
- WAPI-719: Added aliases to CH requests

### Reader / Smartlink Creator:
#### Added
- WAPI-654: Smartlink Creation with pre-created templates
- WAPI-668: AURA in PDF for Batch mode
- WAPI-670: Implement encrypting in Batch mode
- WR-233, WR-251: Implement support of pdf files with embedded auras
- WR-215: Provide download link for file assets when possible

#### Fixed

#### Changed
- WAPI-711: Smartlink generation without Gulp as default
- WAPI-696: Added a check if the original strategy is allowed by organization
- WR-184: Open modal webviews in iframes similar

### Manager:
#### Added
- AM-563: add new organization parameter to enable "embedded pdf"
- AM-566: allow to filter stats by visitor on stats page
- AM-585: implement background mode for project update
- AM-586: added bgMode for update project upload
- AM-578: added “extended tracking” & “community marker” to AR page settings
- AM-609: added exactMatch sort project parameter
- AM-591: added duplicate project to project dropdown menu
- AM-453: Added share thumbnail change for AR projects
- AM-330: added logic of getting search value from session storage
- AM-307: Add possibility to filter stats by viewer
- AM-586: Add "copy url" button in "custom subdomain" field
- AM-588: Add a warning message about asset positions when replacing underlying document.
- AM-546: Added new parameter for Organization and Project to encrypt PDF
- AM-399: added Wemap map of views in project stats page
- AM-470: implemented splitting locales script

#### Fixed
- AM-629: fix bug which prevent to delete user
- AM-626: fix default value for e-mail notification parameter
- AM-624: fix API call for password reset when no SSO
- AM-582: added getCsv param to dowloadFullStats call
- AM-552: remove unnecessary condition in listOfProjects call to make visible only related projects for specific organization
- AM-607/AM-612/AM-614: Test modal now opens directly on selected page
- AM-568: Split tags collections depending on the API we reach
- AM-330: Keep all search settings when I go on project detail & click on back button
- AM-532: Users & Messages are now updated when switching to another organization
- AM-542: Fix problem of disabled stats for superadmin & account manager when logged in organization without stats
- AM-543: Fix responsiveness of "stats disabled" message
- AM-595: Remove " & ' characters from project name
- AM-624: add conditional url for reset and set new passwords
- AM-574: Fix webAR url to return default url if no custom domain is set
- AM-509: Fix project filtering by tag
- AM-485: Update password requirements
- AM-561: Send language to editor
- AM-567: fix translations
- AM-506: Adapted "you have been disconnected" popin to error message
- AM-525: Fixed color of link and input area in dark mode
- AM-527: removed symbol 'upper arrow' from bear api projects search
- AM-561: passed lang param for editor link

#### Changed
- AM-361: implement infinite scroll on organizations, users, messages & project pages
- AM-538: removeв token from parameter, and added project type in header calls
- AM-593: impoved pipe number abbreviation to add K, M, B
- AM-569: Changed title Quota on the dashboard
- AM-490: made more clean ability to pass parameters into projectList and createProjects api methods
- AM-399: changed logo of pinpoint and removed burger menu in wemap-map

### Editor:
#### Added
- AE-502: fix big size of selection area
- AE-520: [IE] Add possibility to manage context variables for interaction engine
- AE-530: [IE] Add possibility to define a set of conditions to trigger a behavior
- AE-534: [IE] Add possibility to define context variables as persistent
- AE-535: [IE] Add possiblity to have 1 event + multiple conditions => multiple actions for 1 behavior
- AE-542: [IE] Add "increment/decrement context variable" action in IE
- AE-507: Implement algorithm to keep as much as possible the dimension of assets when copying from one page to another (with different dimensions)
- AE-561: [IE] Add possibility to declare context variable as "global"
- AE-443: [IE] Add "toggle media" action in interaction engine
- AE-517: Add possibility to copy the "page id" information in tech infos panel
- AE-518: Add possibility to validate auras properties by pressing "enter" key
- AE-429: Ability to set responsiveness for assets (but disabled for now)
- AE-486: Interaction engine configuration now saved in embedded auras
- AE-450: Can now copy/paste IE behaviours
- AE-470: Add possibility to reset IE form
- AE-476: uncommented needsRendering var
- AE-457: IE implement ON_CAMERA_DISTANCE events
- AE-456: implement new event enter/leave behavior for IE
- AE-465: [IE] added possibility to play an object animation
- AE-495: Add "technical informations" panel to display "pageId" value
- AE-421: Add support of embedded Auras in PDF

#### Fixed
- AE-537: Fix issue with aura visibility
- AE-552: Fix problem when empty IE configuration for AR projects
- AE-362: Fix some translations
- AE-502: Fix bug with clickable area of asset
- AE-524: Fix bug with "animate" checkbox in interaction engine
- AE-536: Fix bug with asset anchor size
- AE-537: Fix bug which make some asset become invisible
- AE-539: Enable "save" button after editing a behavior
- AE-560: Fix bug with preferred language
- AE-518: make asset rotation props change on Enter
- AE-422: Advanced features for "embedded auras in pdf"
- AE-512: Fix issues with responsive visibility of auras
- AE-523: Fix problem with ratio & responsive view
- AE-529: Fix translation
- AE-508: fixed layout of asset behaviors if name too long
- AE-510: Fix bug with duplicated assets
- AE-499: Fix autoplay for audio assets
- AE-392: removed unnecessary life cycle method
- AE-427: fixed thumbnail generation on upload for short video
- AE-483: Restore saving of empty content
- AE-474: Improve authentication mecanisms
- AE-493: fixed unsaved changes for IE at first application load

#### Changed
- AE-540: Disable asset responsiveness for AR projects
- AE-541: Show only visible assets in current responsive view in behavior forms
- AE-545: Assign 1 IE config per page
- AE-519: Do not update aura size when changing its cover image
- AE-526: Remove Start/stop 3D animation actions for PDF project
- AE-509: disabled some ie options for v1
- AE-516: disable IE for multi-languages projects
- AE-489: regroup "video" & "audio" IE actions into "media" actions
- AE-489 - merge video & audio actions into "media" actions in Interaction Engine.


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