# what is this?

A thing that makes Webcomicname mash-up comics!

It started out as a quick hack but I kept improving it and documenting it because I think that Glitch is really cool and I hope that the code for this silly project will be interesting or fun for someone out there.

<a href="https://twitter.com/dorrismccomics/status/956575861523787783"><img src="https://cdn.glitch.com/13424d29-dc63-462f-8bdb-213dd069d44b%2FScreen%20Shot%202018-01-25%20at%204.47.23%20PM.png?1516916854332" /></a>


Remix this project and make it your own! 
<a href="https://glitch.com/edit/#!/remix/webcomicname-mashup">https://glitch.com/edit/#!/remix/webcomicname-mashup</a>

I saved a copy of the very first, <strong>minimal version</strong> in case you want to start there: 
<a href="https://glitch.com/edit/#!/remix/minimalist-webcomicname-mashup">https://glitch.com/edit/#!/remix/minimalist-webcomicname-mashup</a>



## credits

* comics by Alex Norris! <a href="http://webcomicname.com/">webcomicname.com</a>
* Panel splitting: `comicstrip` utility by  David Koo <a href="https://github.com/caseyf/webcomicname-mashup/blob/master/scripts/comicstrip">Python source code</a>
* Separating titles from panels: my own hack <a href="https://github.com/caseyf/webcomicname-mashup/blob/master/scripts/ohno_title_splitter.rb">Ruby source code</a>
* Save feature: `dom-to-image` by Anatolii Saienko <a href="https://github.com/tsayen/dom-to-image">JS source code</a>
* Save icon by Gregor Cresnar from the Noun Project


# how?

1. I snarfed all of the comics from webcomicname.com by using a $3 "Tumblelog Picture Downloader" app from the Mac App Store. There are several Tumblr picture download projects on Github that should do the same thing.
2. I split the panels into 3 separate images with <a href="http://bazaar.launchpad.net/~kpublicmail/comicstrip/devel/view/head:/comicstrip">comicstrip</a>.  The <a href="https://code.launchpad.net/~kpublicmail">original author</a> of this did all of the hard work 👏 `comicstrip` did a pretty great job and got all 3 panels from most of them. This shell script processes each one and names them with consecutive numbers. It could be improved by having it reuse a strip number if the correct number of panels are not found. That way there aren't gaps.

    ```
    ls -1 tumblr-downloader-images/*.jpg | nl | while read line; do
      parts=($line)
      index=${parts[0]}
      filename=${parts[1]}
      ./comicstrip -f ${filename} --min-width=160 --min-height=160 --prefix=strip_${index}_
    done
    ```
    
    **NOTE:** The `comicstrip` script is from 2009 and it still runs fine  with Python 2.7 but it needs some minor changes to work with Pillow. Here are <a href="https://github.com/caseyf/webcomicname-mashup/commit/c1712cb9f282503beaedf2ad3be7bcaefbe441e9">my changes</a>.
  
  3. Now the filenames are all like `strip_[STRIP NUMBER]_[PANEL NUMBER].jpg` so  we can use Javascript to come up with 3 random panel image links and insert them into a page.   I dumped all of the images into Amazon S3 because it was easy. There is <a href="https://support.glitch.com/t/easier-way-to-reference-assets/394">probably a way</a> to store them in Glitch and still get predictable URLs.

4. The source for the web part is all inside of `index.html` over there ← . The <a href="https://glitch.com/edit/#!/remix/minimalist-webcomicname-mashup">minimal version</a> of this page picks 3 random numbers between 1 and the # of panels, uses that to create the URL, and adds an IMG to the page for each one.  This is the fancy version: it adds unique URLs for each mashup  and back button support so that you can more easily share, a "save" button that works on Firefox/Chrome, randomized titles, tap to swap out a panel, and the "include the latest" option.

# adding new strips

Here is code that uses the webcomicname RSS feed to look for new strips and processes them (separates the panels, splits out the titles, etc): <a href="https://github.com/caseyf/webcomicname-mashup/tree/master/scripts">processlatest</a>. 

# oddities

The panels were automatically cropped so the borders don't always line up and the titles are sometimes not quite right.

There are a couple weird/messed up panels that I haven't excluded.

All in all there are 708 panels.


# changes

**🌅 the morning after:**

I messed around with extracting the titles and showing different titles. There are variables in the page that you can use to adjust title swapping.

My hacky Ruby code for splitting out the titles is here: <a href="https://github.com/caseyf/webcomicname-mashup/blob/master/scripts/ohno_title_splitter.rb">ohno_title_splitter.rb</a>. It looks for consecutive horizontal lines that are more black lines than not. It isn't smart about the wiggly borders so it only did an okay job. Sometimes the title for a panel wasn't correctly removed so 2 titles (the random title and the panel title) are stacked on top of each other in a funny way. Other times, it is cropped in the wrong place.


I used `dom-to-image` to add a save button. It only supports Chrome and Firefox.

**🌅 the next morning after:**

I added  the "include the latest" link for generating a strip using 1 panel from the latest comic and put together the utilities for adding new strips so that it's easy to keep this updated.

I reprocessed the images so that they are now PNGs instead of being JPGs with icky compression artifacts. The panels look much nicer now.

The completely random titles were sometimes really funny but most of the time they were just... random. I changed the title selection so that it picks a title from one of the 3 panels.  Tap the title to get a new (random) one instead.

I think I'm done messing with this now. Probably ;)

