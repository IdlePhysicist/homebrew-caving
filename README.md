# homebrew-caving

This repository serves as a Homebrew tap. The idea for the repo and the Therion formula were inspired by [ladislavb/homebrew-therion](https://github.com/ladislavb/homebrew-therion).

## Groundwork

1. Install Command Line Tools
    ```
    xcode-select --install
    ```
2. Install Homebrew
    ```
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    ```

3. Test it:
    ```
    brew update && brew doctor
    ```
    If you want to disable brew analytics run `brew analytics off`

4. Install XQuartz & MacTeX
    If your macOS doesn\'t contain X11 server (10.12 Sierra+) install it by following command:
    ```
    brew cask install xquartz mactex
    ```

5. Tap this repo
    ```
    brew tap IdlePhysicist/caving
    ```

## Therion

Therion is cave surveying software - for details see [therion.speleo.sk](https://therion.speleo.sk)

For help using Homebrew visit [brew.sh](https://brew.sh/)

### Install Therion
```
brew install --verbose idlephysicist/caving/therion
```

This formula targets Therion v5.5.0

If you want to install the latest commit from `master` add the `--HEAD` flag after `brew install`. 


### Linking Loch to /Applications

~~To create symbolic link for loch.app to Applications folder run:`brew linkapps`~~

Due to the deprecation of the `linkapps` command in Homebrew, it is my understanding that Loch cannot be built using Homebrwe currently.

## Cave Logger

Cave Logger is a record keeping program for caving. It allows the user to track when they go caving, where they go, who they go with.

### Install Cave Logger
```
brew install idlephysicist/caving/cave-logger
```

