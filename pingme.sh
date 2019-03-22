#!/bin/bash
scri="/home/mauricio/apps/wpscan/wpscan/wpscan.rb"
for i in addictioncleansingtherapy.org allaboutyouuk.com alvarolima.org chrissybshow.tv christianbooks-plus.com findinganswers.tv libertyradio.co.uk pt.alvarolima.com lovetalkshow.tv mylifeafterdepression.com nothingtolose.org.uk uckg.ie victoryyouthgroup.co.uk defendersofthegospel.com lovetherapy.co.uk uckg.org
do echo "Checking security of ${i}"
ruby ${scri} -u ${i} --random-agent --follow-redirection --batch -e u -e p -e t --log $HOME/scan-sites/${i}.txt
sleep 3;
done

