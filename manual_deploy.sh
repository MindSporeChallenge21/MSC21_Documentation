
set -e

# install the plugins and build the static site
gitbook install && gitbook build



echo " ==== CHECKING OUT TO GH-PAGES ==== "
# checkout to the gh-pages branch
git checkout gh-pages


echo " ==== REBASING GH-PAGES ==== "
# pull the latest updates
git pull origin gh-pages --rebase


echo " ==== REPLACING FILES AT ROOT ==== "
# copy the static site files into the current directory.
cp -R _book/* .

echo " ==== THROWING AWAY NODE MODULES ==== "
# remove 'node_modules' and '_book' directory
git clean -fx node_modules


echo " ==== THROWING AWAY _BOOK FOLDER ==== "
git clean -fx _book

echo " ==== TELL GITHUB PAGES THIS IS NOT A JEKYLL PROJECT SO IT WILL RESPECT FILES THAT START WITH DOT ==== "
touch .nojekyll

echo " ==== ADDING FILES TO COMMIT ==== "
# add all files
git add .


echo " ==== MAKING A COMMIT ==== "
# commit
git commit -a -m "Update docs"


echo " ==== PUSHING THE COMMIT ==== "
# push to the origin
git push origin gh-pages


echo " ==== COMING BACK TO MASTER ==== "
# checkout to the master branch
git checkout master