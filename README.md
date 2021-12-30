# 🎼 swift-music

[![CI](https://github.com/sh3l6orrr/swift-music/actions/workflows/CI.yml/badge.svg)](https://github.com/sh3l6orrr/swift-music/actions/workflows/CI.yml)

## Introduction

swift-music is a swift package that provides an easy-to-use API for music related developments.
There are four modules:
- MusicTheory: Notes, chords, scales.
- Songwriting: Melody and chord progressions.
- Composition: Tracks.
- MusicPlay: A tool to play music.

The four modules are demonstrated below.

### MusicTheory
```swift
import MusicTheory
```
#### Interval Arithmetic
```swift
Note.D - Note.E  // Interval.m7
```

#### Create a Chord
```swift
let chord = Chord("Cmaj9/G")!
chord.description

// This is a slash chord named Cmaj9/G over G, with root note C, and component 
// notes D, E, G, B, which are respectively major second, major third, perfect
// fifth, major seventh above the root. 
```

#### Is this chord in my scale?
```swift
let chord = Chord("Cmaj9/G")!
let scale = Scale(.Cs, .major) // C♯ Major
chord.isIn(scale) // True
```

### Songwriting
```swift
import SongWriting
```
#### Compose a Melody
```swift
let 🎶 = Melody()
    .add(MusicNote("E4", value: ._2))
    .add(MusicNote("D4", value: ._2))
    .add(Pause(._2))
    .add(MusicNote("E4", value: ._2))
    .add(MusicNote("C4", value: ._1))

🎶.length // 3 Beats
🎶.visualization // To be implemented
```

#### Compose a Chord Progression
```swift
// To be implemented
```

### Composition
```swift
import Composition
```

#### Compose a Piece of Music
```swift
// To be implemented
```

#### Analyze Music
```swift
// To be implemented
```
### MusicPlay
```swift
import MusicPlay
```

#### Play Synth
```swift
let wave = Wave.sine
let oscillator = Oscillator(wave: wave)
let synth = Synth(oscillator: oscillator)

synth.play(MusicNote("C4")!)  // Mac generates sound of 261.63Hz
```


## Installation

### Xcode Project

File - Add Packages - https://github.com/sh3l6orrr/swift-music.git

### Swift Package Manager 

Inside Package.swift, add the followings:

```
dependencies: [
    .package(url: "https://github.com/sh3l6orrr/swift-music.git", .upToNextMajor(from: "0.2.0"))
]
```
```
targets: [
    .target(
        name: "YourTarget",
        dependencies: [
            .product(name: "MusicTheory", package: "swift-music"),
            .product(name: "Songwriting", package: "swift-music"),
            .product(name: "Composition", package: "swift-music"),
            .product(name: "MusicPlay", package: "swift-music")
        ]
    )
]
```

## Documentation

Documentation can be built in Xcode by 

Product - Build Documentation 

## License

This project is published under the Apache License 2.0.




