# what is this?

A thing that makes Webcomicname mash-up comics!

<a href="https://twitter.com/dorrismccomics/status/956575861523787783"><img src="https://cdn.glitch.com/13424d29-dc63-462f-8bdb-213dd069d44b%2FScreen%20Shot%202018-01-25%20at%204.47.23%20PM.png?1516916854332" /></a>


Remix this project and make it your own! 
<a href="https://glitch.com/edit/#!/remix/webcomicname-mashup">https://glitch.com/edit/#!/remix/webcomicname-mashup</a>

I saved a copy of the very first, <strong>minimal version</strong> in case you want to start there: 
<a href="https://glitch.com/edit/#!/remix/minimalist-webcomicname-mashup">https://glitch.com/edit/#!/remix/minimalist-webcomicname-mashup</a>



# how?

1. I snarfed the comics from webcomicname.com by using a $3 "Tumblelog Picture Downloader" app from the Mac App Store. There are several Tumblr picture download projects on Github if you'd rather try those.
2. Split the panels into 3 images with this Python code: <a href="http://bazaar.launchpad.net/~kpublicmail/comicstrip/devel/view/head:/comicstrip">comicstrip</a>.  The <a href="https://code.launchpad.net/~kpublicmail">original author</a> of this did all of the hard work 👏 `comicstrip` did a pretty great job and got all 3 panels from most of them. This shell script processes each one and names them with consecutive numbers. It could be improved by having it reuse a strip number if the correct number of panels are not found. That way there aren't gaps.

    ```
    ls -1 tumblr-downloader-images/*.jpg | nl | while read line; do
      parts=($line)
      index=${parts[0]}
      filename=${parts[1]}
      eval "./comicstrip -f $filename --min-width=160 --min-height=160 --prefix=strip_${index}_"
    done
    ```
    
    **NOTE:** The `comicstrip` script is from 2009 and it still runs fine  with Python 2.7 but it needs some minor changes to work with Pillow. Here are <a href="https://github.com/caseyf/webcomicname-mashup/commit/c1712cb9f282503beaedf2ad3be7bcaefbe441e9">my changes</a>.
  
  3. Now the filenames are all like `strip_[STRIP NUMBER]_[PANEL NUMBER].jpg` so  we can use Javascript to come up with 3 random panel image links and insert them into a page.   I dumped all of the images into Amazon S3 because it was easy. There is <a href="https://support.glitch.com/t/easier-way-to-reference-assets/394">probably a way</a> to store them in Glitch and still get predictable URLs.

4. The source for the rest is all here :) The <a href="https://glitch.com/edit/#!/remix/minimalist-webcomicname-mashup">minimal version</a> picks 3 random numbers between 1 and the # of panels, uses that to create the URL, and adds an IMG to the page for each one.

# oddities

The panels were automatically cropped and I didn't try to do anything more with the results. The borders don't always line up and the titles (or pieces of the titles in the 2nd panel, when the titles are long) still appear.

There are a couple weird/messed up panels that I haven't excluded.

All in all there are 708 panels.

## ← the source file, index.html

I crammed the HTML, CSS and Javascript into one page because Glitch has a request limit (makes sense, since this is all free!) and I hoped that it would help with "529 too many requests" when I first tweeted about this :/
