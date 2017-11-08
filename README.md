## AutocompleteFilter

Xcode 8 plugin that filters autocompletion output to certain symbol types (mostly to filter out garbage like defines and such).

## Usage

Engage autocompletion (so the list shows up) and press:

* `Control` to only show enums
* `Command` to only show classes
* `Option` to only show types

## Installation

1. Clone the repo, open the project file
2. *optional* modify the `Info.plist` file so it includes your Xcode UUID
3. Build the project, restart Xcode, enable the plugin in the popup


## Thanks

Mostly to [chendo](http://github.com/chendo) for his excellent [guide](http://chen.do/blog/2013/10/22/reverse-engineering-xcode-with-dtrace/) and [FuzzyAutocomplete](https://github.com/FuzzyAutocomplete/FuzzyAutocompletePlugin) project that server as a boilerplate for this one.
