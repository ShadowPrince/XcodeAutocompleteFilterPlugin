## AutocompleteFilter

Xcode 9 plugin that filters autocompletion output to certain symbol types (mostly to filter out garbage like defines and such).

For Xcode 8 use commit `3775dd2658a5aaed4364c1883e6e4765c5c03bbe`.

## Usage

Engage autocompletion (so the list shows up) and press:

* `Command` to only show types
* `Option` to only show enums

Also everything starting with `accessibility` is sorted-out too.

## Installation

1. Clone the repo, open the project file
2. *optional* modify the `Info.plist` file so it includes your Xcode UUID
3. Build the project, restart Xcode, enable the plugin in the popup


## Thanks

Mostly to [chendo](http://github.com/chendo) for his excellent [guide](http://chen.do/blog/2013/10/22/reverse-engineering-xcode-with-dtrace/) and [FuzzyAutocomplete](https://github.com/FuzzyAutocomplete/FuzzyAutocompletePlugin) project that server as a boilerplate for this one.
