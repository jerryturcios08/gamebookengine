# Gamebook Engine

Gamebook Engine is an open source iOS app for creating and playing "gamebooks", a type of interactive fiction where the player gets to make decisions that influence the story.

## Features

* [x] Create classic (or more advanced) gamebooks right on your iDevice
* [x] Export and import games from non-proprietary JSON files
* [ ] Analyzer ensures you don't create any unreachable pages or dead-ends

## Gamebook Structure

* **Attributes**
  * These are essentially just global variables shared throughout a game
  * They hold a name, and an integer value which defaults to 0
* **Pages**
  * **Content**
    * The text of the page, formatted with a limited set of Markdown attributes
  * **Consequences**
    * The consequences of landing on a given page
    * A consequence can affect attributes in three ways:
      * Set (to a value)
      * Increment (by a value)
      * Decrement (by a value)
      * Multiply (by a value)
  * **Decisions**
    * **Destination**
      * The page that the decision leads to
    * **Rules**
      * Match Any or All rules (based on the value of Attributes) to determine if a decision appears on the page

If you're curious about what an exported Gamebook looks like, view [An Introduction to Gamebook Engine.gbook](https://github.com/amiantos/gamebookengine/blob/master/BRGamebookEngine/Built-in%20Gamebooks/An%20Introduction%20to%20Gamebook%20Engine.gbook) for an example.

## To Install

1. `git clone https://github.com/amiantos/gamebookengine.git`
2. Open `BRGamebookEngine.xcworkspace` in Xcode 11 or higher.
3. Build :)

## Author

* Brad Root - [amiantos](https://github.com/amiantos)

## Credits

* The app icon features the icon [magic, by Smalllike](https://thenounproject.com/icon/2721149/)