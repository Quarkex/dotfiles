function pdf2cbz {(
# Check dependencies
command -v zip >/dev/null 2>&1 || { echo >&2 "This command require zip but it's not installed. Aborting."; exit 1; }
command -v pdfimages >/dev/null 2>&1 || { echo >&2 "This command require pdfimages but it's not installed. Aborting."; exit 1; }
command -v pdfinfo >/dev/null 2>&1 || { echo >&2 "This command require pdfinfo but it's not installed. Aborting."; exit 1; }

# Test file type
filename=$(echo "$1" | sed 's/.*\///' );
type="$(file -b "$1")"
if [ "${type%%,*}" == "PDF document" ]; then
    name=$(echo "$1" | sed 's/\.pdf//' );
    echo "$filename is a PDF file.";

    # Create a temporal folder and move in
    mkdir ".pdf2cbz";
    cd ".pdf2cbz";

    # Extract images as jpegs using pdfimages
    echo "Extracting PDF images...";
    pdfimages -j "../$filename" "$name";

    count=`ls -1 *.ppm 2>/dev/null | wc -l`
    if [ $count != 0 ]
    then
        echo "Images obtained in ppm format. Converting to jpg...";
        for g in *.ppm; do convert "$g" "$g.jpg"; done;
            rm *.ppm;
            rename 's/\.ppm//' *.jpg;
        fi

        # Add the metadata file
        echo "Creating metadata file...";
        touch "Comicinfo.xml";
        echo '<?xml version="1.0"?>' >> "Comicinfo.xml";
        echo '<ComicInfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">' >> "Comicinfo.xml";
        echo "<Title>$name</Title>" >> "Comicinfo.xml";
        echo "<Summary>$(pdfinfo "../$filename" | grep "Subject:" | sed 's/Subject:\s*//')</Summary>" >> "Comicinfo.xml";
        echo "<Keywords>$(pdfinfo "../$filename" | grep "Keywords:" | sed 's/Keywords:\s*//')</Keywords>" >> "Comicinfo.xml";
        echo "<Author>$(pdfinfo "../$filename" | grep "Author:" | sed 's/Author:\s*//')</Author>" >> "Comicinfo.xml";
        echo "<Publisher>$(pdfinfo "../$filename" | grep "Producer:" | sed 's/Producer:\s*//')</Publisher>" >> "Comicinfo.xml";
        echo "<PageCount>$(pdfinfo "../$filename" | grep "Pages:" | sed 's/Pages:\s*//')</PageCount>" >> "Comicinfo.xml";
        echo '</ComicInfo>' >> "Comicinfo.xml";

        # Move the original pdf inside
        mv "../$filename" "./$filename";

        # Zip all the files
        echo "Creating zip file...";
        zip "$name" *;

        # Move the final file out as a cbz and remove the temporal folder
        mv "$name.zip" "../$name.cbz";
        cd "..";
        echo "Cleaning up...";
        rm -r ".pdf2cbz";
        echo "Done.";
    else
        echo "$filename is not a PDF file.";
    fi
)}
