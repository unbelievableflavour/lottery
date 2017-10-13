# Lottery
Determine who will be the winner
 
<p align="center"> 
    <img  
    src="https://raw.githubusercontent.com/bartzaalberg/lottery/master/screenshot.png" /> 
</p> 

### lottery for elementary OS

An application who will randomly choose in a list of filled in people

## Installation

### Dependencies

These dependencies must be present before building
 - `valac`
 - `gtk+-3.0`
 - `granite`

 You can install these on a Ubuntu-based system by executing this command:
 
 `sudo apt install valac libgtk-3-dev libgranite-dev`


### Building
```
mkdir build
cd build
cmake ..
make
```

### Installing
`sudo make install`
