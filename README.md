Radio Stream
============

About
-----
**Radio Stream** is your personal music service that streams music automatically based on your listening habits.

* **Your music** - Use your own music files without restrictions.
* **Automatic DJ** - Enjoy music immediately without choosing a specific song or album. The music is selected based on when you last heard it, its rating and more. Read more [below](#automatic-dj).
* **Dynamic playlists** - Want to hear only some of your music? Create a music playlist, e.g, only with genre Heavy Metal, and have the automatic DJ stream the music from that station.
* **Desktop and Mobile clients** - Listen to your music when you're on another computer or on your mobile phone.
* **Last.FM support** - Scrobble your music to Last.FM
* **Powered by beets** - Use the super-powerful [beets](https://github.com/beetbox/beets) and all its plugins to organize your music. 
* **Open source** - Modify the applications for any missing features. 

Automatic DJ
------------
Each time you start listening to your music **Radio Stream** makes a list of songs with the following consideration:

* **Rating** - Higher rated songs will appear more.
* **Play date** - Songs that were played least recently will appear more.
* **Play count** - Songs that were played less (e.g. new songs), will appear more.
* **Unrated songs** - Unrated songs are considered new and are played more often.
* **Limit artist repitions** - Prevent a single artist to repeat too many time.

Each of these rules contribute to a "score" of a song which decides which song will be streamed next.

Why I made Radio Stream
-----------------------

I have a relatively large music library which is too large to store on a device. Initially I've relied on various partial syncing solutions for the iPhone, but my solutions were flawed, especially so once I've started using an Android phone. I wanted to have easy access to my library from any device I use.

Additionally, I don't like all my music library the same, so playing it on shuffle was a disappointing experience - I want to listen more to songs I like more. And I definitely don't want to listen to a song I just listened a day ago because it got shuffled again. I wanted a more intelligent way to choose the music for me.

I've looked into several online service, but they were other limited in some way or lacked the features I wanted. Eventually I decided I will just do it myself.

How to use
==========

Prerequirements
---------------
You need [docker](https://www.docker.com/products/overview) to run the server. So far I've ran it successfully on **Mac** and **Linux**. 
You might be able to run it on **Windows 10** too, if you use **bash for Windows** (for example like the one that comes with git for Windows).

The clients are available for [Mac](TODO) and [Android](TODO).

Getting started
---------------

* Clone this git repositry or [download](TODO) the zip
* Open the terminal in the downloaded directory
* Run: `bin/start`

If all goes well, docker will download the Radio Stream and connect to it. You should see:

    *******************
        RadioStream
    *******************
    User: radio
    Password: radio

    Available scripts:
    ...

    bash-4.3#

Type `exit` to exit the server application.

At this point your server is running and listening on port **80**.

Connect with a client application
---------------------------------

Before you proceed, let's verify that the server is online and working. 

Download one of the client applications:

* [Mac](TODO) 
* [Android](TODO)

Launch the application and enter the IP address of the server and the default password: `radio`

**Note:** You might need to allow incoming connection in your firewall or router.

`TODO IMAGE SETTINGS`

If everything works as expected, you should see this screen:

`TODO IMAGE PLAYLISTS`

If it doesn't connect, please see [troubleshooting](#troubleshooting) below.

At this point we have no music so let's add some.

Managing Music
==============

Adding existing music library
------------------------------


Adding music from YouTube
-------------------------

Configuration
=============

Password
--------

Playlists
---------

Last.FM
-------

Scripts
-------


Upgrading
=========
* Run: `bin/stop`
* Run: `docker pull vitalybe/radio-stream:latest`

Configuration
=============
* Follow the directions in configuration [README](config/readme.md)

Troubleshooting
===============

Client can't connect
--------------------

Logs
----

In case something is wrong, you can see the logs by: `bin/logs`