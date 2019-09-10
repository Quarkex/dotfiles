#set up an easy access for documentation
function doc
{
    pushd "/usr/share/doc/$1" && ls
}
export -f doc
