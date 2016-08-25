

# [Dashboard Project](https://coupa-release.herokuapp.com)

![Alt text](/public/assets/coupa-logo-6371f03cce2d36dbf561283a27cb20cc.jpg?raw=true "COUPA")

# Configuration App for Setting up Dashboards with [Dashing](http://dashing.io)

Coniguration Page to quickly setup beautiful dashboards that can display useful data
* Create your own dashboards on the fly
* Preseeded widgets and templates for efficient use of adding widgets


* Dashing Key Features:
	* Use premade widgets, or fully create your own with scss, html, and coffeescript.
	* Widgets harness the power of data bindings to keep things DRY and simple. Powered by batman.js.
	* Use the API to push data to your dashboards, or make use of a simple ruby DSL for fetching data.
	* Drag & Drop interface for re-arranging your widgets.

## To Use: 

Navigate to https://coupa-release.herokuapp.com (To login must be part of Coupa Git Organization)

1. Create new dashboards
	- Add desired widgets to the dashboards
		* click Add new Widget
		* select widget type from the drop down menu (each widget type has a preview image showing what it looks like)
		* complete the rest of the fields depending on the widget type you selected 
		* select which dashboard you want to add this widget to

2. Edit dashboards
	- Click Edit next to the dashboard you want to edit. Here you can modify this dashboard's name and layout
	- Rearrange widgets layout. Click View to view the dashboard. Then you can drag the widgets around. After you found a layout you like, click Save thie layout at the top of the page. Paste that layout into the layout field described above (the view page of the dashboard)
	- Delete or edit widgets. Click on the Dashboard name. Here you see the list of all widgets on this dashboard. You can delete any widget or modify any input field for any widget

3. View the dashboard list
	- Click view dashboard link for the dashboard you wish to view

## Example Dashboard

![Alt text](/public/assets/dashboardExample.png?raw=true "R16")

<!-- At the top of the file there should be a short introduction and/ or overview that explains **what** the project is. This description should match descriptions added for package managers (Gemspec, package.json, etc.) -->

## Code Example

Widgets get updated from sending data from ruby jobs in the /jobs folder, the .coffee file for the widget handles that data to display on the widget, the .html handles the view structure for the widget and .css the styling.

Check out http://shopify.github.com/dashing and https://github.com/gottfrois/dashing-rails for more information.

## Running Locally

1. Change directory to release_dashboard
	1. Bundle `$ bundle install`
	2. Start redis server `$ redis-sever`
	3. Start PSQL (Postgres) if it's not already running, or change the database.yml to your local database module
	3. Starts rails server `$ rails s`
2. Navigate browser to localhost:3000

## Public vs Private Dashboards

Upon creating each new dashboard, you have the choice to make the dashboard either public or private. Public dashboards are displayed on the home page visible to anyone. Private dashboards are only visible to you. Click My Dashboards on the home page to view and edit your dashboards.

## OAuth Authentication and User Model

The whole app uses [OAuth Authentication](https://developer.github.com/v3/oauth/#scopes) with Github. To view a list of all users, go to '/users'. On this page, you can see all users with their names and ids. You can also view your dashboards by appending your id to '/users/' and visiting that url (equivalent to clicking My Dashboards on home page).

## Adding Widget Types

1. Add more widgets types by adding the three necessary widget files (.coffee, .html, .css) + the job (.rb) file for the widget to their respective folders within the project.
2. Add the the new widget to the widget list in the seed file. 
3. Edit the widget controller views (new, edit, show) to accomadate the new widget
4. Add the widget to the dashing/dashboards/dashboard.html.erb file as a new case
5. Success, now your new widget type is in the list of widgets to choose from. 
	
## API Reference

You can find a config_userpass.yml.example file. If you have different APIs to use. Change the key values here to your authentication login information for the widgets you'd like to display.

## Browser Compatibility 

Tested in Chrome, Safari 6+, and Firefox 15+.

Does not work in Internet Explorer because it relies on [Server Sent Events](http://www.html5rocks.com/en/tutorials/eventsource/basics)

<!-- Describe and show how to run the tests with code examples. -->

## Contributors

* [Project Contributors](https://github.com/coupa/release_dashboard/graphs/contributors)

* [Shopify's Dashing Official Page](http://shopify.github.io/dashing/)

* [Dashing-rails Contributors](https://github.com/gottfrois/dashing-rails/contributors)

* Brief YouTube Video on Dashing-Rails: [Ruby Dashing-Rails Gem DevCast](https://www.youtube.com/watch?v=ukoItMznDiY)

## Project Feedback and suggestions

* [Project Feedback Doc](https://docs.google.com/document/d/15DNZzdvHdZkktm9R54v3DxYwKSlQLZD507_06KvMh3A/edit)

## License

Open Source.

`Dashing is released under the MIT license`
