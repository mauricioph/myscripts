#!/bin/bash

[ `pwd` = "$HOME" ] && echo -e "You should not run this script on your home folder, it will mess your configs. \nPlease create a folder and run this script from there with all the messy files and subfolders inside it.\nIf you install this script in /usr/local/bin then it will create the folders on your home folder, but if you copy it to a folder and run from there it will organise only that folder." && exit

function installed(){
installation=false
[ "${0}" = "/usr/local/bin/organise-file.sh" ] && installation=True
echo "Running ${0}" 
}

function savehome(){
[ ! -d "${HOME}/${folder}" ] && mkdir -p "${HOME}/${folder}"

find $(pwd) -type f -iwholename "*.${1}" -exec mv "{}" "${HOME}/${folder}" \;
}

function savelocal(){
[ ! -d "${folder}" ] && mkdir -p "${folder}"

find $(pwd) -type f -iwholename "*.${1}" -exec mv "{}" "${folder}" \;
}

function define_folder(){
	case "${1}" in
	mp4) folder=Videos
	;;
	3g2) folder=Videos
	;;
	3gp) folder=Videos
	;;
	avi) folder=Videos
	;;
	flv) folder=Videos
	;;
	h264) folder=Videos
	;;
	m4v) folder=Videos
	;;
	mkv) folder=Videos
	;;
	mov) folder=Videos
	;;
	mpg) folder=Videos
	;;
	rm) folder=Videos
	;;
	swf) folder=Videos
	;;
	vob) folder=Videos
	;;
	wmv) folder=Videos
	;;
	webm) folder=Videos
	;;
	wpd) folder=Documents
	;;
	txt) folder=Documents
	;;
	tex) folder=Documents
	;;
	rtf) folder=Documents
	;;
	odt) folder=Documents
	;;
	docx) folder=Documents
	;;
	doc) folder=Documents
	;;
	bak) folder=System
	;;
	cab) folder=System
	;;
	cfg) folder=System
	;;
	cpl) folder=System
	;;
	cur) folder=System
	;;
	dll) folder=System
	;;
	dmp) folder=System
	;;
	drv) folder=System
	;;
	icns) folder=System
	;;
	ico) folder=System
	;;
	ini) folder=System
	;;
	lnk) folder=System
	;;
	msi) folder=System
	;;
	sys) folder=System
	;;
	tmp) folder=System
	;;
	ods) folder=Spreadsheet
	;;
	xls) folder=Spreadsheet
	;;
	xlsm) folder=Spreadsheet
	;;
	xlsx) folder=Spreadsheet
	;;
	c) folder=Program_code
	;;
	cgi) folder=Program_code
	;;
	pl) folder=Program_code
	;;
	php) folder=Program_code
	;;
	py) folder=Program_code
	;;
	class) folder=Program_code
	;;
	cpp) folder=Program_code
	;;
	cs) folder=Program_code
	;;
	h) folder=Program_code
	;;
	java) folder=Program_code
	;;
	py) folder=Program_code
	;;
	sh) folder=Program_code
	;;
	swift) folder=Program_code
	;;
	vb) folder=Program_code
	;;
	key) folder=Presentation
	;;
	odp) folder=Presentation
	;;
	pps) folder=Presentation
	;;
	ppt) folder=Presentation
	;;
	pptx) folder=Presentation
	;;
	asp) folder=Internet
	;;
	aspx) folder=Internet
	;;
	cer) folder=Internet
	;;
	cfm) folder=Internet
	;;
	cgi) folder=Internet
	;;
	css) folder=Internet
	;;
	htm) folder=Internet
	;;
	html) folder=Internet
	;;
	js) folder=Internet
	;;
	jsp) folder=Internet
	;;
	part) folder=Internet
	;;
	rss) folder=Internet
	;;
	xhtml) folder=Internet
	;;
	jpeg) folder=Photos
	;;
	jpg) folder=Photos
	;;
	png) folder=Photos
	;;
	ai) folder=Images
	;;
	bmp) folder=Images
	;;
	gif) folder=Images
	;;
	ico) folder=Images
	;;
	ps) folder=Images
	;;
	psd) folder=Images
	;;
	svg) folder=Images
	;;
	tif) folder=Images
	;;
	tiff) folder=Images
	;;
	fnt) folder=font_files
	;;
	fon) folder=font_files
	;;
	otf) folder=font_files
	;;
	ttf) folder=font_files
	;;
	apk) folder=Executable
	;;
	bat) folder=Executable
	;;
	exe) folder=Executable
	;;
	gadget) folder=Executable
	;;
	jar) folder=Executable
	;;
	msi) folder=Executable
	;;
	wsf) folder=Executable
	;;
	email) folder=Email
	;;
	eml) folder=Email
	;;
	emlx) folder=Email
	;;
	msg) folder=Email
	;;
	oft) folder=Email
	;;
	ost) folder=Email
	;;
	pst) folder=Email
	;;
	vcf) folder=Email
	;;
	csv) folder=Database
	;;
	dat) folder=Database
	;;
	db) folder=Database
	;;
	dbf) folder=Database
	;;
	log) folder=Database
	;;
	mdb) folder=Database
	;;
	sav) folder=Database
	;;
	sql) folder=Database
	;;
	tar) folder=Database
	;;
	xml) folder=Database
	;;
	bin) folder=Disc_Image
	;;
	dmg) folder=Disc_Image
	;;
	iso) folder=Disc_Image
	;;
	toast) folder=Disc_Image
	;;
	vcd) folder=Disc_Image
	;;
	7z) folder=Compressed_file
	;;
	arj) folder=Compressed_file
	;;
	deb) folder=Compressed_file
	;;
	pkg) folder=Compressed_file
	;;
	rar) folder=Compressed_file
	;;
	rpm) folder=Compressed_file
	;;
	tar.gz) folder=Compressed_file
	;;
	z) folder=Compressed_file
	;;
	zip) folder=Compressed_file
	;;
	aa) folder=Audio
	;;
	aac) folder=Audio
	;;
	aax) folder=Audio
	;;
	act) folder=Audio
	;;
	aiff) folder=Audio
	;;
	alac) folder=Audio
	;;
	amr) folder=Audio
	;;
	ape) folder=Audio
	;;
	au) folder=Audio
	;;
	awb) folder=Audio
	;;
	dss) folder=Audio
	;;
	dvf) folder=Audio
	;;
	flac) folder=Audio
	;;
	gsm) folder=Audio
	;;
	iklax) folder=Audio
	;;
	ivs) folder=Audio
	;;
	m4a) folder=Audio
	;;
	m4b) folder=Audio
	;;
	m4p) folder=Audio
	;;
	mmf) folder=Audio
	;;
	mp3) folder=Audio
	;;
	mpc) folder=Audio
	;;
	msv) folder=Audio
	;;
	nmf) folder=Audio
	;;
	ogg) folder=Audio
	;;
	oga) folder=Audio
	;;
	mogg) folder=Audio
	;;
	opus) folder=Audio
	;;
	org) folder=Audio
	;;
	ra) folder=Audio
	;;
	raw) folder=Audio
	;;
	rf64) folder=Audio
	;;
	sln) folder=Audio
	;;
	tta) folder=Audio
	;;
	voc) folder=Audio
	;;
	vox) folder=Audio
	;;
	wav) folder=Audio
	;;
	wma) folder=Audio
	;;
	wv) folder=Audio
	;;
	8svx) folder=Audio
	;;
	cda) folder=Audio
	;;
	epub) folder=Ebook
	;;
	mobi) folder=Ebook
	;;
	cbz) folder=Ebook
	;;
	cbr) folder=Ebook
	;;
	azw) folder=Ebook
	;;
	azw3) folder=Ebook
	;;
	pdf) folder=Ebook
	;;
	*) folder=Unknown
	;;
esac

}

for i in $(find $(pwd) -type f | sed 's/^.*\.//' | sort -u)
do echo "Checking ${i}"

define_folder ${i}
installed

[ "${installation}" = True ] && savehome ${i} || savelocal ${i}

done
