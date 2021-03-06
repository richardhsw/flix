# Flix

Flix is an app that allows users to browse movies from the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

## Flix Part 2

### User Stories

#### REQUIRED (10pts)
- [x] (5pts) User can tap a cell to see more details about a particular movie.
- [x] (5pts) User can tap a tab bar button to view a grid layout of Movie Posters using a CollectionView.

#### BONUS
- [x] (2pts) User can tap a poster in the collection view to see a detail screen of that movie.
- [x] (2pts) In the detail view, when the user taps the poster, a new screen is presented modally where they can view the trailer.

### App Walkthough GIF
<img src="http://g.recordit.co/GNS66iW8Bi.gif" width=250><br>

### Notes
I ran into an issue displaying the pictures in the CollectionViewCell correctly (see image below). No matter what changes I made to the Swift script, or the ImageView's attributes, the problem still could not be solved. After a few hours of research, I solved the problem by going to the CollectionView's size inspector and changing the "Estimate Size" from "Automatic" to None". 

<img src="https://s5.gifyu.com/images/Screen-Shot-2020-01-27-at-18.26.26.png" width="310">

---

## Flix Part 1

### User Stories
#### REQUIRED (10pts)
- [x] (2pts) User sees an app icon on the home screen and a styled launch screen.
- [x] (5pts) User can view and scroll through a list of movies now playing in theaters.
- [x] (3pts) User can view the movie poster image for each movie.

#### BONUS
- [x] (2pt) User can view the app on various device sizes and orientations.
- [x] (1pt) Run your app on a real device.

### App Walkthough GIF
<img src="http://g.recordit.co/IYlQkHMPdn.gif" width=250><br>

### App on Real Device GIF
<img src="https://s5.gifyu.com/images/flix_phone.gif" width=250><br>

### Notes
