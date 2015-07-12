tmp="$(dirname -- $0)/tmp"

if [ -d "$tmp" ]; then
  printf '%s\n' "Removing ($tmp)"
  rm -rf "$tmp"
fi

mkdir $tmp
cd $tmp
git clone git@github.com:summernote/summernote.git -b master
cd summernote
npm install
grunt dist
git commit -am "Update dist files"
git push https://hackerwins:$GITHUB_TOKEN@github.com/summernote/summernote.git master
