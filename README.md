# Crawl

This is a simple web crawler that uses bash to download the page source of a website and extract ALL links off of it.
It then adds all those links to a list after all of them extracted. The script goes through each link and adds the new
links to the same ".txt" file before proceeding to the next. The script also watches for duplicate links although some
may find their way in.

**THIS CRAWLER DOES NOT RESPECT ROBOTS.TXT. PLEASE TEST IT ON YOUR OWN SERVER OR IN A CONTROLLED ENVIRONMENT**
