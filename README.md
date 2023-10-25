# Flickr Search Code Challenge
This code challenge allows a user to search the Flickr API for images, which will be displayed in a simple `List` on the main screen. Tapping on a row will navigate to a detail view for the specific image. User can search for multiple tags by separating search terms with a comma.

## Requirements
- Xcode 15

## Running the App
1. Open the Xcode project
1. Wait for all packages to be downloaded
1. Run the app

## Testing
There are a few unit tests included in the project. To run the unit tests:
1. Product --> Test (or Cmd + U)

# Demo

## Code Commentary
Since this is a time-boxed code challenge, I chose to make some technical decisions in favor of functionality to make sure the app hit all acceptance criteria. There are TODOs in the code that call attention to these items. Before calling a feature complete, I would typically be sure to address all remaining TODOs.

### 3rd Party Dependencies
Part of the acceptance criteria required me to parse HTML to extract the image's width and height. In the interest of saving time, I chose to use a 3rd party (SwiftSoup) to do this for me.

## Future enhancements
Again due to the time contraints, I simply did not have enough time to make everything perfect. The items listed here are enhancements (technical and user-facing) that I would make.
- Testing the network layer. I built the `SearchViewModel` so that you could inject your own `URLSession`. There are techniques where you can create your own `URLSessionConfiguration` and use that for testing that will allow you to return custom payloads for testing, rather that using the shared URLSession and hitting the actual API.
- Add the ability to "clear" search text rather than requiring a user to backspace to start over
- Better error handling. Right now errors are simply printed to the console, which doesn't give the user any indication that something went wrong. It would be better to alert the user if there was an unrecoverable error.
- Add UI/Snapshot tests. Since there is no design, I didn't bother to create reusable UI elements. If there were, I sometimes find it valuable to create snapshots tests of the components to make sure changes don't effect the expected look at feel. Additionally, these tests could verify other reusable views (eg `SearchItemRowView`)
- AsyncImage phase errors. If there are problems loading image thumbnails, they aren't currently handled.
- SearchItemDetails view model
- Design. I am not a good designer :) I would not want to push this app to production without some nice UI changes. 
- Loading indicator. It would be good user feedback to know when the app was fetching data. 
- Input sanitization. Right now we allow the user to search for anything, and if they choose to search for multiple tags we don't verify that they are separated by a comma.
- More accessibility testing. I'm using native SwiftUI controls so most things are handled okay with voice over. One thing I might improve upon is some custom handling of the list of tags, or reading the description of a field like "author" or image size.