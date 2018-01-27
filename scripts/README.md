## contents:

* 'ohno_title_splitter.rb': Ruby code to detect the location of a title in an "oh no!" style comic and extract it and/or remove it
* 'comicstrip':  comic panel splitting Python code by David Koo
* `latest_webcomicname_comics.rb`: prints out a list of the latest high resolution comic images from webcomicname.com


* `processlatest`: uses this pile of scripts to look for new webcomicname.com comics and process them

1. use `latest_webcomicname_comics.rb` to parse the RSS feed and grab all of the comic URLs
2. compare with a saved file (`stripnumbers.txt`) to see if there is anything new
3. if there is something new, download it and continue
4. split into panels with `comicstrip`
5. extract the title with `ohno_title_splitter.rb`
6. rewrite the 3 panels with the title removed with `ohno_title_splitter.rb`
7. update `stripnumbers.txt` and also create a `stripnumbers.json` that the site can use
8. store everything in AWS

It doesn't do any error checking at the moment. It should probably quit and update the `stripnumbers.txt` with an IGNORE line if the 3 panels cannot be split out.
