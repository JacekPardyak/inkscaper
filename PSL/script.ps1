$files = Get-ChildItem -Name ./PSL/*.svg
cd ./PSL
for ($i=0; $i -lt $files.Count; $i++) {

  inkscape --actions="export-type:emf;export-do" $files[$i]

}

