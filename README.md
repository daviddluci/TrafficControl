
# Traffic Control - Homework Assignment

A 2D traffic intersection simulation built in Ruby with Gosu.

## ✨ Features

- Realistic Traffic Simulation: Cars move according to traffic lights and follow cars in front of them.
- Collision Detection: Detects collisions between cars and ends the game.
- Traffic Jam Detection: Stops the game if too many cars are halted in the intersection.
-  Car Spawning: Cars spawn at random origins randomly.

## 📋 Requirements

- Ruby 3.4+

- Bundler (for managing gems)

## 📦 Gems Used

- `rake` - used to run the game via rake tasks

-  `gosu` - used for rendering.


## ⚙️ Setup



1.  **Clone this repository**:



```bash
git clone https://github.com/daviddluci/TrafficControl.git

cd TrafficControl
```



2.  **Install dependencies**:



Make sure you have **Bundler** installed:



```bash

gem install bundler

```



Then install the required gems:



```bash

bundle install

```



## ⌨️ Controls

- **ESC -** close the game
- **ARROW UP ↑ -** toggle **north** traffic light
- **ARROW DOWN ↓ -** toggle **south** traffic light
- **ARROW LEFT ← -** toggle **west** traffic light
- **ARROW RIGHT → -** toggle **east** traffic light

## 🚗 Usage

#### Run the game using `rake`
```bash
rake game_start
```
or simply
```bash
rake
```

## 📁 Project Structure
- `media/` - contains all game assets such as car images, traffic light images and background images.
- `lib/` - contains the main game logic and supporting classes.
- `lib/constants/` - stores configuration constants for cars, game logic, traffic lights, and window settings.
- `TrafficControl.rb` - is the main file to start the game
- `Gemfile` - defines used gems
- `Rakefile` - defines tasks to run the game

# ✅ All set!
## ✨ Thank you for checking out this project! ✨