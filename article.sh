#!/bin/bash

# Read the template from articles.html
template=$(cat article_template.html)

# Read the TOC template from articles_toc_template.html
toc_template=$(cat articles_toc_template.html)

# Initialize an empty string to store the TOC content
toc_content=""

# Loop through all HTML files in the unprocessed_articles directory
for file in unprocessed_articles/*.html; do
    # Check if the file is a regular file (not a directory)
    if [ -f "$file" ]; then
        # Read the content of the file
        content=$(cat "$file")
        
        # Replace the {ARTICLE} token in the template with the content
        new_content="${template//ARTICLE_TEMPLATE/${content}}"

        new_content=$(echo "$new_content" | sed 's/```html//g')
        new_content=$(echo "$new_content" | sed 's/```//g')


        # Extract the filename without the path
        filename=$(basename "$file")

        # Save the new content in the articles directory
        echo "$new_content" > "articles/${filename}"
        
        # Extract the date from the filename
        date=$(basename "$file" | cut -d'_' -f1)
        
        # Create a link for the TOC
        name=$(basename "$file" | cut -d'_' -f2- | sed 's/\.html$//' | tr '_' ' ')
        link="<a href='articles/${filename}'>${name}</a><br>"
        
        # Append the link to the TOC content
        toc_content="${toc_content}${link}"
    fi
done

#!/bin/bash

# Read the template from articles.html
template=$(cat article_template.html)

# Read the TOC template from articles_toc_template.html
toc_template=$(cat articles_toc_template.html)

# Initialize an empty string to store the TOC content
toc_content=""

# Loop through all HTML files in the articles directory
for file in articles/*.html; do
    # Check if the file is a regular file (not a directory)
    if [ -f "$file" ]; then
        # Extract the filename without the path
        filename=$(basename "$file")
        
        # Create a link for the TOC
        name=$(basename "$file" | sed 's/_/ /g')
        link="<a href='articles/${filename}'>${name}</a><br>"


        
        # Append the link to the TOC content
        toc_content="${toc_content}${link}"
    fi
done

# Replace the {TOC} token in the TOC template with the TOC content
new_toc_content="${toc_template//ARTICLES_TOC/${toc_content}}"

# Overwrite the articles_toc.html file with the new TOC content
echo "$new_toc_content" > articles_toc.html