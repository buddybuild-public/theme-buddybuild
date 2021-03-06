#! /bin/bash

NPM_DIR=`npm bin`

# Cleanup folder
rm -rf _assets

# Recreate folder
mkdir -p _assets/website/
mkdir -p _assets/ebook/

# Compile JS
${NPM_DIR}/browserify src/js/core/index.js | ${NPM_DIR}/uglifyjs -mc > _assets/website/gitbook.js
${NPM_DIR}/browserify src/js/theme/index.js | ${NPM_DIR}/uglifyjs -mc > _assets/website/theme.js

# Compile Website CSS
${NPM_DIR}/lessc -clean-css src/less/website.less _assets/website/style.css

# Compile eBook CSS
${NPM_DIR}/lessc -clean-css src/less/ebook.less _assets/ebook/ebook.css
${NPM_DIR}/lessc -clean-css src/less/pdf.less _assets/ebook/pdf.css
${NPM_DIR}/lessc -clean-css src/less/mobi.less _assets/ebook/mobi.css
${NPM_DIR}/lessc -clean-css src/less/epub.less _assets/ebook/epub.css

# Copy fonts
mkdir -p _assets/website/fonts
cp -R node_modules/font-awesome/fonts/ _assets/website/fonts/fontawesome/

# Copy vendor javascript
cp -a src/js/medium-zoom _assets/website/

# Copy icons
mkdir -p _assets/website/images
