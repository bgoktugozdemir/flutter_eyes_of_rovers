# Flutter Eyes of Rovers

[Flutter](https://flutter.dev) project uses **Mars Rover Photos** API of [NASA](https://api.nasa.gov/).

**(All the contributions are welcome.)**

---

<table>
<tr>
<td>
<img height="450" alt="Android" src="./screenshots/android.gif">
</td>
<td>
<img height="450" alt="iOS" src="./screenshots/ios.gif">
</td>
</tr>
<tr>
<td align="center">
Android
</td>
<td align="center">
iOS
</td>
</tr>
</table>

## Packages

* [authentication_repository](./packages/authentication_repository) 
  * Provides: `Firebase Authentication`, `Facebook Login`, `Failures`
  * Tests: :white_check_mark:
* [nasa_api](./packages/nasa_api)
  * Provides: `NASA API Client`, `Exceptions`
  * Tests: :white_check_mark:
* [nasa_repository](./packages/nasa_repository)
  * Provides: `Requests of NASA API`, `Models`
  * Tests: :white_check_mark:

## Adaptive Widgets

This project uses adaptive widgets everywhere which allows a native view for each component and screen.

It means there are two types of widgets. For iOS and Android.

* [Adaptive Alert Dialog](./lib/core/widgets/adaptive_alert_dialog.dart)
* [Adaptive App](./lib/core/widgets/adaptive_app.dart)
* [Adaptive Bottom Navigation Bar](./lib/core/widgets/adaptive_bottom_navigation_bar.dart)
* [Adaptive Button](./lib/core/widgets/adaptive_button.dart)
* [Adaptive Dropdown Button](./lib/core/widgets/adaptive_dropdown_button.dart)
* [Adaptive Icon](./lib/core/widgets/adaptive_icon.dart)
* [Adaptive Progress Indicator](./lib/core/widgets/adaptive_progress_indicator.dart)
* [Adaptive Scaffold](./lib/core/widgets/adaptive_scaffold.dart)

## API

It uses **Mars Rover Photos** API of [NASA](https://api.nasa.gov/).

* Query by Martian Sol
* Query by Earth Date

Both query methods are ready to use, but `Martian Sol` is preferred.

### Note

This project uses the bloc and mockito packages and examples in the [bloclibrary.dev](https://bloclibrary.dev). 

You can find more info about bloc from the [bloclibrary.dev](https://bloclibrary.dev)

