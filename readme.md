# League Table Parser

This is a tidy up of a project to do this that started a while ago. It got a bit sidetracked, so that's why it's a bit messy.

Most recently, I've been refactoring the HTML_Parser, helper and JSON Writer classes that are now parsing the source website and parsing it to json.

## Next Steps
* Create a controller that checks whether the date has been updated, and only writes the data when it has been changed.
* Send output to local mongodb instance rather than file.
* get more granular info from source, i.e. home and away splits.
* Think about the processing of this. Should I be handing the database processed teams, ie. table data with stats handling, or should java be handling this? Or, is java just going to be my service layer?
