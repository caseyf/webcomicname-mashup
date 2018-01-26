# what is this?

More mash-up comics...

<a href="https://twitter.com/dorrismccomics/status/956575861523787783">https://twitter.com/dorrismccomics/status/956575861523787783"><img src="https://cdn.glitch.com/13424d29-dc63-462f-8bdb-213dd069d44b%2FScreen%20Shot%202018-01-25%20at%204.47.23%20PM.png?1516916854332" /></a>


Remix this project and make it your own! 
<a href="https://glitch.com/edit/#!/remix/webcomicname-mashup">https://glitch.com/edit/#!/remix/webcomicname-mashup</a>

I saved a copy of the very first, <strong>minimal version</strong> in case you want to start there: 
<a href="https://glitch.com/edit/#!/remix/minimalist-webcomicname-mashup">https://glitch.com/edit/#!/remix/minimalist-webcomicname-mashup</a>



# how?

1. I snarfed the comics from webcomicname.com by using a $3 Tumblr Downloader app from the Mac App Store
2. Split the panels into 3 images with this Python code: <a href="http://bazaar.launchpad.net/~kpublicmail/comicstrip/devel/view/head:/comicstrip">comicstrip</a>.  The <a href="https://code.launchpad.net/~kpublicmail">original author</a> of this did all of the hard work 👏 `comicstrip` did a pretty great job and got all 3 panels from most of them.
  `comicstrip -f file.jpg  --min-width=160 --min-height=160`
3. Dumped all of the images into Amazon S3 with names like `strip_[STRIP NUMBER]_[PANEL NUMBER].jpg` so that it would be easy to make up 3 random panel image links and insert them into a page.  I didn't store them in Glitch because the URLs wouldn't be predictable.


## ← the source file, index.html

I crammed the HTML, CSS and Javascript into one page because Glitch has a request limit (makes sense, since this is all free!) and I hoped that it would help with "529 too many requests" when I first tweeted about this :/
