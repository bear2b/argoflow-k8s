# Argoflow platform Change Log

---

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